//
//  CropController.swift
//  StyleBook
//
//  Created by 스트라입스 on 2016. 12. 13..
//  Copyright © 2016년 jgson. All rights reserved.
//

import UIKit

struct CropRectangle {
    var maxX: CGFloat = 0
    var maxY: CGFloat = 0
    var minX: CGFloat = 1000
    var minY: CGFloat = 1000
    
    mutating func reset() {
        self = CropRectangle()
    }
}

class CropController: UIViewController {
    
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var animateLinkWithDot: BezierView!
    
    let model = CropModel()
    var cropRect = CropRectangle()
    var graphPoints:[CGPoint] = [] {
        didSet {
            graphPoints.forEach {
                if cropRect.minX > $0.x {
                    cropRect.minX = $0.x
                } else if cropRect.maxX < $0.x {
                    cropRect.maxX = $0.x
                }
                
                if cropRect.minY > $0.y {
                    cropRect.minY = $0.y
                } else if cropRect.maxY < $0.y {
                    cropRect.maxY = $0.y
                }
                
                print("minX : \(cropRect.minX), minY : \(cropRect.minY), maxX : \(cropRect.maxX), maxY : \(cropRect.maxY)")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animateLinkWithDot.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        self.animateLinkWithDot.layoutSubviews()
    }
}
