//
//  Network.swift
//  FullWeather100500
//
//  Created by Александр Прохоров on 01.03.2021.
//



import Foundation

 protocol NetworkThreeLoaderDelegate {
    func load(threeHoursData: [List])
}

protocol NetworkCurrentDelegate {
    func loadCurrent(currentData: CurrentGlobal)
}


 class Network {
  
    var delegate: NetworkThreeLoaderDelegate?
    var delegateCurrent: NetworkCurrentDelegate?
    
    let currentWeather = "https://api.openweathermap.org/data/2.5/weather?id=524901&appid=ad1d577e0357f4a5b4f0b68060978a11&units=metric"
    
    let threeHoursWeather = "https://api.openweathermap.org/data/2.5/forecast?id=524901&appid=ad1d577e0357f4a5b4f0b68060978a11&units=metric"

//    MARK: - get data and decoding
    func loadThreeHoursWeather()  {
            let url = URL(string: self.threeHoursWeather)
        let request = URLRequest(url: url!)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {return}
            guard error == nil else {return}
            let decoder = JSONDecoder()

            do{
                    let otvet: Global = try! decoder.decode(Global.self, from: data)
                var weathers: [List] = []

                for dt in otvet.list{
                    var str = dt.dt_txt
                    var sep = str.components(separatedBy: " ")
                    if sep[1] == "12:00:00"{
                        weathers.append(dt)
                    }
                }
                
                                    DispatchQueue.main.async {
                        self.delegate?.load(threeHoursData: weathers)
                        
                    }
            }catch{print(error.localizedDescription)}
        }.resume()
        
        
    }
    
    func loadCurrentDataWeather(){
        let url = URL(string: self.currentWeather)
    let request = URLRequest(url: url!)
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        guard let data = data else {return}
        guard error == nil else {return}
        let decoder = JSONDecoder()

        do{
                let currentData: CurrentGlobal = try! decoder.decode(CurrentGlobal.self, from: data)
                DispatchQueue.main.async {
                    self.delegateCurrent?.loadCurrent(currentData: currentData)
                }
        }catch{print(error.localizedDescription)}
    }.resume()
    }
    
}
