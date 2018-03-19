//
//  WeatherTableViewCell.swift
//  WeatherNyblecraft
//
//  Created by Alexei Sevko on 3/18/18.
//  Copyright © 2018 Alexei Sevko. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var long: UILabel!
    @IBOutlet weak var lat: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
