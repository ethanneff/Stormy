// Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


private let apiKey = "23c69b1672b048e2f989480a83dc75b2"
let baseURL = NSURL(string: "https://api.forecast.io/forecast/\(apiKey)/")
let forecastURL = NSURL(string: "30.397262,-97.751626", relativeToURL:baseURL)
