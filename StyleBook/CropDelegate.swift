//
//  CropDelegate.swift
//  StyleBook
//
//  Created by 스트라입스 on 2016. 12. 13..
//  Copyright © 2016년 jgson. All rights reserved.
//

import UIKit

extension CropController: UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate, BezierViewDataSource {
    
    @IBAction func touchDot(gesture: UITapGestureRecognizer) {
        graphPoints.append(gesture.location(in: animateLinkWithDot))
    }
    
    @IBAction func picture(_ sender: UIBarButtonItem) {
        let picker = UIImagePickerController()
        picker.view.backgroundColor = UIColor.white
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    @IBAction func crop(_ sender: UIBarButtonItem) {
        cropRect.resize(frame: picture.bounds.size, resize: resizeImage)
        var widthBlank:CGFloat = 0
        var heightBlank:CGFloat = 0
        
        if (resizeImage?.isSize)! {
            widthBlank = (self.picture.bounds.size.width - (self.resizeImage?.widthSize)!)/2
        } else {
            heightBlank = (self.picture.bounds.size.height - (self.resizeImage?.heightSize)!)/2
        }
        
        let resizePoint = graphPoints.map {
            CGPoint(x: $0.x-widthBlank-cropRect.minX, y: $0.y-heightBlank-cropRect.minY)
        }
        
        let cropImage = model.cropStart(imageView: picture, cropPath: resizePoint, cropRect: cropRect, pan: UIPanGestureRecognizer(target: self, action: #selector(self.moveCropImage(gesture:))))
        cropRect.reset()
        cropImage.center = self.view.center
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
        graphPoints.removeLastAndFirst()
        animateLinkWithDot.backPointPosition()
    }
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let imagePicker = info[UIImagePickerControllerOriginalImage] as? UIImage {
            let frameSize = picture.bounds.size
            self.resizeImage = imagePicker.resizedImageWithinRect(resizeWidth: frameSize.width, resizeHeight: frameSize.height)
            picture.image = self.resizeImage?.image
        } else{
            print("Something went wrong")
        }
        dismiss(animated: true, completion: nil)
    }
    
    func bezierViewDataPoints(_ bezierView: BezierView) -> [CGPoint] {
        return graphPoints
    }
}
