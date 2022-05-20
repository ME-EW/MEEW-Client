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
  var paragraphStyle = NSMutableParagraphStyle()
  //var dimmedBackView = UIView()
  let images = ["baram1","baram1","baram1","baram1"]

  let levelCollectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    let collectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: layout)
    return collectionView
  }()
  
  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupUI()
    setGradation()
    setCollectionAttributes()
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
  
  func setCollectionAttributes() {
    levelCollectionView.register(MyCell.self, forCellWithReuseIdentifier: MyCell.reuseIdentifier)
    levelCollectionView.delegate = self
    levelCollectionView.dataSource = self
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
        $0.height.equalTo(718)
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
    paragraphStyle.lineHeightMultiple = 1.25
    scrollContainverView.add(subtitleLabel) { [self] in
      $0.numberOfLines = 0
      $0.lineBreakMode = .byWordWrapping
      $0.attributedText = NSMutableAttributedString(string: "바람이는 어디로 불지 모르는 성격이에요. 계획적이기 보다는 마음가는 대로 즐겁게 살아가고 있죠.", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
      $0.textColor = .grey300
      $0.font = .body1
      $0.snp.makeConstraints {
        $0.top.equalTo(self.titleLabel.snp.bottom).offset(16)
        $0.leading.equalTo(self.titleLabel.snp.leading)
        $0.trailing.equalTo(self.scrollContainverView.snp.trailing).inset(82)
      }
    }
//    view.add(dimmedBackView) {
//      //$0.layer.addSublayer(gradientLayer)
//      //$0.setGradient(color1: .clear, color2: .red)
//
//      $0.snp.makeConstraints {
//        $0.top.equalTo(self.view.snp.top).offset(262)
//        $0.leading.bottom.equalToSuperview()
//        $0.height.equalTo(304)
//      }
//    }
    scrollContainverView.add(levelCollectionView) {
      $0.backgroundColor = .clear
      $0.isUserInteractionEnabled = false
      $0.snp.makeConstraints {
        $0.top.equalTo(self.subtitleLabel.snp.bottom).offset(29)
        $0.leading.equalTo(self.scrollContainverView.snp.leading).offset(20)
        $0.trailing.equalTo(self.scrollContainverView.snp.trailing).inset(20)
        $0.bottom.equalTo(self.scrollContainverView.snp.bottom).inset(139)
      }
    }
  }
}

// MARK: - Extension: UICollectionView
extension ContentVC: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 4
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCell.reuseIdentifier, for: indexPath) as? MyCell else {return UICollectionViewCell() }
    cell.myImage.image = UIImage(named: images[indexPath.row])
    cell.myLabel.text = "Lv. " + String(indexPath.row+1)
    cell.awakeFromNib()
    return cell
  }
}

extension ContentVC: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let cellWidth = (collectionView.frame.width-15)/2
    return CGSize(width: cellWidth, height: 188)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
      return 18
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 15
  }
}
