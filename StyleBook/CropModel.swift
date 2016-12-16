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
    var widthRatio: CGFloat = 0
    var heightRatio: CGFloat = 0
    
    override init() {}
    
    func cropStart(imageView: UIImageView, cropPath: [CGPoint], cropRect: CropRectangle, pan: UIPanGestureRecognizer) -> UIImageView{
        let width = cropRect.maxX - cropRect.minX
        let height = cropRect.maxY - cropRect.minY
        let scale = imageView.image?.scale
        let portion = CGRect(x: cropRect.minX * scale!, y: cropRect.minY * scale!, width: width * scale!, height: height * scale!)
        
        let cropedImageView = UIImageView(image: cropImage(img: imageView.image!, toRect: portion))
        cropedImageView.isUserInteractionEnabled = true
        cropedImageView.addGestureRecognizer(pan)
        
        let path = UIBezierPath()
        
        cropPath.enumerated().forEach { (index, point) in
            if index == 0 {
                path.move(to: point)
            } else {
                path.addLine(to: point)
            }
        }
        path.close()
        
        let maskLayer = CALayer()
        maskLayer.frame = cropedImageView.bounds
        let circleLayer = CAShapeLayer()
        circleLayer.path = path.cgPath
        circleLayer.fillColor = UIColor.black.cgColor
        maskLayer.addSublayer(circleLayer)
        cropedImageView.layer.mask = maskLayer
        
        return cropedImageView
    }
    
    func resizeImage(image: UIImage, newHeight: CGFloat, newWidth: CGFloat) -> UIImage{
        return image.resizedImageWithinRect(resizeWidth: newWidth, resizeHeight: newHeight).image!
    }
    
    func cropImage(img: UIImage, toRect rect:CGRect) -> UIImage{
        let imageRef = img.cgImage!.cropping(to: rect)!
        let croppedImage = UIImage(cgImage: imageRef, scale: img.scale, orientation: img.imageOrientation)
        
        return croppedImage
    }
}
