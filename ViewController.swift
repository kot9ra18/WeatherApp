//
//  ViewController.swift
//  FullWeather100500
//
//  Created by Александр Прохоров on 22.02.2021.
/*Создайте проект:
 1. Прочитайте статью про работу с Alamofire.
 2. Зарегистрируйтесь на https://openweathermap.org/api для получения погоды по API.
 Создайте один проект, в котором будет два контроллера, каждый из которых реализует следующие задачи (в первом контроллере с использованием стандартных средств, во втором — с использованием Alamofire):
 a) показывает текущую погоду в Москве: https://openweathermap.org/current;
 b) показывает прогноз на ближайшие 16 дней в виде таблицы (тоже для Москвы): ​https://openweathermap.org/forecast16​​​.
 3. Изучите, что такое Carthage: https://github.com/Carthage/Carthage.
 a) Ответьте на вопрос, в чём разница между Carthage и Cocoapods.
 b) Создайте новый проект и интегрируйте в него Alamofire с помощью Carthage.
*/
//http://api.openweathermap.org/data/2.5/weather?q=London&appid=ad1d577e0357f4a5b4f0b68060978a11



import UIKit
import Alamofire


class ViewController: UIViewController {

    var getThreeHoursData: [List]?
    var getCurrentData: CurrentGlobal?
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       let loaderThree = Network()
        loaderThree.delegate = self
        loaderThree.loadThreeHoursWeather()
        
        let loaderCurrent = Network()
        loaderCurrent.delegateCurrent = self
        loaderCurrent.loadCurrentDataWeather()
    }
}

//MARK: - set from data
extension ViewController: NetworkThreeLoaderDelegate, NetworkCurrentDelegate{
    func load(threeHoursData: [List]) {
        self.getThreeHoursData = threeHoursData
        tableView.reloadData()
    }
    func loadCurrent(currentData: CurrentGlobal){
        self.getCurrentData = currentData
        self.city.text = getCurrentData?.name
        self.temp.text = String(getCurrentData?.main.temp ?? 0.0)
    }

}
//MARK: - tableViewCell
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getThreeHoursData?.count ?? 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TableViewCell
        
        cell.pressure.text = String((getThreeHoursData?[indexPath.row].main.pressure ?? 111))
        cell.dateAndTime.text = getThreeHoursData?[indexPath.row].dt_txt
        cell.dayTemp.text = String((getThreeHoursData?[indexPath.row].main.temp_max ?? 111))
        cell.nightTemp.text = String((getThreeHoursData?[indexPath.row].main.temp_min ?? 111))
        return cell
    }
    
    
}




