//
//  ViewController.swift
//  WhereInTheWorld
//
//  Created by Patrick Sanders on 8/25/16.
//  Copyright © 2016 io.turntotech.tutorials. All rights reserved.
//


import UIKit
import MapKit

class ViewController: UIViewController {
    
    var defaults = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet var score: UILabel!
    @IBOutlet var answer1: UIButton!
    @IBOutlet var answer2: UIButton!
    @IBOutlet var answer3: UIButton!
    @IBOutlet var mapView: MKMapView!
    
    var questions = [MapQuestion]()
    
    var correctAnswers :Int {
        get {
            return defaults.integerForKey("correctAnswers")
        }
        set {
            defaults.setInteger(newValue, forKey: "correctAnswers")
        }
    }
    var wrongAnswers :Int {
        get {
            return defaults.integerForKey("wrongAnswers")
        }
        set {
            defaults.setInteger(newValue, forKey: "wrongAnswers")
        }
    }
    
    var currentQuestionIndex :Int {
        get {
            return defaults.integerForKey("currentQuestionIndex")
        }
        set {
            defaults.setInteger(newValue, forKey: "currentQuestionIndex")
        }
    }
    
    var currentQuestion:MapQuestion {
        return questions[currentQuestionIndex]
    }
    
    func getNextQuestion() {
        if currentQuestionIndex + 1 < questions.count {
            currentQuestionIndex += 1
        } else {
            currentQuestionIndex = 0
        }
        getCurrentQuestion()
    }
    
    func getCurrentQuestion() {
        
        let question = self.currentQuestion
        let answers = [String](question.answers.keys)
        let location = question.location
        let size = question.regionSizeInMeters
        
        let region = MKCoordinateRegionMakeWithDistance(location, size, size)
        self.mapView.setRegion(region, animated: true)
        
        self.answer1.setTitle(answers[0], forState: .Normal)
        self.answer2.setTitle(answers[1], forState: .Normal)
        self.answer3.setTitle(answers[2], forState: .Normal)

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.score.text = "Correct: \(self.correctAnswers)\nWrong: \(self.wrongAnswers)"
        
        self.mapView.mapType = .Satellite
        self.mapView.zoomEnabled = false
        
        loadData()
        print("\(questions.count) questions")
        getCurrentQuestion()
    }
    
    @IBAction func checkAnswer(sender: UIButton) {
        
        let answer = sender.titleLabel!.text!
        let answerIsCorrect = currentQuestion.answers[answer]!
        
        var title = ""
        var subtitle = ""
//        let imageView = UIImageView(frame: CGRectMake(220, 10, 40, 40))
        let imageView = UIImageView(frame: CGRectMake(20,-240,210,240))

        let dang = UIImage(named:"dang.jpg")
    
        let bm = UIImage(named:"bm.jpg")
   
        if answerIsCorrect {
            title = "Correcto Mundo!"
            subtitle = "Well done"
            imageView.image = bm
            self.correctAnswers += 1
        }else{
            title = "Wrong answer!"
            subtitle = "Lo ciento"
            self.wrongAnswers += 1
            imageView.image = dang
        }
        let alertController = UIAlertController(title: title, message: subtitle, preferredStyle: .Alert)
        alertController.view.addSubview(imageView)
        let OKAction = UIAlertAction(title: "OK", style: .Default){
            (action) in
            self.getNextQuestion()
            
        }
        alertController.addAction(OKAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func loadData(){
        
        let kb = MapQuestion(location: CLLocationCoordinate2D(latitude:   67.074411, longitude:-158.945477), regionSizeInMeters: 1000)
        kb.addAnswer("Alaska", isCorrect: true)
        kb.addAnswer("Sahara Desert", isCorrect: false)
        kb.addAnswer("Arizona", isCorrect: false)
        self.questions.append(kb)
        
        let ba = MapQuestion(location: CLLocationCoordinate2D(latitude: 44.499527, longitude: 33.598420), regionSizeInMeters: 500)
        ba.addAnswer("Turkey", isCorrect: false)
        ba.addAnswer("Russia", isCorrect: true)
        ba.addAnswer("Italy", isCorrect: false)
        self.questions.append(ba)
        
        let ar = MapQuestion(location: CLLocationCoordinate2D(latitude: -33.867886, longitude:-63.984500), regionSizeInMeters: 1500)
        ar.addAnswer("Tennessee", isCorrect: false)
        ar.addAnswer("Argentina", isCorrect: true)
        ar.addAnswer("New Mexico", isCorrect: false)
        self.questions.append(ar)
        
        let ch = MapQuestion(location: CLLocationCoordinate2D(latitude: 40.452107, longitude: 93.742118), regionSizeInMeters: 2500)
        ch.addAnswer("Peru", isCorrect: false)
        ch.addAnswer("China", isCorrect: true)
        ch.addAnswer("Egypt", isCorrect: false)
        self.questions.append(ch)
        
        let nv = MapQuestion(location: CLLocationCoordinate2D(latitude: 37.563936, longitude: -116.851230), regionSizeInMeters: 500)
        nv.addAnswer("Nevada", isCorrect: true)
        nv.addAnswer("China", isCorrect: false)
        nv.addAnswer("Egypt", isCorrect: false)
        self.questions.append(nv)
        
        let sa = MapQuestion(location: CLLocationCoordinate2D(latitude: 16.864841, longitude:  11.953808), regionSizeInMeters: 500)
        sa.addAnswer("Sahara Desert", isCorrect: true)
        sa.addAnswer("Nevada", isCorrect: false)
        sa.addAnswer("Egypt", isCorrect: false)
        self.questions.append(sa)
        
        
        let bs = MapQuestion(location: CLLocationCoordinate2D(latitude: 26.357896, longitude: 127.783809), regionSizeInMeters: 200)
        bs.addAnswer("Japan", isCorrect: true)
        bs.addAnswer("New York", isCorrect: false)
        bs.addAnswer("Tibet", isCorrect: false)
        self.questions.append(bs)
    }


}

