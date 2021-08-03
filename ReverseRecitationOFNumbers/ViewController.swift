//
//  ViewController.swift
//  ReverseRecitationOFNumbers
//
//  Created by niwa  shuhei on 2021/07/31.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UITextFieldDelegate {

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

        //キーボードで数字と記号のみを表示
        self.answerTextField.keyboardType = UIKeyboardType.numbersAndPunctuation

        self.answerTextField.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

    }

    @IBAction func startButtonAction(_ sender: Any) {
        //リセット
        displayLabel.text = ""
        answerTextField.text = ""

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

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        let stringNumberArray = String(newNumberArray[0]) +  String(newNumberArray[1]) +  String(newNumberArray[2]) +  String(newNumberArray[3]) +  String(newNumberArray[4])
        let stringNumberArrayInt = Int(stringNumberArray)

        var answerInt = 0

        if answerTextField.text != nil {
            answerInt = Int(answerTextField.text!)!
        }

        if stringNumberArrayInt == answerInt {
            displayLabel.text = "正解"

        } else {
            displayLabel.text = "不正解"
        }

        //キーボードを閉じる
        textField.resignFirstResponder()

        return true
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            } else {
                let suggestionHeight = self.view.frame.origin.y + keyboardSize.height
                self.view.frame.origin.y -= suggestionHeight
            }
        }
    }

    @objc func keyboardWillHide() {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
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

