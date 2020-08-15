import Foundation
import RealmSwift


class RealmObject: Object{
    @objc dynamic var storageCity: String = ""
    @objc dynamic var storageTemp: String = ""
    @objc dynamic var storageDescription: String = ""
    
    
}

class CurrentWeatherItem{
    var city = ""
    var weatherDescription = ""
    var temp = ""
   
    
}



// MARK: - CurrentWeather
struct CurrentWeather: Codable {
    let coord: Coord
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone: Int
    let id: Int
    let name: String
    let cod: Int

    enum CodingKeys: String, CodingKey {
        case coord = "coord"
        case weather = "weather"
        case base = "base"
        case main = "main"
        case visibility = "visibility"
       
        case clouds = "clouds"
        case dt = "dt"
        case sys = "sys"
        case timezone = "timezone"
        case id = "id"
        case name = "name"
        case cod = "cod"
    }
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int

    enum CodingKeys: String, CodingKey {
        case all = "all"
    }
}

// MARK: - Coord
struct Coord: Codable {
    let lon: Double
    let lat: Double

    enum CodingKeys: String, CodingKey {
        case lon = "lon"
        case lat = "lat"
    }
}

// MARK: - Main
struct Main: Codable {
    let temp: Double
    let feelsLike: Double
    let tempMin: Double
    let tempMax: Double
    let pressure: Int
    let humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp = "temp"
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure = "pressure"
        case humidity = "humidity"
    }
}

// MARK: - Sys
struct Sys: Codable {
    let type: Int
    let id: Int
    let country: String
    let sunrise: Int
    let sunset: Int

    enum CodingKeys: String, CodingKey {
        case type = "type"
        case id = "id"
        case country = "country"
        case sunrise = "sunrise"
        case sunset = "sunset"
    }
}

// MARK: - Weather
struct Weather: Codable {
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










