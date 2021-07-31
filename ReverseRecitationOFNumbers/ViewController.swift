//
//  ViewController.swift
//  ReverseRecitationOFNumbers
//
//  Created by niwa  shuhei on 2021/07/31.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var displayLabel: UILabel!
    @IBOutlet private weak var answerTextField: UITextField!

    var number: Int = 0
    var reverseNumber: Int = 0
    var numberArray = [Int]()
    var newNumberArray = [Int]()
    var reverseNumberArray = [Int]()
    var correctAnswerArray = [Int]()
    var correctAnswer: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        randomNumberCreate()
    }

    func randomNumberCreate() {
        numberArray = [1,2,3,4,5,6,7,8,9]
        newNumberArray = numberArray.shuffled()
        newNumberArray.removeSubrange(5...8)
        correctAnswerArray = newNumberArray.reversed()
        

        print(newNumberArray)
        print(correctAnswerArray)
    }
}

