//
//  ViewController.swift
//  StyleBook
//
//  Created by 스트라입스 on 2016. 12. 12..
//  Copyright © 2016년 jgson. All rights reserved.
//

import UIKit

class MainController: UIViewController {

    @IBAction func kakaoLogout(_ sender: UIButton) {
        KOSession.shared().logoutAndClose(completionHandler: { (success, error) in
            if success {
                print("로그아웃 성공")
                print("\(KOSession.shared().isOpen())")
                print("\(KOSession.shared().accessToken)")
            } else {
                print("로그아웃 실패")
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        addKaKaoLoginButton()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if !KOSession.shared().isOpen() {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "Login") as! LoginController
            self.navigationController?.present(controller, animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

