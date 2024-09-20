//
//  Constant.swift
//  WeatherApp
//
//  Created by Shubham Sahgal on 19/09/24.
//

import Foundation

struct APIServiceConstants
{
    static var APIKey : String {
        Bundle.main.object(forInfoDictionaryKey: "OpenWeatherAppAPIKey") as? String ?? "";
    }
    static var BaseURL : String {
        Bundle.main.object(forInfoDictionaryKey: "BaseURL") as? String ?? "";
    }
    
    static let CurrentWeatherAPI = "data/2.5/weather";
    static let SearchCitiesAPI = "geo/1.0/direct";
    static let ForecastAPI = "data/2.5/forecast";
}

struct UserDefaultKeys
{
    static let CityLatitude = "CityLatitude"
    static let CityLongitute = "CityLongitute"
    static let CityName = "CityName"
}

