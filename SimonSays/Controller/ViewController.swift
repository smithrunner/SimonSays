//
//  ViewController.swift
//  SimonSays
//
//  Created by Sam Smith on 8/29/22.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    

    var player: AVAudioPlayer!
    var simon = Simon()
    
    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var pinkButton: UIButton!
    @IBOutlet weak var blackButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    
    func setTitles() {
        yellowButton.setTitle("yellow", for: .normal)
        pinkButton.setTitle("pink", for: .normal)
        blackButton.setTitle("black", for: .normal)
        blueButton.setTitle("blue", for: .normal)
    }
    
    @IBAction func pinkClicked(_ sender: UIButton) {
        click(button: "pink")
        simon.choices.append("pink")
        determineMove()
    }
    
    @IBAction func yellowClicked(_ sender: UIButton) {
        click(button: "yellow")
        simon.choices.append("yellow")
        determineMove()
    }
    
    
    @IBAction func blueClicked(_ sender: UIButton) {
        click(button: "blue")
        simon.choices.append("blue")
        determineMove()
    }
    
    @IBAction func blackClicked(_ sender: UIButton) {
        click(button: "black")
        simon.choices.append("black")
        determineMove()
    }
    
    func click(button: String) {
        var realButton: UIButton
        if button == "pink" {
            realButton = pinkButton
        } else if button == "blue" {
            realButton = blueButton
        } else if button == "black" {
            realButton = blackButton
        } else {
            realButton = yellowButton
        }
        realButton.alpha = 0.5
        playSound(soundName: realButton.currentTitle!)
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { (nil) in
            realButton.alpha = 1
        }
    }
    
    func determineMove() {
        let turn = simon.checkAnswer()
        if turn == false {
            topLabel.text = "You Lose!"
            bottomLabel.text = "You made it \(simon.answer.count) rounds"
        } else if simon.choices.count == simon.answer.count {
            simon.choices = []
            simon.addToAnswer()
            showAnswer()
        }
    }
    
    func showAnswer() {
        topLabel.text = "Simon Says..."
        var i = 0
        var rate = 1.0 - (0.05 * Double(i))
        for c in simon.answer {
            if i < 10 {
                rate = 1.0 - (0.05 * Double(i))
            } else {
                rate = 0.3
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + (Double(i) * rate) + 2.0) {
                self.click(button: c)
            }
            i += 1
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + (Double(i-1) * rate) + 2.5) {
            self.topLabel.text = "Your turn!"
        }
    }
    
    func playSound(soundName: String) {
        let url = Bundle.main.url(forResource: soundName, withExtension: "wav")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
                
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitles()
        showAnswer()
    }


}

