//
//  ViewController.swift
//  SignTestApp
//
//  Created by Rafael Mukhametov on 16.03.18.
//  Copyright © 2018 Rafael Mukhametov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var authButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        authButton.clipsToBounds = true
        authButton.layer.cornerRadius = authButton.frame.size.height / 2
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

