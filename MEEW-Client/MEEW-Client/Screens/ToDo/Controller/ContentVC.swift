//
//  ContentVC.swift
//  MEEW-Client
//
//  Created by 임주민 on 2022/05/20.
//

import UIKit

class ContentVC: UIViewController {
  
  // MARK: - Properties
  let scrollView = UIScrollView()
  let scrollContainverView = UIView()
  let titleLabel = UILabel()
  let subtitleLabel = UILabel()
  let okayButton = UIButton()
  let tmpView = UIView()
  private var dimmedBackView = UIView()
  let levelCollectionView = UICollectionView()
//  let levelLabel = [UILabel]()
//  let imageView = [UIImageView]()
  
  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupUI()
    setGradation()
  }
  
  // MARK: - Custom Method
  func setGradation() {
    let gradientLayer = CAGradientLayer()
    gradientLayer.frame = tmpView.bounds
    gradientLayer.colors = [
      UIColor(red: 0.286, green: 0.286, blue: 0.286, alpha: 0).cgColor,
      UIColor(red: 0.486, green: 0.486, blue: 0.486, alpha: 1).cgColor
    ]
    gradientLayer.locations = [0.0 , 1.0]
    gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
    gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
    tmpView.layer.addSublayer(gradientLayer)
  }
  
  // MARK: - @objc
  @objc func okayButtonClicked(_ sender: UIButton) {
    NotificationCenter.default.post(name: NSNotification.Name("didTapOkayButton"), object: nil)
  }
  
  // MARK: - UI
  func setupUI() {
    view.add(scrollView) {
      $0.backgroundColor = .clear
      $0.translatesAutoresizingMaskIntoConstraints = false
      $0.showsVerticalScrollIndicator = false
      $0.isScrollEnabled = false
      $0.snp.makeConstraints {
        $0.top.equalTo(self.view.snp.top).offset(40)
        $0.centerX.leading.trailing.bottom.equalToSuperview()
      }
    }
    view.add(okayButton) {
      $0.setImage(UIImage(named: "btn_inform"), for: .normal)
      $0.addTarget(self, action: #selector(self.okayButtonClicked(_:)), for: .touchUpInside)
      $0.snp.makeConstraints {
        $0.centerX.equalTo(self.view.snp.centerX)
        $0.bottom.equalTo(self.view.snp.bottom).inset(45)
        $0.width.equalTo(335)
        $0.height.equalTo(54)
      }
    }
    scrollView.add(scrollContainverView) {
      $0.translatesAutoresizingMaskIntoConstraints = false
      $0.backgroundColor = .clear
      $0.contentMode = .scaleToFill
      $0.snp.makeConstraints {
        $0.centerX.top.leading.equalToSuperview()
        $0.bottom.equalTo(self.scrollView.snp.bottom)
        $0.width.equalTo(self.view)
        $0.height.equalTo(self.view).priority(718-40)
      }
    }
    scrollContainverView.add(titleLabel) {
      $0.text = "즉흥적인 바람이"
      $0.textColor = .white
      $0.font = .head2
      $0.snp.makeConstraints {
        $0.top.equalTo(self.scrollContainverView.snp.top)
        $0.leading.equalTo(self.scrollContainverView.snp.leading).offset(20)
      }
    }
    scrollContainverView.add(subtitleLabel) {
      $0.text = "바람이는 어디로 불지 모르는 성격이에요. 계획적이기 보다는 마음가는 대로 즐겁게 살아가고 있죠."
      $0.numberOfLines = 0
      $0.textColor = .grey300
      $0.font = .body1
      $0.snp.makeConstraints {
        $0.top.equalTo(self.titleLabel.snp.bottom).offset(16)
        $0.leading.equalTo(self.titleLabel.snp.leading)
        $0.trailing.equalTo(self.scrollContainverView.snp.trailing).inset(82)
      }
    }
    scrollContainverView.add(tmpView) {
      //$0.backgroundColor = .yellow
      $0.snp.makeConstraints {
        $0.top.equalTo(self.subtitleLabel.snp.bottom).offset(29)
        $0.leading.equalTo(self.scrollContainverView.snp.leading)
        $0.trailing.equalTo(self.scrollContainverView.snp.trailing)
        $0.bottom.equalTo(self.scrollContainverView.snp.bottom).inset(105)
      }
    }
    view.add(dimmedBackView) {
      //$0.layer.addSublayer(gradientLayer)
      //$0.setGradient(color1: .clear, color2: .red)
      
      $0.snp.makeConstraints {
        $0.top.equalTo(self.view.snp.top).offset(262)
        $0.leading.bottom.equalToSuperview()
        $0.height.equalTo(304)
      }
    }
    scrollContainverView.add(levelCollectionView) {
      $0.snp.makeConstraints {
        $0.top.equalTo(self.subtitleLabel.snp.bottom).offset(29)
        $0.leading.equalTo(self.scrollContainverView.snp.leading)
        $0.trailing.equalTo(self.scrollContainverView.snp.trailing)
        $0.bottom.equalTo(self.scrollContainverView.snp.bottom).inset(105)
      }
    }
  }
}
