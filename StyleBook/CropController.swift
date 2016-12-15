//
//  CropController.swift
//  StyleBook
//
//  Created by 스트라입스 on 2016. 12. 13..
//  Copyright © 2016년 jgson. All rights reserved.
//

import UIKit

class CropController: UIViewController {

    @IBAction func picture(_ sender: UIBarButtonItem) {
        let picker = UIImagePickerController()
        picker.view.backgroundColor = UIColor.white
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    @IBAction func crop(_ sender: UIBarButtonItem) {
        
    }
    
    @IBAction func clear(_ sender: UIBarButtonItem) {
        graphPoints.removeAll()
        animateLinkWithDot.clearAllPoint()
    }
    
    @IBAction func back(_ sender: UIBarButtonItem) {

    }
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        
    }
    
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var animateLinkWithDot: BezierView!
    
    var model: CropModel?
    var graphPoints:[CGPoint] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model = CropModel(image: picture)
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
