//
//  MyCell.swift
//  MEEW-Client
//
//  Created by 임주민 on 2022/05/21.
//

import UIKit

class MyCell: UICollectionViewCell {
  
  var myImage = UIImageView()
  var myLabel = UILabel()
  let backView = UIView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func setupView(){
    backgroundColor = .clear
    
    self.contentView.add(myLabel) {
      $0.font = .body2
      $0.textColor = .grey300
      $0.snp.makeConstraints {
        $0.top.equalTo(self.contentView)
        $0.centerX.equalTo(self.contentView)
      }
    }
    self.contentView.add(backView) {
      $0.backgroundColor = UIColor(red: 0.15, green: 0.147, blue: 0.147, alpha: 1)
      $0.layer.cornerRadius = 8
      $0.snp.makeConstraints {
        $0.leading.trailing.bottom.equalTo(self.contentView)
        $0.top.equalTo(self.myLabel.snp.bottom).offset(10)
      }
    }
    self.contentView.add(myImage) {
      $0.contentMode = .scaleAspectFit
      $0.snp.makeConstraints {
        $0.centerY.equalTo(self.backView.snp.centerY)
        $0.centerX.equalTo(self.backView.snp.centerX)
        $0.width.height.equalTo(160-26)
      }
    }
  }
}
