//
//  ViewController.swift
//  ReverseRecitationOFNumbers
//
//  Created by niwa  shuhei on 2021/07/31.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet private weak var displayLabel: UILabel!
    @IBOutlet private weak var answerTextField: UITextField!

    var audioPlayer: AVAudioPlayer!
    var number: Int = 0
    var reverseNumber: Int = 0
    var numberArray = [Int]()
    var newNumberArray = [Int]()
    var reverseNumberArray = [Int]()
    var correctAnswerArray = [Int]()
    var correctAnswer: Int = 0

    var count = 0
    var btnTimer: Timer!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

    }

    @IBAction func startButtonAction(_ sender: Any) {
        randomNumberCreate()
//        assetsNumberSound()
        startTimer()
    }


    func randomNumberCreate() {
        numberArray = [1,2,3,4,5,6,7,8,9]
        newNumberArray = numberArray.shuffled()
        newNumberArray.removeSubrange(5...8)
        correctAnswerArray = newNumberArray.reversed()
        

        print(newNumberArray)
        print(correctAnswerArray)
    }

    func assetsNumberSound(name: String) {
        guard let numberSoundFile = NSDataAsset(name: name) else {
            print("Not Found")
            return
        }
        audioPlayer = try! AVAudioPlayer(data: numberSoundFile.data, fileTypeHint: "mp3")
        audioPlayer.play()
    }

    func startTimer() {
        self.btnTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.changeSounds), userInfo: nil, repeats: true)
    }

    @objc func changeSounds() {
        count += 1

        let stringName0 = String(correctAnswerArray[0])
        let stringName1 = String(correctAnswerArray[1])
        let stringName2 = String(correctAnswerArray[2])
        let stringName3 = String(correctAnswerArray[3])
        let stringName4 = String(correctAnswerArray[4])

        switch count {
        case 1:
            assetsNumberSound(name: stringName0)
        case 2:
            assetsNumberSound(name: stringName1)
        case 3:
            assetsNumberSound(name: stringName2)
        case 4:
            assetsNumberSound(name: stringName3)
        case 5:
            assetsNumberSound(name: stringName4)
        case 6:
            count = 0
            self.btnTimer.invalidate()
        default:
            print("対象外")
        }
    }
}

