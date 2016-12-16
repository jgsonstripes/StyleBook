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
    
    mutating func resize(frame: CGSize, resize: UIImage.ImageAndBlankSize?) {
        if let size = resize {
            if size.isSize {
                self.minX-=(frame.width - size.widthSize)/2
                self.maxX-=(frame.width - size.widthSize)/2
            } else {
                self.minY-=(frame.height - size.heightSize)/2
                self.maxY-=(frame.height - size.heightSize)/2
            }
        }
    }
}

class CropController: UIViewController {
    
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var animateLinkWithDot: BezierView!
    @IBOutlet weak var cropBottomScroll: UIScrollView!
    
    let model = CropModel()
    var cropRect = CropRectangle()
    var resizeImage : UIImage.ImageAndBlankSize?
    
    var graphPoints:[CGPoint] = [] {
        willSet {
            if newValue.count > 0 {
                guard let input = newValue.last else {
                    return
                }
                if (cropRect.minX > input.x) { (cropRect.minX = input.x) }
                if (cropRect.maxX < input.x) { (cropRect.maxX = input.x) }
                if (cropRect.minY > input.y) { (cropRect.minY = input.y) }
                if (cropRect.maxY < input.y) { (cropRect.maxY = input.y) }
            }
        }
        didSet {
            animateLinkWithDot.addPoint()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animateLinkWithDot.dataSource = self
        cropBottomScroll.delegate = self
        cropBottomScroll.contentSize = CGSize(width: cropBottomScroll.bounds.size.width / 4, height: cropBottomScroll.bounds.size.height)
        cropBottomScroll.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        cropBottomScroll.contentOffset = CGPoint(x: 0, y: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        self.animateLinkWithDot.layoutSubviews()
    }
}
