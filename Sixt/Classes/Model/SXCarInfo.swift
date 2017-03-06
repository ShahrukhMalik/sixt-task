//
//  SXCarInfo.swift
//  Sixt
//
//  Created by Shahrukh on 23/12/2016.
//  Copyright © 2016 Home. All rights reserved.
//

import UIKit

class SXCarInfo: NSObject {
    
    var id: String? = nil
    var modelIdentifier: String? = nil
    var modelName: String? = nil
    var name: String? = nil
    var make: String? = nil
    var group: String? = nil
    var color: String? = nil
    var series: String? = nil
    var fuelType: String? = nil
    var fuelLevel: Double = 0.0
    var transmission: String? = nil
    var licensePlate: String? = nil
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    var cleanliness: String? = nil
    var carImageUrl: String? = nil
    
    var formattedCleanlinessString: String? = nil
    var formattedTransmissionString: String? = nil
    var formattedColorString: String? = nil
    var formattedFuelLevelString: String? = nil
    var formattedFuelTypeString: String? = nil
    
    
    // MARK: - Class methods
    
    class func carInfoObjectFromInfo(info: NSDictionary) -> SXCarInfo {
        let carInfo = SXCarInfo()
        
        carInfo.id = info.object(forKey: "id") as! String?
        carInfo.fuelType = info.object(forKey: "fuelType") as! String?
        carInfo.modelIdentifier = info.object(forKey: "modelIdentifier") as! String?
        carInfo.transmission = info.object(forKey: "transmission") as! String?
        carInfo.series = info.object(forKey: "series") as! String?
        carInfo.modelName = info.object(forKey: "modelName") as! String?
        carInfo.longitude = (info.object(forKey: "longitude") as! Double?)!
        carInfo.latitude = (info.object(forKey: "latitude") as! Double?)!
        carInfo.color = info.object(forKey: "color") as! String?
        carInfo.carImageUrl = info.object(forKey: "carImageURL") as! String?
        carInfo.group = info.object(forKey: "group") as! String?
        carInfo.licensePlate = info.object(forKey: "licensePlate") as! String?
        carInfo.make = info.object(forKey: "make") as! String?
        carInfo.fuelLevel = (info.object(forKey: "fuelLevel") as! Double?)!
        carInfo.cleanliness = info.object(forKey: "innerCleanliness") as! String?
        carInfo.name = info.object(forKey: "name") as! String?
        
        // Creating url string for car
        carInfo.carImageUrl = String.imageUrlStringOfCarFrom(modelIdentifier: (carInfo.modelIdentifier)!, color: (carInfo.color)!)
        
        // Formatted Strings (For better user readability)
        carInfo.formattedCleanlinessString = carInfo.cleanliness?.formattedCleanlinessString()
        carInfo.formattedTransmissionString = carInfo.transmission?.formattedTransmissionString()
        carInfo.formattedColorString = carInfo.color?.formattedColorString()
        carInfo.formattedFuelTypeString = carInfo.fuelType?.formattedFuelTypeString()
        carInfo.formattedFuelLevelString = String.formattedFuelLevelString(fuelLevel: carInfo.fuelLevel)
        
        return carInfo
    }
    
    class func arrayOfCarInfoObjectsFromInfoArray(infoArray: NSArray) -> [SXCarInfo] {
        var cars: [SXCarInfo] = []
        
        for infoDict in infoArray {
            let aCar = carInfoObjectFromInfo(info: infoDict as! NSDictionary)
            cars.append(aCar)
        }
        
        return cars
    }
}
