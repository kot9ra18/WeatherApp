//
//  ViewControllerAlamofire.swift
//  FullWeather100500
//
//  Created by Александр Прохоров on 22.03.2021.
//

import UIKit
import Alamofire

class ViewControllerAlamofire: UIViewController{

    @IBOutlet weak var textUserTextField: UITextField!
    @IBOutlet weak var tableViewAF: UITableView!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var temp: UILabel!
    var weathers: [List]?
    var otvetCurr: CurrentGlobal?
    

    var numbOfData = 0
      
    
    
//    MARK:- Отработка нажатия на кнопку, вызов метода создания адреса, присвоение значений
    
    @IBAction func pressButtonAction(_ sender: Any) {
        if textUserTextField.text != "" {
            let textFromUser = textUserTextField.text!
            AFNetwork().loadAFCurr(str: AFNetwork().generateCurrentURL(textFromUser)) { (otvetCur) in
                        self.otvetCurr = otvetCur
                        self.city.text = self.otvetCurr?.name
                        self.temp.text = String((self.otvetCurr?.main.temp)!)
                    }
            AFNetwork().loadAFThree(str: AFNetwork().generateThreeHoursURL(textFromUser)) { (weathers) in
                self.weathers = weathers
                self.tableViewAF.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - Расширения контроллера
extension ViewControllerAlamofire: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weathers?.count ?? 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2") as! Cell
       
        cell.date2.text = weathers?[indexPath.row].dt_txt
        cell.pressure2.text = String(weathers?[indexPath.row].main.pressure ?? 111)
            cell.pressure2.text = String(weathers?[indexPath.row].main.pressure ?? 111)
            cell.tempMax2.text = String(weathers?[indexPath.row].main.temp_max ?? 111)
            cell.tempMin2.text = String(weathers?[indexPath.row].main.temp_min ?? 111)
        return cell
    }
}




