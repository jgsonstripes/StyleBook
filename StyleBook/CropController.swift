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
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
