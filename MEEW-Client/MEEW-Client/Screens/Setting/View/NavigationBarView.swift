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
    
    let navigationBackButton = UIButton().then {
        $0.setImage(UIImage(named: "icn_back"), for: .normal)
    }
    
    let navigationTitleLabel = UILabel().then {
        $0.text = "설정"
        $0.textColor = .white
        $0.font = UIFont(name: "SpoqaHanSansNeo-Bold", size: 18)!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setStyle()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setStyle()
    }
    
    private func setStyle() {
        self.addSubviews([navigationBackButton, navigationTitleLabel])
        
        navigationBackButton.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview().inset(4)
        }
        
        navigationTitleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
