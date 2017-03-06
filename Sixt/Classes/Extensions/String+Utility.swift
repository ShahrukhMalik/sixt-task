//
//  String+Utility.swift
//  Sixt
//
//  Created by Shahrukh on 23/12/2016.
//  Copyright © 2016 Home. All rights reserved.
//

import Foundation

extension String {
    
    // Creates image url string for car
    static func imageUrlStringOfCarFrom(modelIdentifier: String, color: String) -> String {
        let urlString = String(format: "https://prod.drive-now-content.com/fileadmin/user_upload_global/assets/cars/%@/%@/2x/car.png", modelIdentifier, color)
        return urlString
    }
    
    // Formated string for fuel level
    static func formattedFuelLevelString(fuelLevel: Double) -> String {
        let str = String(format: "%.0f%%", fuelLevel*100)
        return str
    }
    
    // Formatted string for cleanliness
    func formattedCleanlinessString() -> String {
        var cleanString = ""
        
        if self == "CLEAN" {
            cleanString = "Clean"
            
        } else if self == "VERY_CLEAN" {
            cleanString = "Very Clean"
            
        } else if self == "REGULAR" {
            cleanString = "Regular"
        }
        
        return cleanString
    }
    
    // Formated string for transmission
    func formattedTransmissionString() -> String {
        var cleanString = ""
        
        if self == "M" {
            cleanString = "Manual"
            
        } else if self == "A" {
            cleanString = "Automatic"
        }
        
        return cleanString
    }
    
    // Formated string for fuel type
    func formattedFuelTypeString() -> String {
        var cleanString = ""
        
        if self == "P" {
            cleanString = "Petrol"
            
        } else if self == "D" {
            cleanString = "Diesel"
            
        } else if self == "E" {
            cleanString = "Electric"
        }
        
        return cleanString
    }
    
    // Formated string for color
    func formattedColorString() -> String {
        var cleanString = ""
        
        if self == "midnight_black" {
            cleanString = "Midnight Black"
            
        } else if self == "hot_chocolate" {
            cleanString = "Hot Chocolate"
            
        } else if self == "midnight_black_metal" {
            cleanString = "Midnight Black Metal"
            
        } else if self == "light_white" {
            cleanString = "Light White"
            
        } else if self == "iced_chocolate" {
            cleanString = "Iced Chocolate"
            
        } else if self == "alpinweiss" {
            cleanString = "Alpinweiss"
            
        } else if self == "saphirschwarz" {
            cleanString = "Saphirschwarz"
            
        } else if self == "iced_chocolate_metal" {
            cleanString = "Iced Chocolate Metal"
            
        } else if self == "absolute_black_metal" {
            cleanString = "Absolute Black Metal"
            
        } else if self == "schwarz" {
            cleanString = "Schwarz"
        }
        
        return cleanString
    }
}
