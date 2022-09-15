//
//  TabbarViewController.swift
//  MEEW-Client
//
//  Created by 임주민 on 2022/08/29.
//

import Foundation
import UIKit

class TabbarViewController: UITabBarController {
  
  var borderView = UIView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTabBar()
    setupBorderView()
    // vc.hidesBottomBarWhenPushed = true
  }
  
  private func setupBorderView() {
    borderView = UIView(frame: .zero)
    borderView.translatesAutoresizingMaskIntoConstraints = false
    borderView.backgroundColor = .grey500
    borderView.layer.cornerRadius = 24
    borderView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    view.addSubview(borderView)
    borderView.widthAnchor.constraint(equalToConstant: tabBar.frame.width + 1).isActive = true
    borderView.heightAnchor.constraint(equalToConstant: tabBar.frame.height).isActive = true
    borderView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    borderView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -1).isActive = true
    view.bringSubviewToFront(tabBar)
  }
  
  private func setupTabBar() {
    tabBar.backgroundColor = .grey700
    tabBar.tintColor = .white
    tabBar.unselectedItemTintColor = .grey400
    tabBar.layer.cornerRadius = 24
    tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
  }
}

extension TabbarViewController {
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    let firstNavigationController = UINavigationController()
    guard let firstTabController = UIStoryboard(name: "AlertViewController", bundle: nil).instantiateViewController(withIdentifier: "AlertViewController") as? AlertViewController else { return }
    firstNavigationController.addChild(firstTabController)
    firstNavigationController.tabBarItem.image = UIImage(named: "icn_tab_alert")
    firstNavigationController.tabBarItem.selectedImage = UIImage(named: "icn_tab_alert_fill")
    firstNavigationController.tabBarItem.title = "알림"
    firstNavigationController.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 22, vertical: 13)
    firstNavigationController.tabBarItem.imageInsets = UIEdgeInsets(top: 14.0, left: 0.0, bottom: -14.0, right: 0.0)
    
    let secondNavigationController = UINavigationController()
    let secondTabController = ToDoVC()
    secondNavigationController.addChild(secondTabController)
    secondNavigationController.tabBarItem.image = UIImage(named: "icn_tab_home")
    secondNavigationController.tabBarItem.selectedImage = UIImage(named: "icn_tab_home_fill")
    secondNavigationController.tabBarItem.title = "홈"
    secondNavigationController.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 10)
    secondNavigationController.tabBarItem.imageInsets = UIEdgeInsets(top: 14.0, left: 0.0, bottom: -14.0, right: 0.0)
    
    let thirdNavigationController = UINavigationController()
    guard let thirdTabController = UIStoryboard(name: "ResultVC", bundle: nil).instantiateViewController(withIdentifier: "ResultVC") as? ResultVC else { return }
    thirdNavigationController.addChild(thirdTabController)
    thirdNavigationController.tabBarItem.image = UIImage(named: "icn_tab_archieve")
    thirdNavigationController.tabBarItem.selectedImage = UIImage(named: "icn_tab_archieve_fill")
    thirdNavigationController.tabBarItem.title = "나의 기록"
    thirdNavigationController.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: -22, vertical: 10)
    thirdNavigationController.tabBarItem.imageInsets = UIEdgeInsets(top: 14.0, left: 0.0, bottom: -14.0, right: 0.0)
    
    let viewControllers = [firstNavigationController, secondNavigationController, thirdNavigationController]
    self.setViewControllers(viewControllers, animated: true)
    self.selectedIndex = 1;
  }
}
