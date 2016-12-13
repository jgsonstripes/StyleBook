//
//  LoginController.swift
//  StyleBook
//
//  Created by 스트라입스 on 2016. 12. 13..
//  Copyright © 2016년 jgson. All rights reserved.
//

import UIKit

class LoginController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var LoginScroll: UIScrollView!

    @IBAction func touchLogin(_ sender: Any) {
        if let session = KOSession.shared(){
            if session.isOpen() {
                session.close()
            }
            
            session.open(completionHandler: { (error) in
                if error == nil {
                    if session.isOpen() {
                        print("로그인 성공")
                        
                        // 로그인 후 로그인 화면 제거
                        self.dismiss(animated: true, completion: nil)
                        
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addScrollContent(image: #imageLiteral(resourceName: "LoginImage1"), page: 0)
        addScrollContent(image: #imageLiteral(resourceName: "LoginImage2"), page: 1)
        addScrollContent(image: #imageLiteral(resourceName: "LoginImage3"), page: 2)
        
        self.LoginScroll.contentSize = CGSize(width: self.LoginScroll.frame.width * 3, height: self.LoginScroll.frame.height)
        self.LoginScroll.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    func addScrollContent(image: UIImage, page: Int) {
        let width = self.LoginScroll.frame.size.width
        let height = self.LoginScroll.frame.size.height
        let content = UIImageView(frame: CGRect(x: CGFloat(page) * width, y: 0, width: width, height: height))
        content.image = image
        
        self.LoginScroll.addSubview(content)
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
