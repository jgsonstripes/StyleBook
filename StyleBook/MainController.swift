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
        
        let viewcontroller = UIViewController()
        
        viewcontroller.view.backgroundColor = UIColor.brown
        viewcontroller.view.frame = self.view.frame
        viewcontroller.modalTransitionStyle = .crossDissolve
        self.navigationController?.present(viewcontroller, animated: true, completion: {
            self.addKaKaoLoginButton(viewcontroller: viewcontroller)
        })
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    func addKaKaoLoginButton(viewcontroller: UIViewController) {
        let xMargin: CGFloat = 30
        let marginBottom: CGFloat = 25
        let btnWidth = self.view.frame.width - xMargin * 2
        let btnHeight: CGFloat = 42
        
        let kakaoLoginButton = KOLoginButton(frame: CGRect(x: xMargin, y: viewcontroller.view.frame.size.height, width: btnWidth, height: btnHeight))
        kakaoLoginButton.addTarget(self, action: #selector(self.invokeLoginWithTarget), for: .touchUpInside)
        viewcontroller.view.addSubview(kakaoLoginButton)
        
        UIView.animate(withDuration: 1, animations: {
            kakaoLoginButton.frame = CGRect(x: xMargin, y: viewcontroller.view.frame.size.height - btnHeight - marginBottom, width: btnWidth, height: btnHeight)
        }, completion: nil)
    }
    
    func invokeLoginWithTarget() {
        if let session = KOSession.shared(){
            if session.isOpen() {
                session.close()
            }
            
            session.open(completionHandler: { (error) in
                if error == nil {
                    if session.isOpen() {
                        print("로그인 성공")
                        
                        print("\(KOSession.shared().isOpen())")
                        print("\(KOSession.shared().accessToken)")
                    } else {
                        print("로그인 실패")
                    }
                } else {
                    print("로그인 에러 : \(error.debugDescription)")
                }
                
            }, authParams: nil, authTypes: [NSNumber(value: KOAuthType.talk.rawValue)])
        } else {
            print("로그인 세션 실패")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

