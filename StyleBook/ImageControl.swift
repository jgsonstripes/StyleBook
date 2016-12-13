//
//  ImageControl.swift
//  CropImage
//
//  Created by 스트라입스 on 2016. 11. 25..
//  Copyright © 2016년 스트라입스. All rights reserved.
//

import UIKit

@IBDesignable
class ImageControl: UIImageView {

    var corner: [CGRect] = []
    
    let circleDiameter: CGFloat = 15
    let circlePosition: CGFloat = 7.5
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(image: UIImage?) {
        super.init(image: image)
    }

    func setup() {
        let leftTop = CGRect(x: -circlePosition, y: -circlePosition, width: circleDiameter, height: circleDiameter)
        let rightTop = CGRect(x: bounds.width - circlePosition, y: -circlePosition, width: circleDiameter, height: circleDiameter)
        let leftBottom = CGRect(x: -circlePosition, y: bounds.height - circlePosition, width: circleDiameter, height: circleDiameter)
        let rightBottom = CGRect(x: bounds.width - circlePosition, y: bounds.height - circlePosition, width: circleDiameter, height: circleDiameter)
        corner.append(leftTop)
        corner.append(rightTop)
        corner.append(leftBottom)
        corner.append(rightBottom)
        
        for rect in corner {
            let circle = UIView(frame: rect)
            circle.layer.cornerRadius = min(circle.frame.size.height, circle.frame.size.width) / 2.0
            circle.backgroundColor = UIColor.brown
            self.addSubview(circle)
        }
    }
}
