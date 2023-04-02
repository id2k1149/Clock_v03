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
        
        setHours(to: circleView)
        addMinuteMarks(to: circleView)

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
    func setHours(to circleView: UIView) {
        
        let labelSize = CGSize(width: 50, height: 50)
        let circleRadius = circleView.frame.width/2 - labelSize.width/2 - 10
                                 
        for i in 0..<12 {
            let label = UILabel(frame: CGRect(origin: .zero, size: labelSize))
            let angle = CGFloat(i) / 12.0 * 2.0 * CGFloat.pi - CGFloat.pi/2.0
            let x = cos(angle) * circleRadius + circleView.frame.width/2
            let y = sin(angle) * circleRadius + circleView.frame.height/2
            label.center = CGPoint(x: x, y: y)
            label.text = "\(i == 0 ? 12 : i)"
            label.font = UIFont.boldSystemFont(ofSize: 30)
            label.textAlignment = .center
            circleView.addSubview(label)
        }
    }
    
    /*
    func addMinuteMarks(to circleView: UIView) {
        let markSize = CGSize(width: 4, height: 4)
        let markRadius = circleView.frame.width/2 - markSize.width/2 - 5
        
        for i in 0..<60 {
            let mark = UIView(frame: CGRect(origin: .zero, size: markSize))
            let angle = CGFloat(i) / 60.0 * 2.0 * CGFloat.pi - CGFloat.pi/2.0
            let x = cos(angle) * markRadius + circleView.frame.width/2
            let y = sin(angle) * markRadius + circleView.frame.height/2
            mark.center = CGPoint(x: x, y: y)
            mark.backgroundColor = i % 5 == 0 ? UIColor.red : UIColor.black
            mark.layer.cornerRadius = markSize.width/2
            circleView.addSubview(mark)
        }
    }
     */
    
    func addMinuteMarks(to circleView: UIView) {
        let markSize = CGSize(width: 8, height: 2)
        let markRadius = circleView.frame.width/2 - markSize.width
        
        for i in 0..<60 {
            let mark = UIView(frame: CGRect(origin: .zero, size: markSize))
            let angle = CGFloat(i) / 60.0 * 2.0 * CGFloat.pi - CGFloat.pi/2.0
            let x = cos(angle) * markRadius + circleView.frame.width/2
            let y = sin(angle) * markRadius + circleView.frame.height/2
            mark.center = CGPoint(x: x, y: y)
            mark.backgroundColor = UIColor.black
            if i % 5 == 0 {
                mark.frame.size.height = 3
            }
            mark.backgroundColor = i % 5 == 0 ? UIColor.red : UIColor.black
//            mark.layer.cornerRadius = markSize.width/2
            mark.transform = CGAffineTransform(rotationAngle: angle)
            circleView.addSubview(mark)
        }
    }



    
}

