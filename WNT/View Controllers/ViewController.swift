//
//  ViewController.swift
//  WNT
//
//  Created by AD on 07/12/2019.
//  Copyright © 2019 AD. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var signUpButton: UIButton!
    
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()
        // Do any additional setup after loading the view.
    }
    
    func setUpElements(){
        Utilities.styleHollowButton(signUpButton)
        Utilities.styleHollowButton(loginButton)
    }


}

