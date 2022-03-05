//
//  AFModel.swift
//  WeatherApp
//
//  Created by Александр Прохоров on 21.04.2021.
//

import Foundation

struct CurrentGlobal: Codable{
    var name: String
    var main: CurrentGlobalMain
}

struct CurrentGlobalMain: Codable {
    var temp: Double
}
