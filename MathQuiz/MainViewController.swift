
//  MainTableViewController.swift
//  MathQuiz
//
//  Created by Rimma on 2022-04-05.
//

import UIKit

class MainViewController: UIViewController, UITextFieldDelegate {
    var results: [Result] = []

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var question: UITextField!
    @IBOutlet weak var ansTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var generateButton: UIButton!
    @IBOutlet weak var startGameTimerButton: UIButton!
    @IBOutlet weak var gameTimeLabel: UILabel!
    
    @IBAction func finishButton(_ sender: Any) {
        let newVC1 = storyboard?.instantiateViewController(withIdentifier: "menu")
        present(newVC1!, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        startGame()
        ansTextField.delegate = self // for digits only validation (func below)
        
        startInt = 3
        startGameTimerButton.setTitle(String(startInt), for: .normal)
        startGameTimerButton.isHidden = false
        startTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MainViewController.startGameTimer), userInfo: nil, repeats: true)// to trigger the startTimer. Repeat it self every timeInterval (every second trigger func startGameTimer())
        gameInt = 40
        gameTimeLabel.text = String(gameInt)
    }

    //======= Timer
    var startInt = 0
    var startTimer = Timer()
    
    var gameInt = 0
    var gameTimer = Timer()
    
    
    @objc func startGameTimer() { // decrease 3 to 1
        startInt -= 1
        startGameTimerButton.setTitle(String(startInt), for: .normal)
        
        if startInt == -1 {
            startTimer.invalidate()
            startGameTimerButton.isHidden = true
            gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector:  #selector(MainViewController.gameTime), userInfo: nil, repeats: true) //mainTimer lauch after start timer ends
        }
    }
    
    @objc func gameTime() {
        gameInt -= 1
        gameTimeLabel.text = String(gameInt)
        
        if gameInt == 0{ //when main game time becomes 0, timer stops
            gameTimer.invalidate()
            generateButton.isEnabled = false // cant' push to the button
        }
        
    }

//    =====Question / Answer Section
    
    var num1 = Int()
    var num2 = Int()
    var signNum = Int()
    var sign = String()
    var score = Int(0)
    var answer = Int()
    
        func startGame(){
        print(answer)
        ansTextField.text = ""
        resultLabel.isHidden = true
            
        scoreLabel.text = "Score: \(score)"
            
        var num1 = Int.random(in: 0..<10)
        var num2 = Int.random(in: 0..<10)
        signNum = Int(arc4random_uniform(4))
        switch signNum {
        case 0:
            sign = "+"
            answer = num1 + num2
            question.text = "\(num1) \(sign) \(num2)"
            break
        case 1:
            sign = "-"
            answer = num1 - num2
            question.text = "\(num1) \(sign) \(num2)"
            break
        case 2:
            sign = "*"
            answer = num1 * num2
            question.text = "\(num1) \(sign) \(num2)"
            break
        case 3:
            sign = "/"
            while true {
                if  num2 == 0 || num1 % num2 != 0 {
                    num1 = Int.random(in: 1..<10)
                    num2 = Int.random(in: 1..<10)

                }else{
                    break}
            }
            while true{
                if num1 < num2{
                    num1 = Int.random(in: 1..<10)
                    num2 = Int.random(in: 1..<10)
                }else{
                    break
                }
            }
            answer = num1 / num2
        default:
            break
            }
            question.text = "\(num1) \(sign) \(num2)"
            print(answer)
    }
  
    
    @IBAction func nextProblem(_ sender: AnyObject){
        startGame()
    }
    
//============ Digits Section
       
var numberFromScreen: Int{ //convert string from "Your answer screen" to int.
    get{
        return Int(ansTextField.text!)!
    }
    set{
        ansTextField.text = "\(newValue)"
    }
}
    
var dotIsPlaced = false // var to check was the dot already placed or not

@IBAction func namberPressed(_ sender: UIButton) {   // func allows me to press 3 and 5 and see in the answer section 35.
    ansTextField.text = ansTextField.text! + String(sender.tag)
}
    
@IBAction func clearButton(_ sender: UIButton) {
    numberFromScreen = 0
    ansTextField.text = ""
    dotIsPlaced = false
}
    
@IBAction func dotButton(_ sender: UIButton) {
    if !dotIsPlaced{
        ansTextField.text = ansTextField.text! + "."
        dotIsPlaced = true
    }else if !dotIsPlaced{
                ansTextField.text = "0."
    }
}
    
@IBAction func minusButton(_ sender: UIButton) {
    numberFromScreen = -numberFromScreen
}
    
    //func for digits only validation
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == ansTextField {
            let allowedCharacters = CharacterSet(charactersIn:"-.0123456789")
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
      
     //=======VALIDATION BUTTON and CREATING NEW OBJECT=========
     @IBAction func validationButton(_ sender: UIButton) {
         if Int(ansTextField.text!) == answer{
             resultLabel.isHidden = false
             resultLabel.text = "W🤩W! Correct answer! "
             score = score + 1
             scoreLabel.text = "Score: \(score)"
         }else{
             resultLabel.isHidden = false
             resultLabel.text = "Sorry🥺 Wrong answer!"
             score = score - 1
             scoreLabel.text = "Score: \(score)"}
         
         let yourQuestion = question.text ?? ""
         let yourAnswer = ansTextField.text ?? ""
         let rightOrWrong = resultLabel.text ?? ""

         let resultTemp = Result(yourQuestion: yourQuestion, yourAnswer: yourAnswer, rightOrWrong: rightOrWrong)
         results.append(resultTemp)

     }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "toShowResult"{
            let navVC = segue.destination as! UINavigationController
            if let vc = navVC.viewControllers.first as? ResultTableViewController{
            print(results)
            vc.results = results
            }
        }
    }
}
