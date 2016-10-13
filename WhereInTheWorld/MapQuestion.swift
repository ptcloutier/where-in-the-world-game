//
//  MapQuestion.swift
//  WhereInTheWorld
//
//  Created by Patrick Sanders on 8/25/16.
//  Copyright © 2016 io.turntotech.tutorials. All rights reserved.
//

import UIKit
import MapKit

class MapQuestion {
    let location:CLLocationCoordinate2D
    let regionSizeInMeters: Double
    var answers = [String:Bool]()
    
    init(location:CLLocationCoordinate2D, regionSizeInMeters meters:Double){
        self.location = location
        self.regionSizeInMeters = meters
    }
    
    func addAnswer(name:String, isCorrect correct:Bool) {
        if self.answers.count <= 3 && ( !self.answers.values.contains(correct) || correct == false )  {
            self.answers[name] = correct
        } else {
            print("You can't have two correct answers")
            print(name)
        }
    }
}
