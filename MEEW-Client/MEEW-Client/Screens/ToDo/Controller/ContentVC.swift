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
  private let scrollContainverView = UIView()
  private let titleLabel = UILabel()
  private let subtitleLabel = UILabel()
  private let okayButton = UIButton()
  private let tmpView = UIView()
  private var paragraphStyle = NSMutableParagraphStyle()
  private var dimmedBackView = UIView()
  private let gradientView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 304))
  var characterId: Int? = nil
  private var characterPerInfo = Personality(id: 0, name: "", personalityDescription: "", createdAt: "", updatedAt: "", mainImg: "", imgURL: [])
  private  let levelCollectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    let collectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: layout)
    return collectionView
  }()
  
  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    requestGetCharacterList()
  }
  
  // MARK: - Custom Method
  private func setCollectionAttributes() {
    levelCollectionView.register(MyCell.self, forCellWithReuseIdentifier: MyCell.reuseIdentifier)
    levelCollectionView.delegate = self
    levelCollectionView.dataSource = self
  }
  
  // MARK: - @objc
  @objc func okayButtonClicked(_ sender: UIButton) {
    NotificationCenter.default.post(name: NSNotification.Name("didTapOkayButton"), object: nil)
  }
  
  // MARK: - UI
  private func setupUI() {
    view.add(scrollView) {
      $0.backgroundColor = .clear
      $0.translatesAutoresizingMaskIntoConstraints = false
      $0.showsVerticalScrollIndicator = false
      $0.snp.makeConstraints {
        $0.top.equalTo(self.view.snp.top).offset(40)
        $0.centerX.leading.trailing.bottom.equalToSuperview()
      }
    }
    view.add(gradientView) {
      $0.setGradient(color1: UIColor(red: 0.286, green: 0.286, blue: 0.286, alpha: 0), color2: UIColor(red: 0.286, green: 0.286, blue: 0.286, alpha: 1))
      $0.snp.makeConstraints {
        $0.leading.equalTo(self.view.snp.leading)
        $0.bottom.equalTo(self.view.snp.bottom).offset(64)
        $0.trailing.equalTo(self.view.snp.trailing)
        $0.height.equalTo(304)
        $0.width.equalTo(375)
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
        $0.height.equalTo(680)
      }
    }
    scrollContainverView.add(titleLabel) {
      $0.text = self.characterPerInfo.name
      $0.textColor = .white
      $0.font = .head2
      $0.snp.makeConstraints {
        $0.top.equalTo(self.scrollContainverView.snp.top)
        $0.leading.equalTo(self.scrollContainverView.snp.leading).offset(20)
      }
    }
    paragraphStyle.lineHeightMultiple = 1.25
    var lines = self.characterPerInfo.personalityDescription.components(separatedBy: ". ")
    lines[0].insert(".", at: lines[0].endIndex)
    let paragraph = lines.joined(separator: "\n")
    scrollContainverView.add(subtitleLabel) { [self] in
      $0.numberOfLines = 0
      $0.lineBreakMode = .byWordWrapping
      $0.attributedText = NSMutableAttributedString(string: paragraph, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
      $0.textColor = .grey300
      $0.font = .body1
      $0.snp.makeConstraints {
        $0.top.equalTo(self.titleLabel.snp.bottom).offset(16)
        $0.leading.equalTo(self.titleLabel.snp.leading)
        $0.trailing.equalTo(self.scrollContainverView.snp.trailing).offset(-20)
      }
    }
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
    let url = URL(string: self.characterPerInfo.imgURL[indexPath.row])
    do {
      let data = try Data(contentsOf: url!)
      cell.myImage.image = UIImage(data: data)
    } catch { }
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

extension ContentVC {
  
  private func requestGetCharacterList() {
    CharacterService.shared.getCharacterList { networkResult in
      switch networkResult {
      case .success(let result):
        guard let response = result as? CharacterRequestModel else { return }
        if let userData = response.data {
          if let id = self.characterId {
            self.characterPerInfo = userData.personalities[id-1]
            self.setupUI()
            self.setCollectionAttributes()
          }
        }
        print(response.message)
      case .requestErr(let msg):
        print("requestErr \(msg)")
      case .pathErr:
        print("pathErr")
      case .serverErr:
        print("serverErr")
      case .networkFail:
        print("networkFail")
      }
    }
  }
}
