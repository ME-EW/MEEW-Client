//
//  BottomSheetVC.swift
//  MEEW-Client
//
//  Created by 임주민 on 2022/05/09.
//

import UIKit

class BottomSheetVC: UIViewController {
  
  // MARK: - Properties
  let bottomHeight: CGFloat = 500
  var topConstant: CGFloat = 0
  private var bottomSheetViewTopConstraint: NSLayoutConstraint! // bottomSheet가 view의 상단에서 떨어진 거리
  private var dimmedBackView = UIView()
  private let bottomSheetView = UIView()
  private let dismissIndicatorView = UIView()
  
  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    layout()
    setupGestureRecognizer()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    showBottomSheet()
  }
  
  // MARK: - UI 구현
  func layout() {
    view.add(dimmedBackView) {
      $0.alpha = 0.0
      $0.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.view.snp.top)
        $0.leading.equalTo(self.view.snp.leading)
        $0.bottom.equalTo(self.view.snp.bottom)
        $0.trailing.equalTo(self.view.snp.trailing)
      }
    }
    view.add(bottomSheetView) {
      $0.backgroundColor = .grey500
      $0.roundCorners(cornerRadius: 20, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
      $0.translatesAutoresizingMaskIntoConstraints = false
      $0.snp.makeConstraints {
        $0.leading.equalTo(self.view.snp.leading)
        $0.bottom.equalTo(self.view.snp.bottom)
        $0.trailing.equalTo(self.view.snp.trailing)
      }
    }
    topConstant = view.safeAreaInsets.bottom + view.safeAreaLayoutGuide.layoutFrame.height
    bottomSheetViewTopConstraint = bottomSheetView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstant)
    NSLayoutConstraint.activate([
      bottomSheetViewTopConstraint
    ])
    view.add(dismissIndicatorView) {
      $0.backgroundColor = UIColor(red: 0.769, green: 0.769, blue: 0.769, alpha: 1)
      $0.layer.cornerRadius = 2
      $0.snp.makeConstraints {
        $0.top.equalTo(self.bottomSheetView.snp.top).offset(8)
        $0.centerX.equalTo(self.bottomSheetView.snp.centerX)
        $0.height.equalTo(4)
        $0.width.equalTo(60)
      }
    }
  }
  
  // MARK: - Custom Method
  private func setupGestureRecognizer() {
    let dimmedTap = UITapGestureRecognizer(target: self, action: #selector(dimmedViewTapped(_:)))
    dimmedBackView.addGestureRecognizer(dimmedTap)
    dimmedBackView.isUserInteractionEnabled = true
    
    let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(panGesture))
    swipeGesture.direction = .down
    view.addGestureRecognizer(swipeGesture)
    
  }
  
  private func showBottomSheet() {
    let safeAreaHeight: CGFloat = view.safeAreaLayoutGuide.layoutFrame.height
    let bottomPadding: CGFloat = view.safeAreaInsets.bottom
    
    bottomSheetViewTopConstraint.constant = (safeAreaHeight + bottomPadding) - bottomHeight
    
    UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
      self.dimmedBackView.alpha = 0.5
      self.view.layoutIfNeeded()
    }, completion: nil)
  }
  
  private func hideBottomSheetAndGoBack() {
    let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.height
    let bottomPadding = view.safeAreaInsets.bottom
    bottomSheetViewTopConstraint.constant = safeAreaHeight + bottomPadding
    UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
      self.dimmedBackView.alpha = 0.0
      self.view.layoutIfNeeded()
    }) { _ in
      if self.presentingViewController != nil {
        self.dismiss(animated: false, completion: nil)
      }
    }
  }
  
  // MARK: - @objc
  @objc private func dimmedViewTapped(_ tapRecognizer: UITapGestureRecognizer) {
    hideBottomSheetAndGoBack()
  }
  
  @objc func panGesture(_ recognizer: UISwipeGestureRecognizer) {
    if recognizer.state == .ended {
      switch recognizer.direction {
      case .down:
        hideBottomSheetAndGoBack()
      default:
        break
      }
    }
  }
}