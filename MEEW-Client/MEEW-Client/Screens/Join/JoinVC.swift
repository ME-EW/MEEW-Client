//
//  JoinVC.swift
//  MEEW-Client
//
//  Created by 임주민 on 2022/04/07.
//


import UIKit

import SnapKit
import Then
import AuthenticationServices

class JoinVC: UIViewController {
  
  // MARK: - Properties
  let mainImageView = UIImageView()
  let titleLabel = UILabel()
  let subtitleLabel = UILabel()
  let kakaoButton = UIButton()
  let appleButton = UIButton()
  
  // MARK: - View Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    layoutJoinView()
    setAppleLoginButton()
  }
  
  private func layoutJoinView() {
    view.backgroundColor = .black
    view.add(mainImageView) {
      $0.snp.makeConstraints {
        $0.centerX.equalToSuperview()
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
      $0.textColor = .white
      $0.font = .body3
      $0.snp.makeConstraints {
        $0.top.equalTo(self.titleLabel.snp.bottom).offset(9)
        $0.centerX.equalToSuperview()
      }
    }
    view.add(kakaoButton) {
      $0.setImage(UIImage(named: "kakao_login_medium_wide"), for: .normal)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.view.snp.top).offset(652)
        $0.centerX.equalToSuperview()
      }
    }
  }
  
  func setAppleLoginButton() {
    let authorizationButton = ASAuthorizationAppleIDButton(type: .signIn, style: .white)
//    authorizationButton.addTarget(self, action: #selector(handleAuthoAppleIDButnPress), for: .touchUpInside)
    view.add(authorizationButton) {
      authorizationButton.translatesAutoresizingMaskIntoConstraints = false
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
  
