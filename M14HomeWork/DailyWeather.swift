//
//  DailyWeather.swift
//  M14HomeWork
//
//  Created by Владислав Белов on 07.08.2020.
//  Copyright © 2020 Владислав Белов. All rights reserved.
//

import Foundation
import RealmSwift
class DailyRealmData: Object{
    @objc dynamic var dayData: String = ""
        @objc dynamic var DayHightData: String = ""
        @objc dynamic var DayLowData: String = ""
        @objc dynamic var DailyIconData: String = ""
}

struct SevenDayWeather: Codable{
    var weekDay: String
    var DayHigh: Int
    var DayLow: Int
    var DailyIcon: String
    
    enum CodingKeys: String, CodingKey{
    case weekDay = "dt"
    case DayHigh = "max"
    case DayLow = "min"
    case DailyIcon = "icon"
    }
    
    
}

import Foundation

// MARK: - DailyWeather
struct DailyWeather: Codable {
    let daily: [Daily]

    enum CodingKeys: String, CodingKey {
        case daily = "daily"
    }

}

// MARK: - Daily
struct Daily: Codable {
    let dt: Int
    let sunrise: Int
    let sunset: Int
    let temp: Temp
    let feelsLike: FeelsLike
    let pressure: Int
    let humidity: Int
    let dewPoint: Double
    let windSpeed: Double
    let windDeg: Int
    let weather: [WeekWeather]
    let clouds: Int
    let pop: Double
    let rain: Double?
    
    

    enum CodingKeys: String, CodingKey {
        case dt = "dt"
        case sunrise = "sunrise"
        case sunset = "sunset"
        case temp = "temp"
        case feelsLike = "feels_like"
        case pressure = "pressure"
        case humidity = "humidity"
        case dewPoint = "dew_point"
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case weather = "weather"
        case clouds = "clouds"
        case pop = "pop"
        case rain = "rain"
       
        
    }

}

// MARK: - FeelsLike
struct FeelsLike: Codable {
    let day: Double
    let night: Double
    let eve: Double
    let morn: Double

    enum CodingKeys: String, CodingKey {
        case day = "day"
        case night = "night"
        case eve = "eve"
        case morn = "morn"
    }
}

// MARK: - Temp
struct Temp: Codable {
    let day: Double
    let min: Double
    let max: Double
    let night: Double
    let eve: Double
    let morn: Double

    enum CodingKeys: String, CodingKey {
        case day = "day"
        case min = "min"
        case max = "max"
        case night = "night"
        case eve = "eve"
        case morn = "morn"
    }
}

// MARK: - Weather
struct WeekWeather: Codable {
    let id: Int
    let main: String
    let weatherDescription: String
    let icon: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case main = "main"
        case weatherDescription = "description"
        case icon = "icon"
    }
}

