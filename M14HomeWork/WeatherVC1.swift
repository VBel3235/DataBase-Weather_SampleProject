//
//  WeatherViewController.swift
//  M14HomeWork
//
//  Created by Владислав Белов on 07.08.2020.
//  Copyright © 2020 Владислав Белов. All rights reserved.
//

import UIKit
import RealmSwift




class WeatherVC1: UIViewController {
    
   
    @IBOutlet weak var GradientBackgroundview: UIView!
    
    
var realm = try! Realm()
   

    @IBOutlet weak var TempLabel: UILabel!
    
    @IBOutlet weak var CityLabel: UILabel!
    
    @IBOutlet weak var DailyWeatherTableView: UITableView!
    
    var dailyDataArray: Results<DailyRealmData> {
        get{
            return realm.objects(DailyRealmData.self)
        }
    }

    var currentDataArray: Results<RealmObject> {
        get {
            return realm.objects(RealmObject.self)
        }
    }
  
    
    
    
    @IBOutlet weak var DescriptionLabel: UILabel!
    
    
    
    
    var dailyWeatherArray: [SevenDayWeather] = []
    
    var gradientLayer: CAGradientLayer!
    override func viewDidLoad() {
        
        
        
        super.viewDidLoad()
      let path = NSHomeDirectory().appending("/Documents/")
        print(path)
        
     
        print(dailyDataArray.count)
     print(dailyDataArray)
        print(dailyWeatherArray)
        

       fetchData()
        deleteData()
        
}
    
    func fetchData(){
        for i in currentDataArray{
            CityLabel.text = i.storageCity
            TempLabel.text =  i.storageTemp
            DescriptionLabel.text =  i.storageDescription
        }
    }
    func deleteData(){

        try! self.realm.write{
           
            self.realm.delete(currentDataArray)
           
        }


    }
    override func viewDidAppear(_ animated: Bool) {
         
        super.viewDidAppear(animated)
        createFradientLayer()
        
//       Текущая погода
        CurrentWeatherLoader().loadWeather(completion: { (item) in
           
         
            self.CityLabel.text = item.city
            
            self.TempLabel.text = item.temp + "°C"
            self.DescriptionLabel.text = item.weatherDescription.capitalized
            
             let CurrentItem = RealmObject()

            CurrentItem.storageCity = self.CityLabel.text!
            CurrentItem.storageTemp = self.TempLabel.text!
            CurrentItem.storageDescription = self.DescriptionLabel.text!
                      try! self.realm.write{
                        
                        
                                            self.realm.add(CurrentItem)

                                        }
           
        })

        
//        Погода на 7 дней
        
            DailyWeatherLoader().getDailyWeather{ dailyWeatherArray in
                
                self.DailyWeatherTableView.reloadData()
                self.dailyWeatherArray = dailyWeatherArray
                self.DailyWeatherTableView.reloadData()
                self.DailyWeatherTableView.layer.cornerRadius = 20
               
                self.DailyWeatherTableView.layer.shadowOffset = CGSize(width: 8, height: 8)
                self.DailyWeatherTableView.layer.shadowRadius = 9
                self.DailyWeatherTableView.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                let blurEffect = UIBlurEffect(style: .extraLight)
                let blurEffectView = UIVisualEffectView(effect: blurEffect)
                blurEffectView.frame = self.view.frame
            
                
                
            
                
                
                print(dailyWeatherArray.count)
                
                
            }
        
  
}
    func createFradientLayer(){
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds

        gradientLayer.colors = [UIColor.blue.cgColor, UIColor.green.cgColor]
        self.GradientBackgroundview.layer.addSublayer(gradientLayer)
    }

    
    

 
}
extension WeatherVC1: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dailyDataArray.count
    }
    
    
    
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! DailyWeatherViewCell
     
        
       
//        Получаем данные с сервера
        
        let DayWeather = dailyDataArray[indexPath.row]
    
        
        cell.DayLabel.text = DayWeather.dayData.capitalized
       
        cell.MaxTemp.text = DayWeather.DayHightData
        cell.MinTemp.text = DayWeather.DayLowData
        
        
        

       
        cell.WeatherIcon.contentMode = .scaleAspectFit
        cell.WeatherIcon.layer.shadowOffset = CGSize(width: 5, height: 5)
        cell.WeatherIcon.layer.shadowColor = #colorLiteral(red: 0.02419291437, green: 0.2590175867, blue: 0.5372289419, alpha: 0.5903664173)
        cell.WeatherIcon.layer.shadowOpacity = 12
        
      
        
//        Записываем данные, полученные из json, в базу данных
        
      
        
    
        print(dailyDataArray)
        
        
        
//        Получаю данные для иконки
        let imageURLString = "http://openweathermap.org/img/wn/\(DayWeather.DailyIconData).png"
        let imageURL:URL = URL(string: imageURLString)!
        cell.WeatherIcon.loadImage(withUrl: imageURL)

        
        return cell


    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }




}
extension UIImageView{
    func loadImage(withUrl url: URL){
        DispatchQueue.global().async {
            [weak self] in
            if let imageData = try? Data(contentsOf: url){
                if let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}



