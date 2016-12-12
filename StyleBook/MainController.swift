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
            let viewcontroller = UIViewController()
            
            viewcontroller.view.backgroundColor = UIColor.brown
            viewcontroller.view.frame = self.view.frame
            viewcontroller.modalTransitionStyle = .crossDissolve
            
            addAppNameView(controller: viewcontroller)
            
            self.navigationController?.present(viewcontroller, animated: true, completion: {
                self.addKaKaoLoginButton(viewcontroller: viewcontroller)
            })
        }
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
    
    func addAppNameView(controller: UIViewController) {
        let appName = UILabel()
        appName.text = "StyleBook"
        appName.textAlignment = .center
        appName.font = UIFont.systemFont(ofSize: 32)
        appName.frame = CGRect(x: 0, y: 0, width: controller.view.bounds.size.width, height: 0)
        
        controller.view.addSubview(appName)
        
        appName.leadingAnchor.constraint(equalTo: controller.view.leadingAnchor).isActive = true
        appName.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor).isActive = true
        appName.topAnchor.constraint(equalTo: controller.view.topAnchor, constant: 144).isActive = true
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
                        
                        // 로그인 후 로그인 화면 제거
                        self.navigationController?.presentedViewController?.dismiss(animated: true, completion: nil)
                        
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

