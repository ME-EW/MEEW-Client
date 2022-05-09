//
//  FinishedModalVC.swift
//  MEEW-Client
//
//  Created by 임주민 on 2022/05/09.
//

import UIKit

class FinishedModalVC: UIViewController {
  
  // MARK: - Properties
  let bgView = UIView()
  let questionView = UIView()
  let questionLabel = UILabel()
  let noButton = UIButton()
  let yesButton = UIButton()
  let horizonView = UIView()
  let verticalView = UIView()
  
  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    layout()
  }
  
  // MARK: - @objc
  @objc func yesButtonClicked(_ sender: UIButton) {
//    let nextVC = FinishedVC()
//    nextVC.modalTransitionStyle = .coverVertical
//    nextVC.modalPresentationStyle = .fullScreen
//    self.present(nextVC, animated: true, completion: nil)
  }
  
  @objc func noButtonClicked(_ sender: UIButton) {
    self.dismiss(animated: true, completion: nil)
  }
  
  // MARK: - UI 구현
  func layout() {
    view.backgroundColor = .clear
    
    view.add(bgView) {
      $0.backgroundColor = .black200
      $0.alpha = 0.5
      $0.snp.makeConstraints {
        $0.top.equalTo(self.view.snp.top)
        $0.leading.equalTo(self.view.snp.leading)
        $0.bottom.equalTo(self.view.snp.bottom)
        $0.trailing.equalTo(self.view.snp.trailing)
      }
    }
    view.add(questionView) {
      $0.backgroundColor = .grey500
      $0.layer.cornerRadius = 12
      $0.snp.makeConstraints {
        $0.top.equalTo(self.view.snp.top).offset(316)
        $0.leading.equalTo(self.view.snp.leading).offset(21)
        $0.trailing.equalTo(self.view.snp.trailing).offset(-21)
        $0.height.equalTo(180)
      }
    }
    view.add(questionLabel) {
      $0.text = "오늘 바람이를 완성하지 못했어요!\n정말 마무리하시겠어요?"
      $0.textAlignment = .center
      $0.numberOfLines = 0
      $0.textColor = .white
      $0.font = .title4
      $0.snp.makeConstraints {
        $0.top.equalTo(self.questionView.snp.top).offset(36)
        $0.centerX.equalTo(self.questionView.snp.centerX)
      }
    }
    view.add(yesButton) {
      $0.backgroundColor = .grey600
      $0.setTitle("네", for: .normal)
      $0.setTitleColor(.purple, for: .normal)
      $0.titleLabel?.font = .title4
      $0.roundCorners(cornerRadius: 12, maskedCorners: [.layerMaxXMaxYCorner])
      $0.addTarget(self, action: #selector(self.yesButtonClicked(_:)), for: .touchUpInside)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.view.snp.top).offset(436)
        $0.leading.equalTo(self.questionView.snp.centerX)
        $0.trailing.equalTo(self.questionView.snp.trailing)
        $0.height.equalTo(60)
      }
    }
    view.add(noButton) {
      $0.backgroundColor = .grey600
      $0.setTitle("아니오", for: .normal)
      $0.setTitleColor(.white, for: .normal)
      $0.titleLabel?.font = .title4
      $0.roundCorners(cornerRadius: 12, maskedCorners: [.layerMinXMaxYCorner])
      $0.addTarget(self, action: #selector(self.noButtonClicked(_:)), for: .touchUpInside)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.view.snp.top).offset(436)
        $0.leading.equalTo(self.questionView.snp.leading)
        $0.trailing.equalTo(self.questionView.snp.centerX)
        $0.height.equalTo(60)
      }
    }
    view.add(horizonView) {
      $0.backgroundColor = .grey300
      $0.snp.makeConstraints {
        $0.top.equalTo(self.yesButton.snp.top)
        $0.leading.equalTo(self.questionView.snp.leading)
        $0.trailing.equalTo(self.questionView.snp.trailing)
        $0.height.equalTo(0.5)
      }
    }
    view.add(verticalView) {
      $0.backgroundColor = .grey300
      $0.snp.makeConstraints {
        $0.top.equalTo(self.yesButton.snp.top)
        $0.bottom.equalTo(self.questionView.snp.bottom)
        $0.centerX.equalTo(self.questionView.snp.centerX)
        $0.width.equalTo(0.5)
      }
    }
  }
}
