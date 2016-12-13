//
//  Line.swift
//  CropImage
//
//  Created by 스트라입스 on 2016. 11. 24..
//  Copyright © 2016년 스트라입스. All rights reserved.
//

import UIKit

class Line {
    var start: CGPoint
    var end: CGPoint
    
    var startX: CGFloat {
        get {
            return start.x
        }
    }
    
    var startY: CGFloat {
        get {
            return start.y
        }
    }
    
    var endX: CGFloat {
        get {
            return end.x
        }
    }
    
    var endY: CGFloat {
        get {
            return end.y
        }
    }
    
    init(start _start: CGPoint, end _end: CGPoint) {
        start = _start
        end = _end
    }
}
