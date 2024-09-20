//
//  Forecast.swift
//  WeatherApp
//
//  Created by Shubham Sahgal on 19/09/24.
//

import Foundation

// MARK: - Forecast
struct Forecast: Codable {
    let cod : String?
    let message : Int?
    let cnt : Int?
    let list : [List]?
    let city : City?

    enum CodingKeys: String, CodingKey {

        case cod = "cod"
        case message = "message"
        case cnt = "cnt"
        case list = "list"
        case city = "city"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        cod = try values.decodeIfPresent(String.self, forKey: .cod)
        message = try values.decodeIfPresent(Int.self, forKey: .message)
        cnt = try values.decodeIfPresent(Int.self, forKey: .cnt)
        list = try values.decodeIfPresent([List].self, forKey: .list)
        city = try values.decodeIfPresent(City.self, forKey: .city)
    }

}


// MARK: - City
struct City: Codable {
    let id : Int?
    let name : String?
    let coord : CCoord?
    let country : String?
    let population : Int?
    let timezone : Int?
    let sunrise : Int?
    let sunset : Int?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case coord = "coord"
        case country = "country"
        case population = "population"
        case timezone = "timezone"
        case sunrise = "sunrise"
        case sunset = "sunset"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        coord = try values.decodeIfPresent(CCoord.self, forKey: .coord)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        population = try values.decodeIfPresent(Int.self, forKey: .population)
        timezone = try values.decodeIfPresent(Int.self, forKey: .timezone)
        sunrise = try values.decodeIfPresent(Int.self, forKey: .sunrise)
        sunset = try values.decodeIfPresent(Int.self, forKey: .sunset)
    }

}

// MARK: - Coord
struct CCoord: Codable {
    let lat : Double?
    let lon : Double?

    enum CodingKeys: String, CodingKey {

        case lat = "lat"
        case lon = "lon"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        lat = try values.decodeIfPresent(Double.self, forKey: .lat)
        lon = try values.decodeIfPresent(Double.self, forKey: .lon)
    }

}

// MARK: - List
struct List: Codable {
    let dt : Int?
    let main : Main?
    let weather : [Weather]?
    let clouds : Clouds?
    let wind : Wind?
    let visibility : Int?
    let pop : Double?
    let rain : Rain?
    let sys : Sys?
    let dt_txt : String?

    enum CodingKeys: String, CodingKey {

        case dt = "dt"
        case main = "main"
        case weather = "weather"
        case clouds = "clouds"
        case wind = "wind"
        case visibility = "visibility"
        case pop = "pop"
        case rain = "rain"
        case sys = "sys"
        case dt_txt = "dt_txt"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        dt = try values.decodeIfPresent(Int.self, forKey: .dt)
        main = try values.decodeIfPresent(Main.self, forKey: .main)
        weather = try values.decodeIfPresent([Weather].self, forKey: .weather)
        clouds = try values.decodeIfPresent(Clouds.self, forKey: .clouds)
        wind = try values.decodeIfPresent(Wind.self, forKey: .wind)
        visibility = try values.decodeIfPresent(Int.self, forKey: .visibility)
        pop = try values.decodeIfPresent(Double.self, forKey: .pop)
        rain = try values.decodeIfPresent(Rain.self, forKey: .rain)
        sys = try values.decodeIfPresent(Sys.self, forKey: .sys)
        dt_txt = try values.decodeIfPresent(String.self, forKey: .dt_txt)?.components(separatedBy: " ")[0]
    }

}

// MARK: - Clouds
struct Clouds: Codable {
    let all : Int?

    enum CodingKeys: String, CodingKey {

        case all = "all"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        all = try values.decodeIfPresent(Int.self, forKey: .all)
    }

}

// MARK: - MainClass
struct MainClass: Codable {
    let temp : Double?
    let feels_like : Double?
    let temp_min : Double?
    let temp_max : Double?
    let pressure : Int?
    let sea_level : Int?
    let grnd_level : Int?
    let humidity : Int?
    let temp_kf : Double?

    enum CodingKeys: String, CodingKey {

        case temp = "temp"
        case feels_like = "feels_like"
        case temp_min = "temp_min"
        case temp_max = "temp_max"
        case pressure = "pressure"
        case sea_level = "sea_level"
        case grnd_level = "grnd_level"
        case humidity = "humidity"
        case temp_kf = "temp_kf"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        temp = try values.decodeIfPresent(Double.self, forKey: .temp)
        feels_like = try values.decodeIfPresent(Double.self, forKey: .feels_like)
        temp_min = try values.decodeIfPresent(Double.self, forKey: .temp_min)
        temp_max = try values.decodeIfPresent(Double.self, forKey: .temp_max)
        pressure = try values.decodeIfPresent(Int.self, forKey: .pressure)
        sea_level = try values.decodeIfPresent(Int.self, forKey: .sea_level)
        grnd_level = try values.decodeIfPresent(Int.self, forKey: .grnd_level)
        humidity = try values.decodeIfPresent(Int.self, forKey: .humidity)
        temp_kf = try values.decodeIfPresent(Double.self, forKey: .temp_kf)
    }

}


// MARK: - Rain
struct Rain: Codable {
    let Threeh : Double?

    enum CodingKeys: String, CodingKey {

        case Threeh = "3h"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        Threeh = try values.decodeIfPresent(Double.self, forKey: .Threeh)
    }

}

// MARK: - Sys
struct Sys: Codable {
    let pod : String?

    enum CodingKeys: String, CodingKey {

        case pod = "pod"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        pod = try values.decodeIfPresent(String.self, forKey: .pod)
    }

}

enum Pod: String, Codable {
    case d = "d"
    case n = "n"
}

// MARK: - Weather
struct Weather: Codable {
    let id : Int?
    let main : String?
    let description : String?
    let icon : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case main = "main"
        case description = "description"
        case icon = "icon"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        main = try values.decodeIfPresent(String.self, forKey: .main)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        icon = try values.decodeIfPresent(String.self, forKey: .icon)
    }

}


enum Description: String, Codable {
    case brokenClouds = "broken clouds"
    case fewClouds = "few clouds"
    case lightRain = "light rain"
    case overcastClouds = "overcast clouds"
    case scatteredClouds = "scattered clouds"
}

enum Icon: String, Codable {
    case the02N = "02n"
    case the03N = "03n"
    case the04D = "04d"
    case the04N = "04n"
    case the10D = "10d"
    case the10N = "10n"
}

enum MainEnum: String, Codable {
    case clouds = "Clouds"
    case rain = "Rain"
}

// MARK: - Wind
struct Wind: Codable {
    let speed : Double?
    let deg : Int?
    let gust : Double?

    enum CodingKeys: String, CodingKey {

        case speed = "speed"
        case deg = "deg"
        case gust = "gust"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        speed = try values.decodeIfPresent(Double.self, forKey: .speed)
        deg = try values.decodeIfPresent(Int.self, forKey: .deg)
        gust = try values.decodeIfPresent(Double.self, forKey: .gust)
    }

}

