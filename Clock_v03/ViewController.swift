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
        addHourHand(to: circleView)
        addMinuteHand(to: circleView)
        addSecondHand(to: circleView)

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
            mark.frame.size.height = i % 5 == 0 ? 3 : 2
            mark.backgroundColor = i % 5 == 0 ? UIColor.red : UIColor.black
            mark.transform = CGAffineTransform(rotationAngle: angle)
            circleView.addSubview(mark)
        }
    }
    /*
    func addHourHand(to circleView: UIView, hour: CGFloat) {
        let centerPoint = CGPoint(x: circleView.bounds.midX, y: circleView.bounds.midY)
        let hourRadius = circleView.frame.width/3
        
        // Create a path for the hour hand
        let hourPath = UIBezierPath()
        hourPath.move(to: centerPoint)
        let hourAngle = hour/12.0 * 2.0 * CGFloat.pi - CGFloat.pi/2.0
        let hourEndPoint = CGPoint(x: cos(hourAngle) * hourRadius + centerPoint.x, y: sin(hourAngle) * hourRadius + centerPoint.y)
        hourPath.addLine(to: hourEndPoint)
        
        // Create a shape layer for the hour hand
        let hourLayer = CAShapeLayer()
        hourLayer.path = hourPath.cgPath
        hourLayer.lineWidth = 6
        hourLayer.strokeColor = UIColor.black.cgColor
        hourLayer.lineCap = .round
        
        // Add the hour layer to the circle view layer
        circleView.layer.addSublayer(hourLayer)
    }
     */
    
    func addHourHand(to circleView: UIView) {
        let centerPoint = CGPoint(x: circleView.bounds.midX, y: circleView.bounds.midY)
        let hourRadius = circleView.frame.width/3
        
        // Create a path for the hour hand
        let hourPath = UIBezierPath()
        hourPath.move(to: centerPoint)
        let hourAngle = getCurrentAngle(for: .hour, in: .current)
        let hourEndPoint = CGPoint(x: cos(hourAngle) * hourRadius + centerPoint.x, y: sin(hourAngle) * hourRadius + centerPoint.y)
        hourPath.addLine(to: hourEndPoint)
        
        // Create a shape layer for the hour hand
        let hourLayer = CAShapeLayer()
        hourLayer.path = hourPath.cgPath
        hourLayer.lineWidth = 6
        hourLayer.strokeColor = UIColor.black.cgColor
        hourLayer.lineCap = .round
        
        // Add the hour layer to the circle view layer
        circleView.layer.addSublayer(hourLayer)
        
        // Set up a timer to update the hour hand every minute
        let timer = Timer(fire: Date(), interval: 60.0, repeats: true) { [self] (timer) in
            let hourAngle = getCurrentAngle(for: .hour, in: .current)
            let hourEndPoint = CGPoint(x: cos(hourAngle) * hourRadius + centerPoint.x, y: sin(hourAngle) * hourRadius + centerPoint.y)
            hourPath.removeAllPoints()
            hourPath.move(to: centerPoint)
            hourPath.addLine(to: hourEndPoint)
            hourLayer.path = hourPath.cgPath
        }
        RunLoop.current.add(timer, forMode: .default)
    }
    
    func addMinuteHand(to circleView: UIView) {
        let centerPoint = CGPoint(x: circleView.bounds.midX, y: circleView.bounds.midY)
        let minuteRadius = circleView.frame.width/2.5
        
        // Create a path for the minute hand
        let minutePath = UIBezierPath()
        minutePath.move(to: centerPoint)
        let minuteAngle = getCurrentAngle(for: .minute, in: .current)
        let minuteEndPoint = CGPoint(x: cos(minuteAngle) * minuteRadius + centerPoint.x, y: sin(minuteAngle) * minuteRadius + centerPoint.y)
        minutePath.addLine(to: minuteEndPoint)
        
        // Create a shape layer for the minute hand
        let minuteLayer = CAShapeLayer()
        minuteLayer.path = minutePath.cgPath
        minuteLayer.lineWidth = 6
        minuteLayer.strokeColor = UIColor.black.cgColor
        minuteLayer.lineCap = .round
        
        // Add the minute layer to the circle view layer
        circleView.layer.addSublayer(minuteLayer)
        
        // Set up a timer to update the minute hand every second
        let timer = Timer(fire: Date(), interval: 1.0, repeats: true) { [self] (timer) in
            let minuteAngle = getCurrentAngle(for: .minute, in: .current)
            let minuteEndPoint = CGPoint(x: cos(minuteAngle) * minuteRadius + centerPoint.x, y: sin(minuteAngle) * minuteRadius + centerPoint.y)
            minutePath.removeAllPoints()
            minutePath.move(to: centerPoint)
            minutePath.addLine(to: minuteEndPoint)
            minuteLayer.path = minutePath.cgPath
        }
        RunLoop.current.add(timer, forMode: .default)
    }
    
    func addSecondHand(to circleView: UIView) {
        let centerPoint = CGPoint(x: circleView.bounds.midX, y: circleView.bounds.midY)
        let secondRadius = circleView.frame.width/2.5
        
        // Create a path for the second hand
        let secondPath = UIBezierPath()
        secondPath.move(to: centerPoint)
        let secondAngle = getCurrentAngle(for: .second, in: .current)
        let secondEndPoint = CGPoint(x: cos(secondAngle) * secondRadius + centerPoint.x,
                                     y: sin(secondAngle) * secondRadius + centerPoint.y)
        secondPath.addLine(to: secondEndPoint)
        
        // Create a shape layer for the second hand
        let secondLayer = CAShapeLayer()
        secondLayer.path = secondPath.cgPath
        secondLayer.lineWidth = 4
        secondLayer.strokeColor = UIColor.orange.cgColor
        secondLayer.lineCap = .round
        
        // Add the second layer to the circle view layer
        circleView.layer.addSublayer(secondLayer)
        
        // Set up a timer to update the second hand every second
        let timer = Timer(fire: Date(), interval: 1.0, repeats: true) { [self] (timer) in
            let secondAngle = getCurrentAngle(for: .second, in: .current)
            let secondEndPoint = CGPoint(x: cos(secondAngle) * secondRadius + centerPoint.x, y: sin(secondAngle) * secondRadius + centerPoint.y)
            secondPath.removeAllPoints()
            secondPath.move(to: centerPoint)
            secondPath.addLine(to: secondEndPoint)
            secondLayer.path = secondPath.cgPath
        }
        RunLoop.current.add(timer, forMode: .default)
    }

    /*
    func getCurrentMinuteAngle() -> CGFloat {
        let calendar = Calendar.current
        let minute = CGFloat(calendar.component(.minute, from: Date()))
        let minuteAngle = minute / 30.0 * CGFloat.pi
        return minuteAngle
    }


    func getCurrentHourAngle() -> CGFloat {
        let calendar = Calendar.current
        let hour = CGFloat(calendar.component(.hour, from: Date()))
        let minute = CGFloat(calendar.component(.minute, from: Date()))
        let hourAngle = (hour + minute/60.0) / 12.0 * 2.0 * CGFloat.pi - CGFloat.pi/2.0
        return hourAngle
    }
    
    func getCurrentAngle(for component: Calendar.Component, in calendar: Calendar) -> CGFloat {
        let now = Date()
        let componentValue = CGFloat(calendar.component(component, from: now))
        let totalValue: CGFloat
        let max: CGFloat
        
        switch component {
        case .hour:
            totalValue = 12.0
            max = 24.0
        case .minute:
            totalValue = 60.0
            max = 60.0
        case .second:
            totalValue = 60.0
            max = 60.0
        default:
            totalValue = 1.0
            max = 1.0
        }
        
        let angle = 2.0 * CGFloat.pi * (componentValue / totalValue) - CGFloat.pi / 2.0
        let offset = 2.0 * CGFloat.pi * ((componentValue / max) / totalValue)
        return angle + offset
    }
     */
    
    func getCurrentAngle(for component: Calendar.Component, in calendar: Calendar) -> CGFloat {
        let now = Date()
        let components = calendar.dateComponents([.hour, .minute, .second, .nanosecond], from: now)
        var componentValue: CGFloat = 0.0
        var totalValue: CGFloat = 0.0
        var max: CGFloat = 0.0
        
        switch component {
        case .hour:
            componentValue = CGFloat(components.hour ?? 0)
            totalValue = 12.0
            max = 24.0
        case .minute:
            componentValue = CGFloat(components.minute ?? 0)
            totalValue = 60.0
            max = 60.0
        case .second:
            componentValue = CGFloat(components.second ?? 0)
            totalValue = 60.0
            max = 60.0
        case .nanosecond:
            componentValue = CGFloat(components.nanosecond ?? 0)
            totalValue = 1_000_000_000.0
            max = 1_000_000_000.0
        default:
            break
        }
        
        let angle = 2.0 * CGFloat.pi * (componentValue / totalValue) - CGFloat.pi / 2.0
        let offset = 2.0 * CGFloat.pi * ((componentValue / max) / totalValue)
        return angle + offset
    }
}
