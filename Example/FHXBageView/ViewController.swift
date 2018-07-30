//
//  ViewController.swift
//  FHXBageView
//
//  Created by fenghanxu on 07/27/2018.
//  Copyright (c) 2018 fenghanxu. All rights reserved.
//

import UIKit
import FHXBageView

class ViewController: UIViewController {
  
  fileprivate var btn_01 = UIBarButtonItem()
  fileprivate var btn_02 = UIBarButtonItem()

    override func viewDidLoad() {
        super.viewDidLoad()

      
        buildView()

        setupViews()
      
        /**
         iOS11系统下 -(void)viewDidLoad中获取不到UIBarButtonItem的实例,demo为了演示效果做了0.001s的延时操作,
         在实际开发中,badge的显示是在网络请求成功/推送之后,所以不用担心获取不到UIBarButtonItem添加不了badge
         */
        if (UIDevice.current.systemVersion as NSString).doubleValue >= 11.0 {
          DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01, execute: {
            self.setupBadges()
          })
          return
        }
    }
  
    fileprivate func buildView(){
      let bageView = UIView()
      bageView.fhx.addBadge(number: 11111)
      bageView.fhx.addLimit(number: 6)
      bageView.fhx.moveBadge(x: 1, y: 1 )
      bageView.fhx.setBadgeLabel { (bageLabel) in
        bageLabel.textColor = UIColor.blue
        bageLabel.font = UIFont.systemFont(ofSize: 13)
      }
      view.addSubview(bageView)
      bageView.frame = CGRect(x: 50, y: 50, width: 100, height: 100)
      bageView.backgroundColor = UIColor.yellow
    }
  
  func setupBadges() {
    // 1.1 左边
    btn_02.fhx.addBadge(number: 1)
    btn_02.fhx.moveBadge(x: -7, y: 5)
    btn_02.fhx.setBadgeLabel { (badgeLabel) in
      badgeLabel.font = UIFont.systemFont(ofSize: 13)
      badgeLabel.textColor = UIColor.blue
    }
    
    // 1.2 右边
    btn_01.fhx.addBadge(number: 99999)
    btn_01.fhx.addLimit(number: 3)
    btn_01.fhx.setBadge(height: 15)
    btn_01.fhx.moveBadge(x: -5, y: 0)
    btn_01.fhx.setBadge(flexMode: .middle)
  }
  
  func setupViews() {
    let btn_0 = UIBarButtonItem.init(barButtonSystemItem: .trash, target: self, action: #selector(deleteNum_0))
    let btn_1 = UIBarButtonItem.init(barButtonSystemItem: .trash, target: self, action: #selector(deleteNum_1))
    btn_01 = btn_1
    let btn_2 = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(addNum))
    btn_02 = btn_2
    
    self.navigationItem.rightBarButtonItems = [btn_0,btn_1]
    self.navigationItem.leftBarButtonItem = btn_2
  }
  
  @objc func deleteNum_0() {
    self.navigationItem.leftBarButtonItem?.fhx.decrease()
  }
  @objc func deleteNum_1() {
    self.navigationItem.leftBarButtonItem?.fhx.decrease()
  }
  @objc
  func addNum() {
    self.navigationItem.leftBarButtonItem?.fhx.increase()
  }
  
  func returnNDigitNine_0(number:Int) -> String {
    return String(10^(number)-1)
  }
  


  

}

