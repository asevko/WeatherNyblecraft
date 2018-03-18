//
//  RecentViewController.swift
//  WeatherNyblecraft
//
//  Created by Alexei Sevko on 3/18/18.
//  Copyright © 2018 Alexei Sevko. All rights reserved.
//

import UIKit
import FirebaseAuth

class RecentViewController: UIViewController {

    @IBOutlet weak var table: UITableView!
    
    private var weatherModel = WeatherViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.delegate = self
        table.dataSource = self
        
        subcsribe()
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func logOut(_ sender: Any) {
        let alert = UIAlertController(title: nil, message: "Are you shure that you want to log out?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        let logOut = UIAlertAction(title: "Log Out", style: .default) { (action) in
            do {
                try Auth.auth().signOut()
                self.gotoAuth()
            } catch {
                print("Error")
            }
        }
        alert.addAction(logOut)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    private func gotoAuth() {
        self.performSegue(withIdentifier: "RecentToAuth", sender: self)
    }
    
}


extension RecentViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherModel.getHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell") as! WeatherTableViewCell
        
        cell.weatherIcon.image = UIImage(named: weatherModel.getHistory[indexPath.row].icon)
        cell.city.text = weatherModel.getHistory[indexPath.row].place.city
        cell.time.text = String.string(from: weatherModel.getHistory[indexPath.row].time)
        cell.lat.text = String(weatherModel.getHistory[indexPath.row].lat)
        cell.long.text = String(weatherModel.getHistory[indexPath.row].long)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}


private extension RecentViewController {
    
    func subcsribe() {
//        weatherModel.subscribeOnFirstLoad {
//            self.table.reloadData()
//        }
//        
        weatherModel.subscribeOnDelete {
            self.table.reloadData()
        }
        
        weatherModel.subscribeOnAdding {
            self.table.reloadData()
        }
        
    }
    
}



