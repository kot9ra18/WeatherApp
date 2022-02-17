//
//  ModelData.swift
//  FullWeather100500
//
//  Created by Александр Прохоров on 22.02.2021.
//

import Foundation

public struct Global: Codable {

    var city: City
    var list: [List]
}

struct List: Codable {
    var main: Main
    var weather: [Weather]
    var clouds: Clouds
    var wind: Wind
    var visibility: Int
    var dt_txt: String
}
struct Main: Codable {
    var temp: Double
    var feels_like: Double
    var pressure: Double
    var temp_min: Double
    var temp_max: Double
    }
struct Weather: Codable {
    var id: Int
    var main: String
    var description: String
    var icon: String
    }
struct Clouds: Codable {
    var all: Int
}
struct Wind: Codable {
    var speed: Double
    var deg: Int
}


struct City: Codable {
    var name: String
}
