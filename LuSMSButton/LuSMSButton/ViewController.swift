//
//  ViewController.swift
//  LuSMSButton
//
//  Created by 路政浩 on 16/7/28.
//  Copyright © 2016年 路政浩. All rights reserved.
//

import UIKit

let time: Int = 3

class ViewController: UIViewController {
    
    
    lazy var oneBtn : UIButton = {
        var oneBtn = UIButton()
        oneBtn.frame = CGRectMake(100, 300, 100, 45)
        oneBtn.setTitle("获取验证码", forState: .Normal)
        oneBtn.backgroundColor = UIColor.blueColor()
        oneBtn.layer.cornerRadius = 5
        oneBtn.addTarget(self, action: #selector(ViewController.clickOneBtn(_:)), forControlEvents: .TouchUpInside)
        return oneBtn
    }()
    
    
    lazy var twoBtn : UIButton = {
        var twoBtn = UIButton()
        twoBtn.frame = CGRectMake(100, 400, 100, 45)
        twoBtn.setTitle("获取验证码", forState: .Normal)
        twoBtn.backgroundColor = UIColor.blueColor()
        twoBtn.layer.cornerRadius = 5
        twoBtn.addTarget(self, action: #selector(ViewController.clickTwoBtn(_:)), forControlEvents: .TouchUpInside)
        return twoBtn
    }()
    
    var countdownTimer: NSTimer?

    var isCounting = false {
        willSet{
            if newValue {
                countdownTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(ViewController.updateTime(_:)), userInfo: nil, repeats: true)
                remainingSeconds = time
                oneBtn.backgroundColor = UIColor.grayColor()
            } else {
                countdownTimer?.invalidate()
                countdownTimer = nil
                oneBtn.backgroundColor = UIColor.blueColor()
            }
            oneBtn.enabled = !newValue
        }
    }
    
    var remainingSeconds: Int = 0 {
        willSet {
            oneBtn.setTitle("重新发送(\(newValue))", forState: .Normal)
            
            if newValue <= 0 {
                oneBtn.setTitle("获取验证码", forState: .Normal)
                isCounting = false
            }
        }
    }
    func updateTime(timer: NSTimer) {
        remainingSeconds -= 1
    }
    
    func clickOneBtn(sender:UIButton){
        print("获取验证码")
        isCounting = true
    }
    
    func clickTwoBtn(sender:UIButton){
        print("跳转到另一控制器")
        let twoVC = TwoViewController()
        self.navigationController?.pushViewController(twoVC, animated: true)
    }
}
extension ViewController{
    override func viewDidLoad() {
        self.title = "短信验证倒计时按钮"
        super.viewDidLoad()
        self.view.addSubview(oneBtn)
        self.view.addSubview(twoBtn)
    }
}









