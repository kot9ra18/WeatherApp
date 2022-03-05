//
//  AFNetwork.swift
//  WeatherApp
//
//  Created by Александр Прохоров on 02.04.2021.
//

import Foundation
import Alamofire
// api.openweathermap.org/data/2.5/weather?q= + text + &appid=ad1d577e0357f4a5b4f0b68060978a11&units=metric
//    let currentWeather = "https://api.openweathermap.org/data/2.5/weather?id=524901&appid=ad1d577e0357f4a5b4f0b68060978a11&units=metric"
//    let threeHoursAF = "https://api.openweathermap.org/data/2.5/forecast?id=524901&appid=ad1d577e0357f4a5b4f0b68060978a11&units=metric"

class AFNetwork {

// MARK: - Методы создания URL адресов
    func generateCurrentURL(_ str: String) -> String{
        
        let currentWeather = "https://api.openweathermap.org/data/2.5/weather?q=" + str + "&appid=ad1d577e0357f4a5b4f0b68060978a11&units=metric"
        
        return currentWeather
    }
    
    func generateThreeHoursURL(_ str: String) -> String{
       let threeHoursAF = "https://api.openweathermap.org/data/2.5/forecast?q=" + str + "&appid=ad1d577e0357f4a5b4f0b68060978a11&units=metric"
        return threeHoursAF
    }
    
//    MARK:- Метод загрузки погоды на 5 дней каждые 3 часа
    func loadAFThree(str: String,_ completion: @escaping ([List]) -> Void) {
        guard let url = URL(string: str) else {return}
        AF.request(url).validate().responseJSON { (response) in
            switch response.result {
                case .success(let value):
                    let data = response.data
                    let decoder = JSONDecoder()
                        do{
//          до этого куска долго доходил
                            let otvet: Global = try! decoder.decode(Global.self, from: data!)
                            var weathers: [List] = []
                            for dt in otvet.list{
                                var str = dt.dt_txt
                                var sep = str.components(separatedBy: " ")
                                if sep[1] == "12:00:00"{
                                    weathers.append(dt)
                                }
                            }
                                DispatchQueue.main.async {
                                    completion(weathers)
                                }
                        }catch{print(error.localizedDescription)}
                case .failure(let error): print(error)
            }
        }
    }
    
    //    MARK:- Метод загрузки текущей погоды, название города
    func loadAFCurr(str: String,_ completion: @escaping (CurrentGlobal) -> Void) {
        guard let url = URL(string: str) else {return}
        AF.request(url).validate().responseJSON { (response) in
            switch response.result {
                case .success(let value):
                    let data = response.data
                    let decoder = JSONDecoder()
                        do{
                            let otvetCur: CurrentGlobal = try! decoder.decode(CurrentGlobal.self, from: data!)
                                DispatchQueue.main.async {
                                    completion(otvetCur)
                            }
                        }catch{print(error.localizedDescription)}
                case .failure(let error): print(error)
            }
        }
    }
}

