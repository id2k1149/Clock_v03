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
        
        setHours(circleView: circleView)

    }
    
    
    @IBAction func startButton(_ sender: UIButton) {
//        markView.frame.origin.y += 200
        
        /*
        UIView.animate(
            withDuration: 1,
            delay: 0,
            options: [.autoreverse, .repeat]) { [unowned self] in
                markView.frame.origin.x += 20
                markView.frame.origin.y += 20
            }
         */
    }
    


}

extension UIViewController {
    func setHours(circleView: UIView) {
        
        let labelSize = CGSize(width: 50, height: 50)
        let circleRadius = circleView.frame.width/2 - labelSize.width/2
        let circleCenter = CGPoint(x: view.frame.width/2,
                                   y: view.frame.height/2)

        for i in 0..<12 {
            let label = UILabel(frame: CGRect(origin: .zero, size: labelSize))
            let angle = CGFloat(i) / 12.0 * 2.0 * CGFloat.pi - CGFloat.pi/2.0
            let x = cos(angle) * circleRadius + circleView.frame.width/2
            let y = sin(angle) * circleRadius + circleView.frame.height/2
            label.center = CGPoint(x: x, y: y)
            label.text = "\(i == 0 ? 12 : i)"
            label.textAlignment = .center
            circleView.addSubview(label)
        }

        


        
        
        
    }
}

