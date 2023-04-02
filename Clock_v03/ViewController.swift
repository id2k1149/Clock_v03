//
//  ViewController.swift
//  Clock_v03
//
//  Created by Max Franz Immelmann on 4/1/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var squareView: UIView!
    @IBOutlet var circleView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        squareView.layer.cornerRadius = squareView.frame.width / 4
        
        circleView.layer.cornerRadius = circleView.frame.width / 2
        
        
        
    }


}

