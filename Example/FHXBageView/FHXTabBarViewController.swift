//
//  FHXTabBarViewController.swift
//  sharesChonse
//
//  Created by 冯汉栩 on 2018/7/13.
//  Copyright © 2018年 fenghanxuCompany. All rights reserved.
//

import UIKit

class FHXTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        delegate = self
        addChildViewControllers()
    }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.isNavigationBarHidden = false
  }
  
  override var shouldAutorotate: Bool {
    return false
  }
  
  override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
    return UIInterfaceOrientationMask.portrait
  }

}


extension FHXTabBarViewController {
  //可以把所有控制器在里面写成一个方法，这样外面条用tabBar就变得简介，但是封装性没有那么高。为了提高FHXTabBarViewController的封装性，把这只控制器的方法在AppDelegate里面去设置。
      func addChildViewControllers() {
        let avc = ViewController()
        avc.tabBarItem.pp.addBadge(number: 99)
        setChildVC(vc: avc, name: "菜谱", image: "dinner", selectImage: "dinner-1")
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01, execute: {
            
            avc.tabBarItem.pp.addBadge(number: 99999)
            avc.tabBarItem.pp.addLimit(number: 1)
            avc.tabBarItem.pp.setBadge(height: 15)
            avc.tabBarItem.pp.moveBadge(x: -5, y: 0)
            avc.tabBarItem.pp.setBadge(flexMode: .middle)
            
        })
        
        
      }
  
  /**
   包装单个子控制器
   
   - parameter viewController: 需要包装的子控制器
   - parameter name:           设置子控制器tabBarItem标题
   - parameter image:          设置子控制器tabBarItem 普通图片
   - parameter selectImage:    设置子控制器tabBarItem 选中图片
   */
  func setChildVC(vc viewController: UIViewController,
                  name:String,
                  image:String,
                  selectImage:String){
    //  使用navigationController对控制器进行包装
    let navViewController = FHXNavigationController(rootViewController: viewController)
    //  设置标题与Tabbar按钮文字
    viewController.tabBarItem.title = name
    //设置文字不同状态的颜色
    let normal: [String: Any] = [NSForegroundColorAttributeName: UIColor.cyan,
                                 NSFontAttributeName: UIFont.systemFont(ofSize: 12)]
    let select: [String: Any] = [NSForegroundColorAttributeName: UIColor.darkText]
    
    viewController.tabBarItem.setTitleTextAttributes(normal, for: .normal)
    viewController.tabBarItem.setTitleTextAttributes(select, for: .selected)
    
    //设置tabBar的图片
    viewController.tabBarItem.image = UIImage(named: image)
    // 设置选中的图片
    viewController.tabBarItem.selectedImage = UIImage(named: selectImage)?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
    //  添加子控制器
    self.addChildViewController(navViewController)
  }
}

extension FHXTabBarViewController: UITabBarControllerDelegate{
  
  //实现这个代理的目的是为了，当我们点击首页的时候自动回到控制器的最顶端(最顶端的方法要写在首页控制器里面)
  func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
    
    if viewController == self.selectedViewController {
      // 选中首页控制器
      if self.selectedIndex == 0 {
        //卖家版是设置tableView回到顶端
        //                ((viewController as! NavigationViewController).viewControllers[0] as! HomeViewController).gotoTop()
      }
      return false
    }
    return true
  }
  
}


