//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    let eggTimes: [String: Int] = ["Soft": 5, "Medium": 7, "Hard": 12]
    var timer: Timer?
    var totalTime = 0
    var secondsPassed = 0
    var player: AVAudioPlayer?
    
    private func startTimer(minutes: Int) {
        titleLabel.text = "Cooking..."
        totalTime = minutes * 60
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
            if self.secondsPassed < self.totalTime {
                print("\(self.secondsPassed) seconds.")
                self.secondsPassed += 1
                self.updateProgress(secondsPassed: self.secondsPassed, totalTime: self.totalTime)
            } else {
                self.timer?.invalidate()
                self.progressBar.progress = 1.0
                self.titleLabel.text = "Done!"
                self.playSound()
            }
        }
    }
    
    private func updateProgress(secondsPassed: Int, totalTime: Int) {
        let percentageProgress = Float(secondsPassed) / Float(totalTime)
        print(percentageProgress)
        progressBar.progress = percentageProgress
    }
    
    private func playSound() {
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            guard let player = player else { return }
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    @IBAction func eggHardnessSelected(_ sender: UIButton) {
        let hardness = sender.currentTitle ?? "NA"
        
        switch hardness {
        case "Soft":
            print(eggTimes[hardness]!)
        case "Medium":
            print(eggTimes[hardness]!)
        case "Hard":
            print(eggTimes[hardness]!)
        default:
            print("Unable to get Egg Hardness")
        }
        
        if (hardness != "NA") {
            startTimer(minutes: eggTimes[hardness]!)
        }
    }
}
