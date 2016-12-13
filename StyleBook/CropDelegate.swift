//
//  CropDelegate.swift
//  StyleBook
//
//  Created by 스트라입스 on 2016. 12. 13..
//  Copyright © 2016년 jgson. All rights reserved.
//

import UIKit

extension CropController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBAction func touchImage(gesture: UITapGestureRecognizer) {
        let picker = UIImagePickerController()
        picker.view.backgroundColor = UIColor.white
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    func modifiedImage(gesture: UILongPressGestureRecognizer) {
        print("long press")
    }
    
    func crop(gesture: UIPanGestureRecognizer) {
        if gesture.state == .began || gesture.state == .changed {
            // move
            let translation = gesture.translation(in: model?.cropedImageView)
            gesture.view?.center = CGPoint(x: (gesture.view?.center.x)! + translation.x, y: (gesture.view?.center.y)! + translation.y)
            gesture.setTranslation(CGPoint.zero, in: model?.cropedImageView)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let imagePicker = info[UIImagePickerControllerOriginalImage] as? UIImage {
            picture.image = model?.resizeImage(image: imagePicker, newWidth: picture.bounds.size.width)
        } else{
            print("Something went wrong")
        }
        dismiss(animated: true, completion: nil)
    }
}
