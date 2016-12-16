//
//  UIImageExtension.swift
//  StyleBook
//
//  Created by 스트라입스 on 2016. 12. 13..
//  Copyright © 2016년 jgson. All rights reserved.
//

import UIKit

extension UIImage {
    
    func mergeImage(frontImage: UIImage, size: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(size)
        
        let areaSize = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        self.draw(in: areaSize)
        frontImage.draw(in: areaSize, blendMode: .normal, alpha: 1.0)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
    
    func resizedImage(newSize: CGSize) -> UIImage {
        guard self.size != newSize else { return self }
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        self.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
    struct ImageAndBlankSize{
        var image: UIImage?
        var widthSize: CGFloat = 0 {
            didSet {
                isSize = true
            }
        }
        var heightSize: CGFloat = 0 {
            didSet {
                isSize = false
            }
        }
        var isSize: Bool = true
    }
    
    func resizedImageWithinRect(resizeWidth: CGFloat, resizeHeight: CGFloat) -> ImageAndBlankSize {
        let widthFactor = size.width / resizeWidth
        let heightFactor = size.height / resizeHeight
        var imageAndBlank = ImageAndBlankSize()
        
        var factor: CGFloat = 0
        
        if widthFactor > heightFactor {
            factor = widthFactor
            imageAndBlank.heightSize = size.height / factor
        } else {
            factor = heightFactor
            imageAndBlank.widthSize = size.width / factor
        }
        
        let resized = resizedImage(newSize: CGSize(width: size.width / factor, height: size.height / factor))
        imageAndBlank.image = resized
        
        return imageAndBlank
    }
}
