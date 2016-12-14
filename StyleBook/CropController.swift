//
//  CropController.swift
//  StyleBook
//
//  Created by 스트라입스 on 2016. 12. 13..
//  Copyright © 2016년 jgson. All rights reserved.
//

import UIKit

class CropController: UIViewController {

    @IBAction func crop(_ sender: UIBarButtonItem) {
        
    }
    
    @IBOutlet weak var animateLinkWithDot: BezierView!
    
    let dataPoints = [252, 220, 101, 2, 101, 220, 252]
    
    var xAxisPoints : [Double] {
        var points = [Double]()
        for i in 0..<dataPoints.count {
            let val = (Double(i)/6.0) * self.animateLinkWithDot.frame.width.f
            points.append(val)
        }
        
        return points
    }
    
    var yAxisPoints: [Double] {
        var points = [Double]()
        for i in dataPoints {
            let val = (Double(i)/255) * self.animateLinkWithDot.frame.height.f
            points.append(val)
        }
        
        return points
    }
    
    var graphPoints = [CGPoint(x: 100, y: 100),CGPoint(x: 20, y: 290),CGPoint(x: 40, y: 10)]
    
    
//    var graphPoints : [CGPoint] {
//        var points = [CGPoint]()
//        for i in 0..<dataPoints.count {
//            let val = CGPoint(x: self.xAxisPoints[i], y: self.yAxisPoints[i])
//            points.append(val)
//        }
//        
//        return points
//    }

    
    @IBAction func clear(_ sender: UIBarButtonItem) {
        draw.scribbleView.clearScribble()
        draw.setNeedsDisplay()
    }
    
    @IBAction func back(_ sender: UIBarButtonItem) {

    }
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        
    }
    
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var draw: DrawView!
    
    var model: CropModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        model = CropModel(draw: draw, image: picture)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
