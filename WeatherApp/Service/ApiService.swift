//
//  ApiService.swift
//  WeatherApp
//
//  Created by Shubham Sahgal on 19/09/24.
//

import Foundation

protocol APIServiceProtocol {
    
    func getCurrentWeather(for latitude:Double,and longitude:Double,complete: @escaping ( _ success: Bool, _ currentWeather: CurrentWeather?, _ error: Error? )->() )
    
    func getCities(forSearch searchQuery:String,complete: @escaping ( _ success: Bool, _ cities: CityDetail?, _ error: Error? )->() )
    
    func getWeatherForecast(for latitude:Double,and longitude:Double,complete: @escaping ( _ success: Bool, _ forecast: Forecast?, _ error: Error? )->() )
}

private let sessionManager: URLSession = {
    let urlSessionConfiguration: URLSessionConfiguration = URLSessionConfiguration.default
    return URLSession(configuration: urlSessionConfiguration, delegate: nil, delegateQueue: nil)
}()

class APIService: APIServiceProtocol {
    
    func getWeatherForecast(for latitude: Double, and longitude: Double, complete: @escaping (_ success:Bool, _ forecast:Forecast?, _ error : Error?) -> ()) {
        let queryItems = [URLQueryItem(name: "lat", value: "\(latitude)"),
                          URLQueryItem(name: "lon", value: "\(longitude)"),
                          URLQueryItem(name: "units", value: "metric"),
                          URLQueryItem(name: "appid", value: APIServiceConstants.APIKey)]
        
        sessionManager.dataTask(with: getRequest(api: APIServiceConstants.ForecastAPI, queryparameter: queryItems)) { (data, response, error) in
            
            guard error == nil else {
                complete( false,nil, error )
                return
            }
            
            let response = try? JSONDecoder().decode(Forecast.self, from: data!)
            
            if let forecast = response, forecast.cod == "200"  {
                complete( true, forecast, nil )
            }
            else{
            }
        }.resume()
        
    }
    
    func getCities(forSearch searchQuery: String, complete: @escaping ( _ success: Bool, _ cities: CityDetail?, _ error: Error? )->() ) {
        let queryItems = [URLQueryItem(name: "q", value: "\(searchQuery)"),
                          URLQueryItem(name: "limit", value: "5"),
                          URLQueryItem(name: "appid", value: APIServiceConstants.APIKey)]
        
        sessionManager.dataTask(with: getRequest(api: APIServiceConstants.SearchCitiesAPI, queryparameter: queryItems)) { (data, response, error) in

            guard error == nil else {
                complete( false,nil, error )
                return
            }
            
            let response = try? JSONDecoder().decode(CityDetail.self, from: data!)
            
            if let cities = response, !cities.isEmpty  {
                complete( true, cities, nil )
            }
            else{
            }
        }.resume()
    }
    
    
    func getCurrentWeather(for latitude:Double,and longitude:Double, complete: @escaping ( _ success: Bool, _ results: CurrentWeather?, _ error: Error? )->() ) {
        
        let queryItems = [URLQueryItem(name: "lat", value: "\(latitude)"),
                          URLQueryItem(name: "lon", value: "\(longitude)"),
                          URLQueryItem(name: "units", value: "metric"),
                          URLQueryItem(name: "appid", value: APIServiceConstants.APIKey)]
        
        sessionManager.dataTask(with: getRequest(api: APIServiceConstants.CurrentWeatherAPI, queryparameter: queryItems)) { (data, response, error) in
            
            guard error == nil else {
                complete( false,nil, error )
                return
            }
            
            let response = try? JSONDecoder().decode(CurrentWeather.self, from: data!)
            
            if let currentWeather = response, currentWeather.cod == 200  {
                complete( true, currentWeather, nil )
            }
            else{
            }
        }.resume()
        
    }
    
    
    
    private func getRequest(api:String,queryparameter:[URLQueryItem]) -> URLRequest
    {
        var urlComps = URLComponents(string: "\(APIServiceConstants.BaseURL)\(api)")!
        urlComps.queryItems = queryparameter
        let result = urlComps.url!
        return URLRequest(url: result);
    }
}
