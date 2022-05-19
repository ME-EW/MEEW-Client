//
//  JoinVC.swift
//  MEEW-Client
//
//  Created by 임주민 on 2022/04/07.
//


import UIKit

import SnapKit
import Then

class JoinVC: UIViewController {
  
  // MARK: - Properties
  var imageView = UIImageView()
  var imageView2 = UIImageView()
  let titleLabel = UILabel()
  let subtitleLabel = UILabel()
  let kakaoButton = UIButton()
  let appleButton = UIButton()
  
  // MARK: - View Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    layoutJoinView()
    setAnimation()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    startAnimating()
  }
  
  // MARK: - Custom Func
  func setAnimation() {
    imageView2.transform = CGAffineTransform.identity.translatedBy(x: -self.view.bounds.width, y: 0)
  }
  
  func startAnimating() {
    UIImageView.animate(withDuration: 25, delay: 0, options: [.repeat, .curveEaseIn, .curveEaseOut], animations: {
      self.imageView.center.x += self.view.bounds.width + 850
      self.imageView2.center.x += self.view.bounds.width + 850
    }, completion: nil)
  }
  
  @objc func tmpClicked(_ sender: UIButton) {
    let nextVC = ToDoVC()
    nextVC.modalTransitionStyle = .coverVertical
    nextVC.modalPresentationStyle = .fullScreen
    self.present(nextVC, animated: true, completion: nil)
  }
  
  // MARK: - UI 구현
  func layoutJoinView() {
    view.backgroundColor = .grey700

    view.add(imageView) {
      $0.image = UIImage(named: "join_group")
      $0.snp.makeConstraints {
        $0.top.equalTo(self.view.snp.top).offset(240)
        $0.trailing.equalTo(self.view.snp.trailing).offset(-20)
        $0.width.equalTo(1196)
        $0.height.equalTo(140)
      }
    }
    view.add(imageView2) {
      $0.image = UIImage(named: "join_group")
      $0.snp.makeConstraints {
        $0.top.equalTo(self.view.snp.top).offset(240)
        $0.trailing.equalTo(self.view.snp.trailing).offset(-659)
        $0.width.equalTo(1196)
        $0.height.equalTo(140)
      }
    }
    
    view.add(titleLabel) {
      $0.text = "ME:EW"
      $0.textColor = .white
      $0.font = .join1
      $0.snp.makeConstraints {
        $0.top.equalTo(self.view.snp.top).offset(430)
        $0.centerX.equalToSuperview()
      }
    }
    view.add(subtitleLabel) {
      $0.text = "또 다른 나로 살아보세요"
      $0.textColor = .grey300
      $0.font = .body2
      $0.snp.makeConstraints {
        $0.top.equalTo(self.titleLabel.snp.bottom).offset(9)
        $0.centerX.equalToSuperview()
      }
    }
    view.add(kakaoButton) {
      $0.setImage(UIImage(named: "btn_kakao"), for: .normal)
      $0.addTarget(self, action: #selector(self.tmpClicked(_:)), for: .touchUpInside)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.view.snp.top).offset(652)
        $0.leading.equalTo(self.view.snp.leading).offset(20)
        $0.trailing.equalTo(self.view.snp.trailing).offset(-20)
        $0.height.equalTo(50)
        $0.centerX.equalToSuperview()
      }
    }
    view.add(appleButton) {
      $0.setImage(UIImage(named: "btn_apple"), for: .normal)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.kakaoButton.snp.bottom).offset(15)
        $0.leading.equalTo(self.kakaoButton.snp.leading)
        $0.trailing.equalTo(self.kakaoButton.snp.trailing)
        $0.height.equalTo(self.kakaoButton.snp.height)
        $0.centerX.equalToSuperview()
      }
    }
  }
}
