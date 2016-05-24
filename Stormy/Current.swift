//
//  Current.swift
//  Stormy
//
//  Created by Ethan Neff on 10/6/14.
//  Copyright (c) 2014 ethanneff. All rights reserved.
//

import Foundation
import UIKit

// struct is a class
struct Current {
    // declare varibles
    var currentTime:String? // (optionals? makes default nil so no need to initalize)
    var temperature:Int
    var humidity:Double
    var precipProbability:Double
    var summary:String
    var icon:UIImage?
    
    // designated init (the primary one) to initalize the struct varibles
    init(weatherDictionary:NSDictionary) { 
        let currentWeather = weatherDictionary["currently"] as! NSDictionary
        
        temperature = currentWeather["temperature"] as! Int // as = downcast
        humidity = currentWeather["humidity"] as! Double
        precipProbability = currentWeather["precipProbability"] as! Double
        summary = currentWeather["summary"] as! String
        
        // must declare first, then call functions later in init
        let currentTimeIntValue = currentWeather["time"] as! Int
        currentTime = dateStringFromUnixTime(currentTimeIntValue)
        let iconString = currentWeather["icon"] as! String
        icon = weatherIconFromString(iconString)
    }
    
    // helper methods (instance methods)
    func dateStringFromUnixTime(unixTime:Int) -> String {
        let timeInSeconds = NSTimeInterval(unixTime)
        let weatherDate = NSDate(timeIntervalSince1970: timeInSeconds)
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeStyle = .ShortStyle
        
        return dateFormatter.stringFromDate(weatherDate)
    }
    
    func weatherIconFromString(stringIcon:String) -> UIImage {
        var imageName : String
        
        switch stringIcon {
            case "clear-day":
                imageName = "clear-day"
            case "clear-night":
                imageName = "clear-night"
            case "rain":
                imageName = "rain"
            case "snow":
                imageName = "snow"
            case "sleet":
                imageName = "sleet"
            case "wind":
                imageName = "wind"
            case "fog":
                imageName = "fog"
            case "cloudy":
                imageName = "cloudy"
            case "partly-cloudy-day":
                imageName = "partly-cloudy"
            case "partly-cloudy-night":
                imageName = "cloudy-night"
            default:
                imageName = "default"
        }
        let iconImage = UIImage(named: imageName)
        
        return iconImage!
    }
    
}