//
//  PopupViewController.swift
//  WeatherNyblecraft
//
//  Created by Alexei Sevko on 3/19/18.
//  Copyright © 2018 Alexei Sevko. All rights reserved.
//

import UIKit

class PopupViewController: UIViewController {

    @IBOutlet weak var popupWeatherView: UIView!
    @IBOutlet weak var upperInfo: UILabel!
    @IBOutlet weak var lowerInfo: UILabel!
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var windSpeed: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var lat: UILabel!
    @IBOutlet weak var long: UILabel!
    
    var weather: WeatherData?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        popupWeatherView.layer.cornerRadius = 15
        popupWeatherView.layer.masksToBounds = true
        
        decore()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension PopupViewController {
    
    func decore() {
        if let weather = weather {
            temperature.text = String(format: "%.0f", weather.temperature) + "°C"
            windSpeed.text = "Wind speed is " + String(format: "%.1f", weather.windSpeed) + " m/s"
            lat.text = String(weather.lat)
            long.text = String(weather.long)
            upperInfo.text = weather.place.topDescription
            lowerInfo.text = weather.place.lowDescription
            summary.text = weather.summary
            time.text =  String.string(from: weather.time)
            icon.image = UIImage(named: weather.icon)
        }
    }
    
}

// MARK: - overriding touches
extension PopupViewController {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        guard let location = touch?.location(in: self.view) else { return }
        if !popupWeatherView.frame.contains(location) {
            dismiss(animated: true, completion: nil)
        }
    }
    
}







