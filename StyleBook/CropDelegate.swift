//
//  CropDelegate.swift
//  StyleBook
//
//  Created by 스트라입스 on 2016. 12. 13..
//  Copyright © 2016년 jgson. All rights reserved.
//

import UIKit

extension CropController: UIImagePickerControllerDelegate, UINavigationControllerDelegate, BezierViewDataSource {
    
    @IBAction func touchDot(gesture: UITapGestureRecognizer) {
        let point = gesture.location(in: animateLinkWithDot)
        graphPoints.append(point)
        animateLinkWithDot.addPoint()
    }
    
    @IBAction func picture(_ sender: UIBarButtonItem) {
        let picker = UIImagePickerController()
        picker.view.backgroundColor = UIColor.white
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    @IBAction func crop(_ sender: UIBarButtonItem) {
        let cropImage = model.cropStart(image: picture.image!, cropPath: graphPoints, cropRect: cropRect, pan: UIPanGestureRecognizer(target: self, action: #selector(self.moveCropImage(gesture:))))
        cropImage.center = self.view.center
        cropRect.reset()
        self.view.addSubview(cropImage)
    }
    
    @IBAction func moveCropImage(gesture: UIPanGestureRecognizer) {
        if gesture.state == .began || gesture.state == .changed {
            let translation = gesture.translation(in: self.view)
            gesture.view?.center = CGPoint(x: (gesture.view?.center.x)! + translation.x, y: (gesture.view?.center.y)! + translation.y)
            gesture.setTranslation(CGPoint.zero, in: self.view)
        }
    }
    
    @IBAction func clear(_ sender: UIBarButtonItem) {
        graphPoints.removeAll()
        animateLinkWithDot.clearAllPoint()
    }
    
    @IBAction func back(_ sender: UIBarButtonItem) {
        animateLinkWithDot.backPointPosition()
        self.graphPoints.removeLastAndFirst()
    }
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let imagePicker = info[UIImagePickerControllerOriginalImage] as? UIImage {
            picture.image = model.resizeImage(image: imagePicker, newHeight: picture.bounds.size.height, newWidth: picture.bounds.size.width)
        } else{
            print("Something went wrong")
        }
        dismiss(animated: true, completion: nil)
    }
    
    func bezierViewDataPoints(_ bezierView: BezierView) -> [CGPoint] {
        return graphPoints
    }
}
