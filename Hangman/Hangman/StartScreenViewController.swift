//
//  StartScreenViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class StartScreenViewController: UIViewController {
    
    @IBOutlet var startScreenLabel : UILabel!
    @IBOutlet var newGameButton : UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        startScreenLabel.text = "HANGMAN"
        startScreenLabel.font = UIFont(name:"AmericanTypewriter-Bold", size: 24)
        newGameButton.titleLabel!.font = UIFont(name:"AmericanTypewriter", size: 18)
        newGameButton.layer.borderWidth = 1.0
        newGameButton.layer.borderColor = UIColor(red: 0, green: 0, blue: 190/255, alpha: 1).CGColor
        newGameButton.layer.cornerRadius = 4.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
