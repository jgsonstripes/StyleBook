//
//  DrawView.swift
//  CropImage
//
//  Created by 스트라입스 on 2016. 11. 18..
//  Copyright © 2016년 스트라입스. All rights reserved.
//

import UIKit

class DrawView : UIImageView {
    var lastPoint: CGPoint!
    var maxX: CGFloat = 0
    var maxY: CGFloat = 0
    var minX: CGFloat = 1000
    var minY: CGFloat = 1000
    
    var array: [CGPoint] = []
    
    var displayView: UIImageView?
    var enlargeView: UIView?
    var enlargeImage: UIImageView?
    
    var firstPoint: CGPoint?
    
    let scribbleView = ScribbleView()
    var touchOrigin: ScribbleView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        scribbleView.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        self.addSubview(scribbleView)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let location = touches.first?.location(in: self) else { return }
        
        firstPoint = location
        if scribbleView.frame.contains(location) {
            touchOrigin = scribbleView
        } else {
            touchOrigin = nil
            return
        }
        
        if let adjustedLocationInView = touches.first?.location(in: touchOrigin) {
            scribbleView.beginScribble(adjustedLocationInView)
        }
        
        if enlargeView == nil {
            // 확대 이미지
            enlargeView = UIView(frame: CGRect(x: location.x, y: location.y, width: 100, height: 100))
            enlargeView?.backgroundColor = UIColor.clear
            enlargeView?.contentMode = .center
            let rect = CGRect(x: 25, y: 0, width: 50, height: 50)
            enlargeImage = UIImageView(frame: rect)
            enlargeImage?.contentMode = .scaleAspectFit
            let maskLayer = CALayer()
            maskLayer.frame = (enlargeImage?.bounds)!
            let circleLayer = CAShapeLayer()
            circleLayer.path = UIBezierPath(roundedRect: rect , cornerRadius: 100).cgPath
            circleLayer.fillColor = UIColor.black.cgColor
            maskLayer.addSublayer(circleLayer)
            enlargeView?.layer.mask = maskLayer
            enlargeView?.addSubview(enlargeImage!)
            self.addSubview(enlargeView!)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first,
            let coalescedTouches = event?.coalescedTouches(for: touch),
            let touchOrigin = touchOrigin else { return }
        
        coalescedTouches.forEach {
            scribbleView.appendScribble($0.location(in: touchOrigin))
        }
        
        let currentPoint = touch.location(in: self)
        enlargeView?.center = CGPoint(x: currentPoint.x, y: currentPoint.y - (enlargeView?.bounds.height)!/2)
        if let snap = displayView?.snapshot(of: CGRect(x: currentPoint.x - (enlargeImage?.bounds.width)!/2, y: currentPoint.y - (enlargeImage?.bounds.height)!/2, width: 50, height: 50)){
            let line = self.snapshot(of: CGRect(x: currentPoint.x - (enlargeImage?.bounds.width)!/2, y: currentPoint.y - (enlargeImage?.bounds.height)!/2, width: 50, height: 50))
            
            enlargeImage?.image = snap.mergeImage(frontImage: line!, size: CGSize(width: 50, height: 50))
        }

        setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        scribbleView.endScribble()
    }
    
    
    func setEnlargeViewGesture(gesture: UIPanGestureRecognizer) {
        if gesture.state == .began || gesture.state == .changed {
            let translation = gesture.translation(in: self.enlargeView)
            gesture.view?.center = CGPoint(x: (gesture.view?.center.x)! + translation.x, y: (gesture.view?.center.y)! + translation.y)
            gesture.setTranslation(CGPoint.zero, in: self.enlargeView)
        }
    }
}



