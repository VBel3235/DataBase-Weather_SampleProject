//
//  CurrentWeatherLoader.swift
//  M14HomeWork
//
//  Created by Владислав Белов on 07.08.2020.
//  Copyright © 2020 Владислав Белов. All rights reserved.
//

import Foundation
import UIKit


class CurrentWeatherLoader{

    func loadWeather(completion: @escaping (CurrentWeatherItem) -> Void){
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=Moscow&appid=ecef450927c9c4ace074f346a81214ec&lang=ru&units=metric")!
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: {data, response, error in
            if let error = error{
                print("ERROR: \(error.localizedDescription)")
                debugPrint(error)
            }
            if let data = data{
                var WeatherResult: CurrentWeather?
                do{
                    
                    WeatherResult = try JSONDecoder().decode(CurrentWeather.self, from: data)
                    
                } catch{print("ERROR: \(error.localizedDescription)")
                    debugPrint(error)
                }
               guard let json = WeatherResult else{
                    return
                }
                DispatchQueue.main.async {
                    let item = CurrentWeatherItem()
                    item.city = json.name
                    item.temp = "\(Int(json.main.temp))"
                    item.weatherDescription = json.weather[0].weatherDescription
                    print(item)
                    
                    completion(item)
                    
                }
      
}
        
})
        task.resume()
}
}
