//
//  ContentVC.swift
//  MEEW-Client
//
//  Created by 임주민 on 2022/05/09.
//

import UIKit

class ContentVC: UIViewController {
  
  // MARK: - Properties
  let scrollview = UIScrollView()
  let scrollContainverView = UIView()
  let titleLabel = UILabel()
  let subtitleLabel = UILabel()
  let levelLabel = [UILabel]()
  let imageView = [UIImageView]()
  
  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    layout()
    levelLayout()
    imageLayout()
  }
  
  // MARK: - Layout
  func layout() {
    view.add(scrollview) {
      $0.backgroundColor = .clear
      $0.translatesAutoresizingMaskIntoConstraints = false
      $0.showsVerticalScrollIndicator = false
      $0.isScrollEnabled = false
      $0.snp.makeConstraints {
        $0.top.equalTo(self.view.snp.top).offset(40)
        $0.centerX.leading.trailing.bottom.equalToSuperview()
      }
    }
//    scrollview.add(scrollContainverView) {
//      $0.translatesAutoresizingMaskIntoConstraints = false
//      $0.backgroundColor = .clear
//      $0.contentMode = .scaleToFill
//      $0.snp.makeConstraints {
//        $0.centerX.top.leading.equalToSuperview()
//        $0.bottom.equalTo(self.scrollview.snp.bottom)
//        $0.width.equalTo(self.view)
//        $0.height.equalTo(self.view).priority(718-40)
//      }
//    }
//    scrollContainverView.add(titleLabel) {
//      $0.text = "즉흥적인 바람이"
//      $0.textColor = .white
//      $0.font = .head2
//      $0.snp.makeConstraints {
//        $0.top.equalTo(self.scrollContainverView.snp.top)
//        $0.leading.equalTo(self.scrollContainverView.snp.leading).offset(20)
//      }
//    }
    
  }
  
  func levelLayout() {
    
  }
  
  func imageLayout() {
    
  }
  
  // MARK: - Custom Method
  // MARK: - @objc
  
  
}
