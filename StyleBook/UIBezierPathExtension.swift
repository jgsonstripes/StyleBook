//
//  UIBezierPathExtension.swift
//  SmoothScribble
//
//  Created by Simon Gladman on 04/11/2015.
//  Copyright © 2015 Simon Gladman. All rights reserved.
//

import UIKit

extension UIBezierPath
{
    func interpolatePointsWithHermite(_ interpolationPoints : [CGPoint], alpha : CGFloat = 1.0/3.0)
    {
        guard !interpolationPoints.isEmpty else { return }
        
        
        func midPoint(point1: CGFloat, point2: CGFloat) -> CGFloat{
            return (point1 - point2) / 2.0
        }
        
        func midPoint2(point1: CGFloat, point2: CGFloat) -> CGFloat{
            return (point1 + point2) / 2.0
        }
        // CGPoint[0] 첫 터치 부분으로 이동
        self.move(to: interpolationPoints[0])
        
        // index를 위한 전체 배열 길이에서 -1
        let n = interpolationPoints.count - 1
        
        // for 문으로 각각의 CGPoint를 가공
        for index in 0..<n {
            var currentPoint = interpolationPoints[index]
            var nextIndex = (index + 1) % interpolationPoints.count
            var prevIndex = index == 0 ? interpolationPoints.count - 1 : index - 1
            var previousPoint = interpolationPoints[prevIndex]
            var nextPoint = interpolationPoints[nextIndex]
            let endPoint = nextPoint
            var mx : CGFloat
            var my : CGFloat
            
            if index > 0 {
                // 첫 터치를 제외한 모든 CGPoint
                mx = (nextPoint.x - previousPoint.x) / 2.0
                my = (nextPoint.y - previousPoint.y) / 2.0
            } else {
                // 첫 터치
                mx = (nextPoint.x - nextPoint.x) / 2.0
                my = (nextPoint.y - currentPoint.y) / 2.0
            }
            
            let controlPoint1 = CGPoint(x: currentPoint.x + mx * alpha, y: currentPoint.y + my * alpha)
            
            currentPoint = interpolationPoints[nextIndex]
            nextIndex = (nextIndex + 1) % interpolationPoints.count
            prevIndex = index
            previousPoint = interpolationPoints[prevIndex]
            nextPoint = interpolationPoints[nextIndex]
            
            if index < n - 1 {
                // 마지막 터치를 제외한 모든 터치
                mx = (nextPoint.x - previousPoint.x) / 2.0
                my = (nextPoint.y - previousPoint.y) / 2.0
            } else {
                // 마지막 터치
                mx = (currentPoint.x - previousPoint.x) / 2.0
                my = (currentPoint.y - previousPoint.y) / 2.0
            }
            
            let controlPoint2 = CGPoint(x: currentPoint.x - mx * alpha, y: currentPoint.y - my * alpha)
            
            if n == 2 {
                self.addLine(to: endPoint)
            } else if n==3 {
                self.addQuadCurve(to: endPoint, controlPoint: controlPoint2)
            } else{
                self.addCurve(to: endPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
            }
        }
    }
}
