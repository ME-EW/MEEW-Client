//
//  TestVC.swift
//  MEEW-Client
//
//  Created by 임주민 on 2022/05/12.
//

import UIKit

class TestVC: UIViewController {
  
  // MARK: - Properties
  let v1 = UIView()
  let v2 = UIView()
  let v3 = UIView()
  let v4 = UIView()
  
  var vlist: [v] = []
  
  // MARK: - Custom Method
  func layout(){
    vlist.append(contentsOf: [
              v(v: v1, priority: 1),
              v(v: v2, priority: 2),
              v(v: v3, priority: 3),
              v(v: v4, priority: 3),
    ])
    
    view.add(v1) {
      $0.backgroundColor = .systemPink
      $0.snp.makeConstraints {
        $0.top.equalTo(self.view.snp.top).offset(200)
        $0.centerX.equalTo(self.view.snp.centerX)
        $0.height.equalTo(50)
        $0.width.equalTo(300)
      }
    }
    view.add(v2) {
      $0.backgroundColor = .cyan
      $0.snp.makeConstraints {
        $0.top.equalTo(self.v1.snp.bottom).offset(30)
        $0.centerX.equalTo(self.view.snp.centerX)
        $0.height.equalTo(50)
        $0.width.equalTo(300)
      }
    }
    view.add(v3) {
      $0.backgroundColor = .yellow
      $0.snp.makeConstraints {
        $0.top.equalTo(self.v2.snp.bottom).offset(30)
        $0.centerX.equalTo(self.view.snp.centerX)
        $0.height.equalTo(50)
        $0.width.equalTo(300)
      }
    }
    view.add(v4) {
      $0.backgroundColor = .systemIndigo
      $0.snp.makeConstraints {
        $0.top.equalTo(self.v3.snp.bottom).offset(30)
        $0.centerX.equalTo(self.view.snp.centerX)
        $0.height.equalTo(50)
        $0.width.equalTo(300)
      }
    }
    
  }
  
  // MARK: - @objc
  
  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    layout()
    
  }
  
  
  
  
}
