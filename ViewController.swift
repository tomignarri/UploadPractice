//
//  ViewController.swift
//  BullsEye
//
//  Created by Thomas Ignarri on 6/22/17.
//  Copyright © 2017 Thomas Ignarri. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var currentValue = 0
    var targetValue = 0
    var score = 0
    var round = 0
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewRound()
        updateLabels()
        
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
        
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")
        
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startNewRound() {
        round += 1
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(currentValue)
    }
    
    func updateLabels() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }

    @IBAction func showAlert() {
        let difference = abs(targetValue - currentValue)
        let points = 100 - difference
        
        score += points
        var message = "You scored \(points) points!"
        if score > 95 {
            message += " Close!"
        }
        
        let alert = UIAlertController(title: "BullzzzzzzzEye", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: { action in self.startNewRound();self.updateLabels() })
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func startOver(_ sender: Any) {
        round = 0
        score = 0
        startNewRound()
        updateLabels()
    }
    
    
    @IBAction func sliderMoved(_ slider: UISlider) {
        currentValue = lroundf(slider.value)
    }
}

