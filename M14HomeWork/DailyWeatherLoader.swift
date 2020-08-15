//
//  DailyWeatherLoader.swift
//  M14HomeWork
//
//  Created by Владислав Белов on 07.08.2020.
//  Copyright © 2020 Владислав Белов. All rights reserved.
//

import Foundation
import RealmSwift

class DailyWeatherLoader{
    var realm = try! Realm()
    
       var dailyDataArray: Results<DailyRealmData> {
           get{
               return realm.objects(DailyRealmData.self)
           }
       }
    
  
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "EEEE"
        
        
        return dateFormatter
    }()
    
    
    func getDailyWeather(completion: @escaping ([SevenDayWeather]) -> Void){
        let url = URL(string: "https://api.openweathermap.org/data/2.5/onecall?lat=55.751244&lon=37.618423&exclude=current,minutely,hourly&appid=ecef450927c9c4ace074f346a81214ec&lang=ru&units=metric")!
       
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
     if let error = error{
                           print("ERROR: \(error.localizedDescription)")
                           debugPrint(error)
                       }
                       if let data = data{
                           var DailyWeatherResult: DailyWeather?
                           do{
                               
                            DailyWeatherResult = try JSONDecoder().decode(DailyWeather.self, from: data)
                               
                           } catch{print("ERROR: \(error.localizedDescription)")
                               debugPrint(error)
                           }
                          guard let json = DailyWeatherResult else{
                            return print(debugPrint(error?.localizedDescription as Any))
                           }
                        
                        DispatchQueue.main.async {
                            try! self.realm.write{
                                self.realm.delete(self.dailyDataArray)
                            }
                            var dailyWeatherArray: [SevenDayWeather] = []
                            for obj in 0..<json.daily.count{

                                let weekdayDate = Date(timeIntervalSince1970: TimeInterval(Int(json.daily[obj].dt)))
                                
                                let dailyWeekDay = self.dateFormatter.string(from: weekdayDate)
                        
                                let dailyIcon = json.daily[obj].weather[0].icon
                                let DayHigh = Int(json.daily[obj].temp.max)
                                let Daylow = Int(json.daily[obj].temp.min)
                        
                    
                        
                        let dailyResult = SevenDayWeather(weekDay: dailyWeekDay, DayHigh: DayHigh, DayLow: Daylow, DailyIcon : dailyIcon)
                            dailyWeatherArray.append(dailyResult)
                                print("\(dailyResult.weekDay), \(dailyResult.DayHigh), \(dailyResult.DayLow),\(dailyResult.DailyIcon)")
                                
                                let realm = try! Realm()
                                let dailyItem = DailyRealmData()
                               try! realm.write{
                                dailyItem.dayData = dailyResult.weekDay
                                dailyItem.DayHightData = "\(dailyResult.DayHigh)°C"
                                dailyItem.DayLowData = "\(dailyResult.DayLow)°C"
                                dailyItem.DailyIconData = dailyResult.DailyIcon
                                realm.add(dailyItem)
                                
                                }
                                
                                
                            }
                         
                            
                            
                            print(dailyWeatherArray)
                            print(self.dailyDataArray)
                            
                        completion(dailyWeatherArray)
                            
                        
                        }
           
                           }
       
}

        task.resume()
}
}

