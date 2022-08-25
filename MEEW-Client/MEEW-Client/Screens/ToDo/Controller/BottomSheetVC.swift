//
//  BottomSheetVC.swift
//  MEEW-Client
//
//  Created by 임주민 on 2022/05/09.
//

import UIKit

class BottomSheetVC: UIViewController {
  
  // MARK: - Properties
  private let bottomHeight: CGFloat = UIScreen.main.bounds.height * 0.61
  private var topConstant: CGFloat = 0
  private let contentViewController: UIViewController
  private var bottomSheetViewTopConstraint: NSLayoutConstraint!
  private var dimmedBackView = UIView()
  private let bottomSheetView = UIView()
  private let dismissIndicatorView = UIView()
  private lazy var bottomSheetPanStartingTopConstant: CGFloat = bottomSheetPanMinTopConstant
  private var bottomSheetPanMinTopConstant: CGFloat = 52.0
  
  enum BottomSheetViewState {
    case expanded
    case normal
  }
  
  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupBottomSheet()
    setupUI()
    setNotification()
    setupGestureRecognizer()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    showBottomSheet()
  }
  
  init(contentViewController: UIViewController) {
    self.contentViewController = contentViewController
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - UI 구현
  func setupUI() {
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
  
  func bottomSheetLayout() {
    contentViewController.view.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      contentViewController.view.topAnchor.constraint(equalTo: bottomSheetView.topAnchor),
      contentViewController.view.leadingAnchor.constraint(equalTo: bottomSheetView.leadingAnchor),
      contentViewController.view.trailingAnchor.constraint(equalTo: bottomSheetView.trailingAnchor),
      contentViewController.view.bottomAnchor.constraint(equalTo: bottomSheetView.bottomAnchor)
    ])
  }
  
  // MARK: - Custom Method
  private func setupBottomSheet() {
    addChild(contentViewController)
    bottomSheetView.addSubview(contentViewController.view)
    contentViewController.didMove(toParent: self)
    view.addSubviews([bottomSheetView, dismissIndicatorView])
    let viewPan = UIPanGestureRecognizer(target: self, action: #selector(viewPanned(_:)))
    viewPan.delaysTouchesBegan = false
    viewPan.delaysTouchesEnded = false
    view.addGestureRecognizer(viewPan)
    bottomSheetLayout()
  }
  
  private func setupGestureRecognizer() {
    let dimmedTap = UITapGestureRecognizer(target: self, action: #selector(dimmedViewTapped(_:)))
    dimmedBackView.addGestureRecognizer(dimmedTap)
    dimmedBackView.isUserInteractionEnabled = true
    
    let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(panGesture))
    swipeGesture.direction = .down
    view.addGestureRecognizer(swipeGesture)
  }
  
  private func showBottomSheet(atState: BottomSheetViewState = .normal) {
    if atState == .normal {
      changeScrollToggle()
      let safeAreaHeight: CGFloat = view.safeAreaLayoutGuide.layoutFrame.height
      let bottomPadding: CGFloat = view.safeAreaInsets.bottom
      bottomSheetViewTopConstraint.constant = (safeAreaHeight + bottomPadding) - bottomHeight
    } else {
      changeScrollToggle()
      bottomSheetViewTopConstraint.constant = bottomSheetPanMinTopConstant
    }
    UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
      self.dimmedBackView.alpha = 0.5
      self.view.layoutIfNeeded()
    }, completion: nil)
  }
  
  func changeScrollToggle() {
    let contentVC = children.first as? ContentVC
    contentVC?.scrollView.isScrollEnabled.toggle()
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
  
  func nearest(to number: CGFloat, inValues values: [CGFloat]) -> CGFloat {
    guard let nearestVal = values.min(by: { abs(number - $0) < abs(number - $1) })
    else { return number }
    return nearestVal
  }
  
  func setNotification() {
    NotificationCenter.default.addObserver(self, selector: #selector(didReceiveOkayButtonNotification(_:)), name: NSNotification.Name("didTapOkayButton"), object: nil)
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
  
  @objc private func viewPanned(_ panGestureRecognizer: UIPanGestureRecognizer) {
    let translation = panGestureRecognizer.translation(in: self.view)
    let velocity = panGestureRecognizer.velocity(in: view)
    
    switch panGestureRecognizer.state {
    case .began:
      bottomSheetPanStartingTopConstant = bottomSheetViewTopConstraint.constant
    case .changed:
      if bottomSheetPanStartingTopConstant + translation.y > bottomSheetPanMinTopConstant {
        bottomSheetViewTopConstraint.constant = bottomSheetPanStartingTopConstant + translation.y
      }
    case .ended:
      if velocity.y > 1500 {
        hideBottomSheetAndGoBack()
        return
      }
      let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.height
      let bottomPadding = view.safeAreaInsets.bottom
      let defaultPadding = safeAreaHeight + bottomPadding - bottomHeight
      let nearestValue = nearest(to: bottomSheetViewTopConstraint.constant, inValues: [bottomSheetPanMinTopConstant + 200, defaultPadding, safeAreaHeight + bottomPadding])
      if nearestValue == bottomSheetPanMinTopConstant + 200 {
        showBottomSheet(atState: .expanded)
      } else if nearestValue == defaultPadding {
        showBottomSheet(atState: .normal)
      } else {
        hideBottomSheetAndGoBack()
      }
    default:
      break
    }
  }
  
  @objc func didReceiveOkayButtonNotification(_ notification: Notification) {
      hideBottomSheetAndGoBack()
  }
}
