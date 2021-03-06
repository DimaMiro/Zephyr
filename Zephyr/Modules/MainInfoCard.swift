//
//  MainInfoCard.swift
//  Zephyr
//
//  Created by Dima Miro on 05/02/2019.
//  Copyright © 2019 Dima Miro. All rights reserved.
//

import UIKit

class MainInfoCard: UIView {
    
    var pm25Label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 64)
        label.textColor = .white
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    var statusLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 21)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    var updatedTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .white
        label.alpha = 0.7
        label.numberOfLines = 0
        return label
    }()
    var temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .white
        label.alpha = 0.7
        label.numberOfLines = 0
        return label
    }()
    
    var treeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "tree")
        imageView.alpha = 0.2
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 20
        self.layer.masksToBounds = true
        
        addSubview(treeImage)
        treeImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        treeImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        treeImage.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        addSubview(pm25Label)
        pm25Label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25).isActive = true
        pm25Label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        addSubview(statusLabel)
        statusLabel.leadingAnchor.constraint(equalTo: pm25Label.trailingAnchor, constant: 25).isActive = true
        statusLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 25).isActive = true
        statusLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true

        addSubview(updatedTimeLabel)
        updatedTimeLabel.leadingAnchor.constraint(equalTo: statusLabel.leadingAnchor).isActive = true
        updatedTimeLabel.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 2).isActive = true
        updatedTimeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true

        addSubview(temperatureLabel)
        temperatureLabel.leadingAnchor.constraint(equalTo: statusLabel.leadingAnchor).isActive = true
        temperatureLabel.topAnchor.constraint(equalTo: updatedTimeLabel.bottomAnchor, constant: 2).isActive = true
        temperatureLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        temperatureLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -25).isActive = true
        
    }
    
    func updateCardData(_ data: DayData?) {
        self.isHidden = false
        if let pm25Value = data?.pm25 {
            pm25Label.text = String(pm25Value)
            checkForCardColor(pm25value: pm25Value)
        } else {
            print("pm25Value is nil")
            pm25Label.text = "-"
            backgroundColor = .gray
            statusLabel.text = "N/A"
        }
        if let udatedTimeValue = data?.time {
            updatedTimeLabel.text = "Updated on \(self.formatDate(udatedTimeValue))"
        } else { print("udatedTimeValue is nil") }
        if let temperatureValue = data?.temp {
            temperatureLabel.text = "Temperature: \(temperatureValue)°C"
        } else { print("temperatureValue is nil") }
    }
    
    func checkForCardColor(pm25value: Int?) {
        if let value = pm25value {
            switch value {
            case 0...50:
                self.backgroundColor = UIColor.CustomColor.green
                self.statusLabel.text = "Good"
            case 51...100:
                self.backgroundColor = UIColor.CustomColor.yellow
                self.statusLabel.text = "Moderate"
            case 101...150:
                self.backgroundColor = UIColor.CustomColor.orange
                self.statusLabel.text = "Unhealthy"
            case 151...200:
                self.backgroundColor = UIColor.CustomColor.red
                self.statusLabel.text = "Unhealthy"
            case 201...300:
                self.backgroundColor = UIColor.CustomColor.purple
                self.statusLabel.text = "Very Unhealthy"
            case 300...:
                self.backgroundColor = UIColor.CustomColor.brown
                self.statusLabel.text = "Hazardous"
            default:
                self.backgroundColor = .gray
                self.statusLabel.text = "N/A"
            }
        }
    }
    
    func formatDate(_ date: String) -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, HH:mm"
        let currentDate = formatter.string(from: date)
        return currentDate
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
