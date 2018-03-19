//
//  WeatherViewController.swift
//  WeatherNyblecraft
//
//  Created by Alexei Sevko on 3/18/18.
//  Copyright © 2018 Alexei Sevko. All rights reserved.
//

import UIKit
import MBProgressHUD

class WeatherViewController: UIViewController {

    private let weatherModel = WeatherViewModel()
    
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var lat: UILabel!
    @IBOutlet weak var long: UILabel!
    @IBOutlet weak var windSpeed: UILabel!
    @IBOutlet weak var temerature: UILabel!
    @IBOutlet weak var upperInfo: UILabel!
    @IBOutlet weak var lowerInfo: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var summary: UILabel!
    
    @IBOutlet weak var noInternet: UILabel!
    
    private var firstLaunch: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        firstLaunch = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if firstLaunch! {
            firstLaunch = false
            MBProgressHUD.showAdded(to: self.view, animated: true)
            request()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        MBProgressHUD.hide(for: self.view, animated: true) 
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: - Working with weather
extension WeatherViewController {
    
    func request() {
        weatherModel.requestWeatehr { (state) in
            switch state {
            case .Valid:
                self.decoreView()
                MBProgressHUD.hide(for: self.view, animated: true)
            case .Invalid(let error):
                MBProgressHUD.hide(for: self.view, animated: true)
                self.displayErrorMessage(errorMessage: error)
                self.showSadCapture()
            }
        }
    }
    
    func displayErrorMessage(errorMessage: String) {
        let alert = UIAlertController(title: nil, message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}

// MARK: - Private methods
extension WeatherViewController {

    private func decoreView() {
        temerature.text = String(format: "%.0f", weatherModel.temperature) + "°C"
        windSpeed.text = "Wind speed is " + String(format: "%.1f", weatherModel.windSpeed) + " m/s"
        lat.text = String(weatherModel.coordinates.0)
        long.text = String(weatherModel.coordinates.1)
        upperInfo.text = weatherModel.place.topDescription
        lowerInfo.text = weatherModel.place.lowDescription
        summary.text = weatherModel.summary
        time.text = weatherModel.time
        weatherIcon.image = UIImage(named: weatherModel.icon)
    }
    
    private func showSadCapture() {
        noInternet.isHidden = false
        weatherIcon.image = UIImage(named: "no-internet")
    }
    
}
