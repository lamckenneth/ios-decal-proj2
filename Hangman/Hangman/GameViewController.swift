//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

//add new game button
//make look nicer

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet var hangmanImage : UIImageView!
    @IBOutlet var hangmanWord : UILabel!
    @IBOutlet var incorrectGuesses : UILabel!
    @IBOutlet var letterGuessing : UITextField!
    @IBOutlet var guessButton : UIButton!
    //@IBOutlet var correctButton : UIButton!
    //@IBOutlet var incorrectButton : UIButton!
    var phrase : String?
    var numberOfWrongGuesses = 1
    var letterGuess : String?
    var letterAlertController : UIAlertController?
    var winAlertController : UIAlertController?
    var loseAlertController : UIAlertController?
    var alreadyGuessedAlertController : UIAlertController?
    var lettersOnlyAlertController : UIAlertController?
    var correctLettersGuessed = [String]()
    var incorrectLettersGuessed = [String]()
    var numberOfUniqueCharactersInPhrase : Int?
    let whitespaceSet = NSCharacterSet.whitespaceCharacterSet()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let hangmanPhrases = HangmanPhrases()
        phrase = hangmanPhrases.getRandomPhrase()
        print(phrase)
        hangmanWord.font = UIFont(name:"AmericanTypewriter", size: 20)
        guessButton.titleLabel!.font = UIFont(name:"AmericanTypewriter", size: 20)
        incorrectGuesses.font = UIFont(name:"AmericanTypewriter", size: 20)
        letterGuessing.font = UIFont(name:"AmericanTypewriter", size: 20)
        loadInterface()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Formerly correct button, changed to guess button
    func correctButtonFunction() {
        letterGuess = letterGuessing.text
        if (numberOfUniqueCharactersInPhrase == correctLettersGuessed.count) {
            self.presentViewController(winAlertController!, animated: true, completion: nil)
        } else if (numberOfWrongGuesses >= 7) {
            self.presentViewController(loseAlertController!, animated: true, completion: nil)
        } else if (letterGuess!.characters.count > 1) {
            self.presentViewController(letterAlertController!, animated: true, completion: nil)
        } else if (correctLettersGuessed.contains(letterGuess!) || incorrectLettersGuessed.contains(letterGuess!)) {
            self.presentViewController(alreadyGuessedAlertController!, animated: true, completion: nil)
        } else {
            let letters = NSCharacterSet.letterCharacterSet()
            if (letterGuess!.rangeOfCharacterFromSet(letters) == nil) {
                self.presentViewController(lettersOnlyAlertController!, animated: true, completion: nil)
                return
            }
            if (phrase!.rangeOfString(letterGuess!.uppercaseString) != nil) {
                correctLettersGuessed.append(letterGuess!)
                var index = 0
                for letter in phrase!.characters {
                    if (String(letter) == letterGuess?.uppercaseString) {
                        var replaceHangmanWord = Array(hangmanWord.text!.characters)
                        replaceHangmanWord[index] = Array(letterGuess!.uppercaseString.characters)[0]
                        hangmanWord.text = String(replaceHangmanWord)
                    }
                    index += 1
                }
                if (numberOfUniqueCharactersInPhrase == correctLettersGuessed.count) {
                    self.presentViewController(winAlertController!, animated: true, completion: nil)
                }
            } else {
                incorrectLettersGuessed.append(letterGuess!)
                incorrectGuesses.text! = incorrectGuesses.text! + letterGuess!.uppercaseString + " "
                numberOfWrongGuesses = numberOfWrongGuesses + 1
                let changeHangmanImage = "hangman" + String(numberOfWrongGuesses) + ".gif"
                hangmanImage.image = UIImage(named: changeHangmanImage)
                self.hangmanImage.reloadInputViews()
                if (numberOfWrongGuesses >= 7) {
                    self.presentViewController(loseAlertController!, animated: true, completion: nil)
                }
            }
        }
    }
    
    //Integrated with guess button
    /*
    func incorrectButtonFunction() {
        letterGuess = letterGuessing.text
        if (numberOfWrongGuesses >= 7) {
            self.presentViewController(loseAlertController!, animated: true, completion: nil)
        } else if (numberOfUniqueCharactersInPhrase == correctLettersGuessed.count) {
            self.presentViewController(winAlertController!, animated: true, completion: nil)
        } else if (letterGuess!.characters.count > 1) {
            self.presentViewController(letterAlertController!, animated: true, completion: nil)
        } else if (correctLettersGuessed.contains(letterGuess!) || incorrectLettersGuessed.contains(letterGuess!)) {
            self.presentViewController(alreadyGuessedAlertController!, animated: true, completion: nil)
        } else {
            if (hangmanWord.text?.characters.count > 0 && phrase!.rangeOfString(letterGuess!.uppercaseString) == nil) {
                incorrectLettersGuessed.append(letterGuess!)
                incorrectGuesses.text! = incorrectGuesses.text! + letterGuess!.uppercaseString + " "
                numberOfWrongGuesses = numberOfWrongGuesses + 1
                let changeHangmanImage = "hangman" + String(numberOfWrongGuesses) + ".gif"
                hangmanImage.image = UIImage(named: changeHangmanImage)
                self.hangmanImage.reloadInputViews()
                if (numberOfWrongGuesses >= 7) {
                    self.presentViewController(loseAlertController!, animated: true, completion: nil)
                }
            }
        }
    }
    */
    
    @IBOutlet weak var newGameButton: UIBarButtonItem!
    @IBAction func newGameButtonFunction(sender: UIBarButtonItem) {
        self.viewDidLoad()
    }
    
    @IBOutlet weak var startOverButton: UIBarButtonItem!
    @IBAction func startOverButtonFunction(sender: AnyObject) {
        loadInterface()
    }
    
    func loadInterface() {
        numberOfUniqueCharactersInPhrase = 0
        numberOfWrongGuesses = 1
        letterGuessing.text = ""
        hangmanWord.text = ""
        hangmanImage.image = UIImage(named: "hangman1.gif")
        incorrectGuesses.text = "Incorrect Guesses: "
        var uniqueLettersInPhrase = [String]()
        for letter in phrase!.characters {
            if (String(letter).stringByTrimmingCharactersInSet(whitespaceSet) == "") {
                hangmanWord.text = hangmanWord.text! + " "
            } else {
                hangmanWord.text = hangmanWord.text! + "-"
                if (!uniqueLettersInPhrase.contains(String(letter))) {
                    numberOfUniqueCharactersInPhrase = numberOfUniqueCharactersInPhrase! + 1
                    uniqueLettersInPhrase.append(String(letter))
                }
            }
        }
        correctLettersGuessed = [String]()
        incorrectLettersGuessed = [String]()
        guessButton.layer.borderWidth = 1.0
        guessButton.layer.borderColor = UIColor(red: 0, green: 0, blue: 190/255, alpha: 1).CGColor
        guessButton.layer.cornerRadius = 4.0
        guessButton.addTarget(self, action: "correctButtonFunction", forControlEvents: .TouchUpInside)
        //correctButton.layer.borderWidth = 1.0
        //correctButton.layer.borderColor = UIColor(red: 0, green: 0, blue: 190/255, alpha: 1).CGColor
        //correctButton.layer.cornerRadius = 4.0
        //incorrectButton.layer.borderWidth = 1.0
        //incorrectButton.layer.borderColor = UIColor(red: 0, green: 0, blue: 190/255, alpha: 1).CGColor
        //incorrectButton.layer.cornerRadius = 4.0
        //correctButton.addTarget(self, action: "correctButtonFunction", forControlEvents: .TouchUpInside)
        //incorrectButton.addTarget(self, action: "incorrectButtonFunction", forControlEvents: .TouchUpInside)
        
        letterAlertController = UIAlertController(title: "Hangman", message:
            "Only one letter please!", preferredStyle: UIAlertControllerStyle.Alert)
        letterAlertController!.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
        winAlertController = UIAlertController(title: "Hangman", message:
            "You Win!", preferredStyle: UIAlertControllerStyle.Alert)
        winAlertController!.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
        loseAlertController = UIAlertController(title: "Hangman", message:
            "You Lose!", preferredStyle: UIAlertControllerStyle.Alert)
        loseAlertController!.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
        alreadyGuessedAlertController = UIAlertController(title: "Hangman", message:
            "You already guessed this letter!", preferredStyle: UIAlertControllerStyle.Alert)
        alreadyGuessedAlertController!.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
        lettersOnlyAlertController = UIAlertController(title: "Hangman", message:
            "You can only guess letters!", preferredStyle: UIAlertControllerStyle.Alert)
        lettersOnlyAlertController!.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
