//
//  NavigationBarView.swift
//  MEEW-Client
//
//  Created by taehy.k on 2022/06/08.
//

import UIKit

import SnapKit
import Then

final class NavigationBarView: UIView {
    
    lazy var navigationBackButton = UIButton().then {
        $0.setImage(UIImage(named: "icn_back"), for: .normal)
        $0.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
    }
    
    lazy var navigationTitleLabel = UILabel().then {
        $0.textColor = .white
        $0.font = UIFont(name: "SpoqaHanSansNeo-Bold", size: 18)!
    }
    
    lazy var doneButton = UIButton().then {
        $0.isHidden = true
        $0.setTitle("완료", for: .normal)
        $0.titleLabel?.font = UIFont.body1
    }
    
    lazy var rightItemButton = UIButton().then {
        $0.isHidden = true
    }

    var title: String? {
        didSet {
            navigationTitleLabel.text = title
        }
    }
    var dismissClosure: (() -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setStyle()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setStyle()
    }
    
    convenience init(hasDoneButton: Bool) {
        self.init(frame: .zero)
        doneButton.isHidden = !hasDoneButton
    }
    
    convenience init(withRightItemImage: UIImage) {
        self.init(frame: .zero)
        navigationBackButton.isHidden = true
        doneButton.isHidden = true
        rightItemButton.isHidden = false
        rightItemButton.setImage(withRightItemImage, for: .normal)
    }
    
    private func setStyle() {
        self.addSubviews([navigationBackButton, navigationTitleLabel, doneButton, rightItemButton])
        
        navigationBackButton.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview().inset(4)
        }
        
        navigationTitleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        doneButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(30)
            $0.height.equalTo(24)
        }
        
        rightItemButton.snp.makeConstraints {
            $0.width.height.equalTo(48)
            $0.trailing.equalToSuperview().inset(4)
            $0.centerY.equalTo(navigationTitleLabel)
        }
    }
    
    @objc
    private func dismissViewController() {
        dismissClosure?()
    }
}
