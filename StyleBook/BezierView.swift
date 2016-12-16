//
//  BezierView.swift
//  Bezier
//
//  Created by Ramsundar Shandilya on 10/14/15.
//  Copyright © 2015 Y Media Labs. All rights reserved.
//

import UIKit
import Foundation

protocol BezierViewDataSource: class {
    func bezierViewDataPoints(_ bezierView: BezierView) -> [CGPoint]
}

struct BackPosition {
    var point: CAShapeLayer?
    var line: CAShapeLayer?
}

class BezierView: UIView {
   
    fileprivate let kStrokeAnimationKey = "StrokeAnimationKey"
    fileprivate let kFadeAnimationKey = "FadeAnimationKey"
    
    weak var dataSource: BezierViewDataSource?
    
    var lineColor = UIColor(red: 203/255, green: 67/255, blue: 53/255, alpha: 1.0)
    
    var pointLayers = [CAShapeLayer]()
    var lineLayers = [CAShapeLayer]()
    
    var backStack = [BackPosition]()
    
    fileprivate var dataPoints: [CGPoint]? {
        return self.dataSource?.bezierViewDataPoints(self)
    }
    
    var endLine: CAShapeLayer?
    var firstPoint: CAShapeLayer?
    
    override func layoutSubviews() {
        animateLayers()
    }
    
    func addPoint() {
        self.layer.sublayers?.forEach({
            if $0 == endLine {
                $0.removeFromSuperlayer()
            }
        })
        pointLayers.removeAll()
        lineLayers.removeAll()
        
        drawSmoothLines()
        drawPoints()
        drawEndLine()
        
        if let point = pointLayers.last, 0 <= (lineLayers.count - 2) {
            var back = BackPosition()
            back.point = point
            back.line = lineLayers[lineLayers.count - 2]
            
            self.backStack.append(back)
        }
    }
    
    func backPointPosition() {
        if backStack.count >= 1 {
            backStack.last?.line?.removeFromSuperlayer()
            backStack.last?.point?.removeFromSuperlayer()
            if let line = endLine {
                line.removeFromSuperlayer()
            }
            backStack.removeLast()
        } else {
            clearAllPoint()
        }
    }
    
    func clearAllPoint() {
        self.layer.sublayers?.forEach({
            $0.removeFromSuperlayer()
        })
        firstPoint = nil
        endLine = nil
        pointLayers.removeAll()
        lineLayers.removeAll()
    }
    
    fileprivate func drawPoints(){
        
        guard let points = dataPoints, (dataPoints?.count)! >= 1 else {
            return
        }
        
        let circleLayer = setPointLayer(position: points.last!)
        if points.count == 1 {
            firstPoint = circleLayer
        }
    }
    
    fileprivate func drawSmoothLines() {
        
        guard let points = dataPoints, (dataPoints?.count)! >= 2 else {
            return
        }
        
        let pre = points[points.count - 2]
        if let last = points.last {
            let linePath = setBezierPath(move: pre, addLine: last)
            let _ = setLineLayer(path: linePath.cgPath)
        }
    }
    
    fileprivate func drawEndLine() {
        
        guard let points = dataPoints, (dataPoints?.count)! >= 3 else {
            return
        }
        
        if let first = points.first, let last = points.last {
            let linePath = setBezierPath(move: first, addLine: last)
            endLine = setLineLayer(path: linePath.cgPath)
        }
    }
    
    private func setBezierPath(move: CGPoint, addLine: CGPoint) -> UIBezierPath {
        let linePath = UIBezierPath()
        
        linePath.move(to: move)
        linePath.addLine(to: addLine)
        
        return linePath
    }
    
    private func setLineLayer(path: CGPath) -> CAShapeLayer {
        
        let lineLayer = CAShapeLayer()
        lineLayer.path = path
        lineLayer.lineCap = kCALineCapRound
        lineLayer.fillColor = UIColor.clear.cgColor
        lineLayer.strokeColor = lineColor.cgColor
        lineLayer.lineWidth = 3.0
        
        lineLayer.shadowColor = UIColor.black.cgColor
        lineLayer.shadowOffset = CGSize(width: 0, height: 8)
        lineLayer.shadowOpacity = 0.5
        lineLayer.shadowRadius = 6.0
        
        self.layer.insertSublayer(lineLayer, below: pointLayers.last)
        lineLayers.append(lineLayer)
        lineLayer.strokeEnd = 0
        
        return lineLayer
    }
    
    private func setPointLayer(position: CGPoint) -> CAShapeLayer {
        let circleLayer = CAShapeLayer()
        circleLayer.bounds = CGRect(x: 0, y: 0, width: 6, height: 6)
        circleLayer.path = UIBezierPath(ovalIn: circleLayer.bounds).cgPath
        circleLayer.fillColor = UIColor(white: 248.0/255.0, alpha: 0.5).cgColor
        circleLayer.position = position
        
        circleLayer.shadowColor = UIColor.black.cgColor
        circleLayer.shadowOffset = CGSize(width: 0, height: 2)
        circleLayer.shadowOpacity = 0.7
        circleLayer.shadowRadius = 3.0
        
        self.layer.insertSublayer(circleLayer, above: lineLayers.last)
        
        circleLayer.opacity = 0
        pointLayers.append(circleLayer)
        
        return circleLayer
    }
}

extension BezierView {
    
    func animateLayers() {
        animateLastPoint()
        animateLine()
    }
    
    func animateLastPoint() {
        let fadeAnimation = CABasicAnimation(keyPath: "opacity")
        fadeAnimation.toValue = 1
        fadeAnimation.beginTime = CACurrentMediaTime()
        fadeAnimation.duration = 0.1
        fadeAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        fadeAnimation.fillMode = kCAFillModeForwards
        fadeAnimation.isRemovedOnCompletion = false
        pointLayers.last?.add(fadeAnimation, forKey: kFadeAnimationKey)
    }
    
    func animateLine() {
        if lineLayers.count >= 2 {
            lineLayers[lineLayers.count - 2].add(getGrowAnimation(), forKey: kStrokeAnimationKey)
        }
        lineLayers.last?.add(getGrowAnimation(), forKey: kStrokeAnimationKey)
    }
    
    func getGrowAnimation() -> CABasicAnimation {
        let growAnimation = CABasicAnimation(keyPath: "strokeEnd")
        growAnimation.toValue = 1
        growAnimation.beginTime = CACurrentMediaTime()
        growAnimation.duration = 0.2
        growAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        growAnimation.fillMode = kCAFillModeForwards
        growAnimation.isRemovedOnCompletion = false
        
        return growAnimation
    }
    
}

