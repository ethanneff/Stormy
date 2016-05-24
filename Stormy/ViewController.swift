//
//  ViewController.swift
//  Stormy
//
//  Created by Ethan Neff on 10/6/14.
//  Copyright (c) 2014 ethanneff. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var iconView: UIImageView!
  @IBOutlet weak var currentTimeLabel: UILabel!
  @IBOutlet weak var temperatureLabel: UILabel!
  @IBOutlet weak var humidityLabel: UILabel!
  @IBOutlet weak var precipitationLabel: UILabel!
  @IBOutlet weak var summaryLabel: UILabel!
  @IBOutlet weak var refreshActivityIndicator: UIActivityIndicatorView!
  @IBOutlet weak var refreshButton: UIButton!
  
  // private/public access files to keep it hidden within the source file of the app
  private let apiKey = "d95e04b6ee0050202b6a8f80c4ce62ba"
  
  
  // setting up view code
  override func viewDidLoad() {
    super.viewDidLoad()
    getCurrentWeatherData()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func getCurrentWeatherData() -> Void {
    refreshActivityIndicator.startAnimating()
    refreshButton.hidden = true
    refreshActivityIndicator.hidden = false
    
    let baseURL = NSURL(string: "https://api.forecast.io/forecast/\(apiKey)/")
    let forecastURL = NSURL(string: "30.396901,-97.751937", relativeToURL:baseURL)
    
    // pulls data from the web
    // let weatherData = NSData.dataWithContentsOfURL(forecastURL, options: nil, error: nil)
    
    // pull data from the web async
    let sharedSession = NSURLSession.sharedSession() // only 1 session manager (global object)
    let downloadTask: NSURLSessionDownloadTask = sharedSession.downloadTaskWithURL(forecastURL!, completionHandler: { (location: NSURL?, response: NSURLResponse?, error: NSError?) -> Void in
      if (error == nil) {
        // the data
        let dataObject = NSData(contentsOfURL: location!)
        
        // format to json
        let weatherDictionary = (try? NSJSONSerialization.JSONObjectWithData(dataObject!, options: [])) as! NSDictionary
        
        // create instance of the struct
        let currentWeatherInstance = Current(weatherDictionary: weatherDictionary)
        
        // get back to the main thread (all updates to the UI should be on main queue)
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
          self.temperatureLabel.text = "\(currentWeatherInstance.temperature)"
          self.iconView.image = currentWeatherInstance.icon!
          self.currentTimeLabel.text = "At \(currentWeatherInstance.currentTime!) it is"
          self.humidityLabel.text = "\(currentWeatherInstance.humidity)"
          self.precipitationLabel.text = "\(currentWeatherInstance.precipProbability)"
          self.summaryLabel.text = "\(currentWeatherInstance.summary)"
          
          self.refreshButton.hidden = false
          self.refreshActivityIndicator.hidden = true
          self.refreshActivityIndicator.stopAnimating()
        })
      } else {
        let networkIssuesController = UIAlertController(title: "Error", message: "Unable to load data. Connectivity error.!", preferredStyle: .Alert)
        let okButton = UIAlertAction(title: "OK", style: .Default, handler: nil)
        networkIssuesController.addAction(okButton)
        let cancelButton = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        networkIssuesController.addAction(cancelButton)
        
        self.presentViewController(networkIssuesController, animated: true, completion: { () -> Void in
          dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.refreshButton.hidden = false
            self.refreshActivityIndicator.hidden = true
            self.refreshActivityIndicator.stopAnimating()
          })
        })
      }
      
    })
    downloadTask.resume()
  }
  
  @IBAction func refresh() {
    getCurrentWeatherData()
  }
  
  
}

