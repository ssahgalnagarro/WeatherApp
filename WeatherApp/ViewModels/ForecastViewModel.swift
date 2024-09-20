//
//  ForecastViewModel.swift
//  WeatherApp
//
//  Created by Shubham Sahgal on 20/09/24.
//

import Foundation
import UIKit
import CoreLocation
class ForecastViewModel{
    
    var apiService: APIServiceProtocol
    
    var currentWeather: CurrentWeatherItemModel = CurrentWeatherItemModel()
    {
        didSet
        {
            self.updateCurrentWeatherConditions?()
        }
    }
    
    private var cellViewModels: [ForecastCellViewItemModel] = [ForecastCellViewItemModel]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    
    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    var updateCurrentWeatherConditions: (()->())?
    var reloadTableViewClosure: (()->())?
    
    init( apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    func getCurrentWeatherConditionAndForecast(lat:Double,long:Double)
    {
        apiService.getCurrentWeather(for: lat, and: long){ [weak self] (success, results, error) in
           
            if let error = error {
               
            } else {
                self?.processCurrentWeatherData(currentWeather: results);
            }
        }
        
        apiService.getWeatherForecast(for: lat, and: long){ [weak self] (success, results, error) in
           
            if let error = error {
                
            } else {
                self?.processWeatherForecastData(forecast: results);
            }
        }
    }
    
    func getCellViewModel( at indexPath: IndexPath ) -> ForecastCellViewItemModel {
        return cellViewModels[indexPath.row]
    }
    
    private func processCurrentWeatherData( currentWeather: CurrentWeather? ) {
        guard let currentWeather = currentWeather else
        {
            return;
        }
        let tempareture = currentWeather.main?.temp ?? 0.0;
        let cityName = currentWeather.name ?? "";
        let humdity = currentWeather.main?.humidity ?? 0;
        let wind = currentWeather.wind?.speed ?? 0.0;
        let description = currentWeather.weather?[0].description ?? "";
        
        self.currentWeather = CurrentWeatherItemModel(tempareture: tempareture, cityName: cityName, windSpeed: wind, humidity: humdity, weatherDescription: description);
    }
    
    private func processWeatherForecastData( forecast: Forecast? ) {
        guard let forecast = forecast,let forecastList = forecast.list else {
            return;
        }
        
        var forecastDictionary : [String:List] = [:];
        var forecastTableViewModel : [ForecastCellViewItemModel] = []
        for dayForecast in forecastList
        {
            if (forecastDictionary.keys.contains(dayForecast.dt_txt!)) {
                continue;
            }
            forecastDictionary[dayForecast.dt_txt!] = dayForecast;
            
            let dateText = dayForecast.dt_txt ?? "";
            let dailyLow = dayForecast.main?.temp_min ?? 0.0;
            let dailyHigh = dayForecast.main?.temp_max ?? 0.0;
            let weatherDescription = dayForecast.weather?[0].description ?? "";
            
            forecastTableViewModel.append(ForecastCellViewItemModel(datetext: dateText, highTempareture: dailyHigh, forecastDescription: weatherDescription, lowTempareture: dailyLow))
        }
        forecastTableViewModel.remove(at: 0);
        cellViewModels = forecastTableViewModel;
    }
}


struct CurrentWeatherItemModel
{
    var tempareture:Double = 0.0
    var cityName:String = ""
    var windSpeed:Double = 0.0
    var humidity:Int = 0
    var weatherDescription:String = ""
}

struct ForecastCellViewItemModel
{
    var datetext :String
    var highTempareture:Double
    var forecastDescription:String
    var lowTempareture:Double
}
