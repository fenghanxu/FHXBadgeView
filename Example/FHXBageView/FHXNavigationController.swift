//
//  FHXNavigationController.swift
//  sharesChonse
//
//  Created by 冯汉栩 on 2018/7/13.
//  Copyright © 2018年 fenghanxuCompany. All rights reserved.
//

import UIKit

class FHXNavigationController: UINavigationController,UINavigationControllerDelegate {
  
  /// 是否正在动画(防止连续点击)
  var isSwitching: Bool = false
  //不支持旋屏
  override var shouldAutorotate: Bool { return false }
  //设置屏幕竖向
  override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation { return .portrait }
  //设置屏幕竖向
  override var supportedInterfaceOrientations: UIInterfaceOrientationMask{ return .portrait }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    //自己内部遵守代理方法实现需要的要求，平时外面使用的时候也有自己的要求，想TextField的封装一样
    delegate = self
    //false  不透明   true   半透明
    navigationBar.isTranslucent = false
    //背景颜色
    navigationBar.backgroundColor = UIColor.white
    //隐藏导航栏下面底部的线shadowImage,(官方文档对顶设置完之后要一起设置setBackgroundImage才生效)
    navigationBar.shadowImage = UIImage(named: "nav-shadowImage")
    navigationBar.setBackgroundImage(UIImage(), for: .default)
    //设置tabbar标题字体(大小,颜色) 中间的标题文字
    navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.darkText, NSFontAttributeName: UIFont.systemFont(ofSize: 17)]
  }
  
  override func pushViewController(_ viewController: UIViewController, animated: Bool) {
    if isSwitching { return }
    isSwitching = true
    //如果导航栏集合里面不止一个控制器的话就在当前控制器的左边增加一个按键(可能会失去右滑返回手势)
    if self.childViewControllers.count > 0 {
      viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "nav_back"),
                                                                        style: .plain,
                                                                        target: self,
                                                                        action: #selector(backBtnClick))
      viewController.navigationItem.leftBarButtonItem?.tintColor = UIColor.blue
    }else {
      isSwitching = false
    }
    super.pushViewController(viewController, animated: animated)
  }
  
  // 这是导航每次发生跳转都调用该函数
  func navigationController(_ navigationController: UINavigationController,
                            didShow viewController: UIViewController,
                            animated: Bool) {
    // 当前页控制器和跳转后的控制器
    //    SPLogs("当前页控制器 = \(navigationController),跳转后的控制器 = \(viewController)")
    isSwitching = false
  }

}

extension FHXNavigationController {
  
  @objc func backBtnClick() {
    self.popViewController(animated: true)
  }
}

