//
//  TwoViewController.swift
//  LuSMSButton
//
//  Created by 路政浩 on 16/7/28.
//  Copyright © 2016年 路政浩. All rights reserved.
//

import UIKit
private var  SMSTime: Int = 3


class TwoViewController: UIViewController {
    
    lazy var twoBtn : UIButton = {
        var twoBtn = UIButton()
        twoBtn.frame = CGRectMake(100, 400, 120, 45)
        twoBtn.setTitle("获取验证码", forState: .Normal)
        twoBtn.backgroundColor = UIColor.blueColor()
        twoBtn.layer.cornerRadius = 5
        return twoBtn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(twoBtn)
        
        setTime(SMSTime)
    }
    
    func setTime(timeOut:Int) {
        
        var loginTime = time
        
        let queue: dispatch_queue_t = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        let timer: dispatch_source_t  = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue)
        /** 每秒执行 */
        dispatch_source_set_timer(timer, dispatch_walltime(nil, 0), 1 * NSEC_PER_SEC, 0)
        
        dispatch_source_set_event_handler(timer, {
            
            if loginTime <= 0 {
                dispatch_source_cancel(timer);
                
                dispatch_sync(dispatch_get_main_queue(), {
                    /** 设置界面的按钮显示*/
                    self.twoBtn.setTitle("获取验证码", forState: UIControlState.Normal)
                    
                    self.twoBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
                    self.twoBtn.backgroundColor = UIColor.blueColor()
                    self.twoBtn.userInteractionEnabled = true
                    self.twoBtn.addTarget(self, action: #selector(TwoViewController.sendSMS(_:)), forControlEvents: .TouchUpInside)
                    
                })
            }else{
                /** 倒计时 */
                let seconds = loginTime % 60
                let strTime = NSString.localizedStringWithFormat("%.2d", seconds)
                
                dispatch_sync(dispatch_get_main_queue(), {
                    /** 开启动画*/
                    //UIView.beginAnimations(nil, context: nil)
                    /** 动画时长*/
                    //UIView.setAnimationDuration(1)
                    /** 设置界面的按钮显示*/
                    self.twoBtn.setTitle(NSString.localizedStringWithFormat("重新发送(%@)", strTime) as String, forState: UIControlState.Normal)
                    
                    self.twoBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
                    self.twoBtn.backgroundColor = UIColor.lightGrayColor()
                    
                    /** 提交动画 */
                    //UIView.commitAnimations()
                    self.twoBtn.userInteractionEnabled = false
                })
                loginTime -= 1;
            }
            
        })
        dispatch_resume(timer)
    }
    
    func sendSMS(sender:UIButton) {
        print("点击获取验证码")
        setTime(SMSTime)
    }
}





