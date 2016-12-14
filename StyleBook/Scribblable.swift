//
//  Scribblable.swift
//  SmoothScribble
//
//  Created by Simon Gladman on 05/11/2015.
//  Copyright © 2015 Simon Gladman. All rights reserved.
//

import UIKit

// MARK: Scribblable protocol

protocol Scribblable
{
    func beginScribble(_ point: CGPoint)
    func appendScribble(_ point: CGPoint)
    func endScribble()
    func clearScribble()
}

// MARK: ScribbleView base class

class ScribbleView: UIView, Scribblable {
    
    let backgroundLayer = CAShapeLayer()
    let drawingLayer = CAShapeLayer()
    let hermitePath = UIBezierPath()
    var interpolationPoints = [CGPoint]()
    
    required init() {
        super.init(frame: CGRect.zero)
        
        backgroundLayer.lineCap = kCALineCapRound
        backgroundLayer.strokeColor = UIColor.darkGray.cgColor
        backgroundLayer.fillColor = nil
        backgroundLayer.lineWidth = 0.5
        
        drawingLayer.lineCap = kCALineCapRound
        drawingLayer.strokeColor = UIColor.black.cgColor
        drawingLayer.fillColor = nil
        drawingLayer.lineWidth = 0.5
        layer.addSublayer(backgroundLayer)
        layer.addSublayer(drawingLayer)
        
        layer.masksToBounds = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func layoutSubviews() {
        // addSubview 로 추가한 뷰의 Frame 설정
    }
    
    func beginScribble(_ point: CGPoint) {
        interpolationPoints = [point]
        let circlePath = UIBezierPath(arcCenter: point, radius: CGFloat(3), startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        
        //change the fill color
        shapeLayer.fillColor = UIColor.red.cgColor
        //you can change the stroke color
        shapeLayer.strokeColor = UIColor.red.cgColor
        //you can change the line width
        shapeLayer.lineWidth = 3.0
        
        drawingLayer.path = circlePath.cgPath
    }
    
    func appendScribble(_ point: CGPoint) {
        let a = interpolationPoints[interpolationPoints.count-1]
        let b = point
        let xDist = (b.x - a.x);
        let yDist = (b.y - a.y);
        let distance = sqrt((xDist * xDist) + (yDist * yDist));
        print("distance : \(distance)")
        if distance > 2  {
            if point.y > self.bounds.height {
                let newPoint = CGPoint(x: point.x, y: self.bounds.height)
                interpolationPoints.append(newPoint)
            } else if point.y < 0 {
                let newPoint = CGPoint(x: point.x, y: 0)
                interpolationPoints.append(newPoint)
            } else {
                interpolationPoints.append(point)
            }
        }
//        hermitePath.removeAllPoints()
//        hermitePath.interpolatePointsWithHermite(interpolationPoints)
        
//        drawingLayer.path = hermitePath.cgPath
        drawingLayer.path = UIBezierPath(catmullRomInterpolatedPoints: interpolationPoints, closed: false, alpha: 1)?.cgPath
    }
    
    func endScribble() {
        if let backgroundPath = backgroundLayer.path
        {
            hermitePath.append(UIBezierPath(cgPath: backgroundPath))
        }
        
//        backgroundLayer.path = hermitePath.cgPath
        backgroundLayer.path = UIBezierPath(catmullRomInterpolatedPoints: interpolationPoints, closed: false, alpha: 1)?.cgPath
        
        hermitePath.removeAllPoints()
        
//        drawingLayer.path = hermitePath.cgPath
        drawingLayer.path = UIBezierPath(catmullRomInterpolatedPoints: interpolationPoints, closed: false, alpha: 1)?.cgPath
    }
    
    func clearScribble() {
        backgroundLayer.path = nil
    }
    
}
