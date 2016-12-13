//
//  UIImageExtension.swift
//  StyleBook
//
//  Created by 스트라입스 on 2016. 12. 13..
//  Copyright © 2016년 jgson. All rights reserved.
//

import UIKit

extension UIImage {
    func resizedImage(rect: CGRect) -> UIImage {
        // Guard newSize is different
        guard self.size != rect.size else { return self }
        
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0);
        self.draw(in: rect)
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
    func mergeImage(frontImage: UIImage, size: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(size)
        
        let areaSize = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        self.draw(in: areaSize)
        frontImage.draw(in: areaSize, blendMode: .normal, alpha: 1.0)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
}
