//
//  CityDetails.swift
//  WeatherApp
//
//  Created by Shubham Sahgal on 19/09/24.
//
import Foundation

// MARK: - CityDetailElement
struct CityDetailElement: Codable {
    let name : String?
    let local_names : LocalNames?
    let lat : Double?
    let lon : Double?
    let country : String?
    let state : String?

    enum CodingKeys: String, CodingKey {

        case name = "name"
        case local_names = "local_names"
        case lat = "lat"
        case lon = "lon"
        case country = "country"
        case state = "state"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        local_names = try values.decodeIfPresent(LocalNames.self, forKey: .local_names)
        lat = try values.decodeIfPresent(Double.self, forKey: .lat)
        lon = try values.decodeIfPresent(Double.self, forKey: .lon)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        state = try values.decodeIfPresent(String.self, forKey: .state)
    }

}


// MARK: - LocalNames
struct LocalNames: Codable {
    let kn : String?
    let ja : String?
    let mr : String?
    let hi : String?
    let pa : String?
    let he : String?
    let ur : String?
    let ml : String?
    let ru : String?
    let en : String?
    let ar : String?
    let ta : String?
    let zh : String?
    let cs : String?

    enum CodingKeys: String, CodingKey {

        case kn = "kn"
        case ja = "ja"
        case mr = "mr"
        case hi = "hi"
        case pa = "pa"
        case he = "he"
        case ur = "ur"
        case ml = "ml"
        case ru = "ru"
        case en = "en"
        case ar = "ar"
        case ta = "ta"
        case zh = "zh"
        case cs = "cs"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        kn = try values.decodeIfPresent(String.self, forKey: .kn)
        ja = try values.decodeIfPresent(String.self, forKey: .ja)
        mr = try values.decodeIfPresent(String.self, forKey: .mr)
        hi = try values.decodeIfPresent(String.self, forKey: .hi)
        pa = try values.decodeIfPresent(String.self, forKey: .pa)
        he = try values.decodeIfPresent(String.self, forKey: .he)
        ur = try values.decodeIfPresent(String.self, forKey: .ur)
        ml = try values.decodeIfPresent(String.self, forKey: .ml)
        ru = try values.decodeIfPresent(String.self, forKey: .ru)
        en = try values.decodeIfPresent(String.self, forKey: .en)
        ar = try values.decodeIfPresent(String.self, forKey: .ar)
        ta = try values.decodeIfPresent(String.self, forKey: .ta)
        zh = try values.decodeIfPresent(String.self, forKey: .zh)
        cs = try values.decodeIfPresent(String.self, forKey: .cs)
    }

}


typealias CityDetail = [CityDetailElement]

