//
//  CropModel.swift
//  CropImage
//
//  Created by 스트라입스 on 2016. 12. 1..
//  Copyright © 2016년 스트라입스. All rights reserved.
//

import UIKit
import CoreData

class CropModel:NSObject {
    
    var draw: DrawView?
    var image: UIImageView?
    
    var cropedImageView: EnlargeView?
    var widthRatio: CGFloat = 0
    var heightRatio: CGFloat = 0
    
    init(draw: DrawView, image: UIImageView) {
        self.draw = draw
        self.image = image
        
        self.draw?.displayView = image
    }
    
    func cropStart(pan: UIPanGestureRecognizer, long: UILongPressGestureRecognizer) {
        if let draw = draw {
//            let width = draw.maxX - draw.minX
//            let height = draw.maxY - draw.minY
//            let portion = CGRect(x: draw.minX, y: draw.minY, width: width, height: height)
//            
//            cropedImageView = ImageControl(image:cropImage(toRect: portion))
//            cropedImageView?.isUserInteractionEnabled = true
//            // 잘라진 이미지를 addSubview
//            
//            cropedImageView?.addGestureRecognizer(pan)
//            cropedImageView?.addGestureRecognizer(long)
//            
//            let lines = draw.lines
//            let path = UIBezierPath()
//            path.move(to: CGPoint(x: (lines.first?.startX)! - draw.minX, y: (lines.first?.startY)! - draw.minY))
//            for i in 0..<(lines.count) {
//                path.addLine(to: CGPoint(x: (lines[i].startX) - draw.minX, y: (lines[i].startY) - draw.minY))
//            }
//            
//            path.close()
//            
//            let maskLayer = CALayer()
//            maskLayer.frame = (cropedImageView?.bounds)!
//            let circleLayer = CAShapeLayer()
//            //assume the circle's radius is 100
//            circleLayer.path = path.cgPath
//            circleLayer.fillColor = UIColor.black.cgColor
//            maskLayer.addSublayer(circleLayer)
//            
//            cropedImageView?.layer.mask = maskLayer
        }
    }
    
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage{
        return image.resizedImageWithinRect(resizeWidth: newWidth)
    }
    
    func cropImage(toRect rect:CGRect) -> UIImage{
        if let draw = draw, let img = image?.image {
            let sc = img.scale
            let croprect = CGRect(x: draw.minX * sc, y: draw.minY * sc, width: rect.width * sc, height: rect.height * sc)
            let imageRef = img.cgImage!.cropping(to: croprect)!
            let croppedimage = UIImage(cgImage: imageRef, scale: img.scale, orientation: img.imageOrientation)
            
            return croppedimage
        }
        return UIImage()
    }
}
