//
//  InfoView.swift
//  MEEW-Client
//
//  Created by taehy.k on 2022/06/09.
//

import UIKit

import SnapKit
import Then

final class InfoView: UIView {
    private lazy var serviceInfoLabel = UILabel().then {
        $0.font = UIFont(name: "SpoqaHanSansNeo-Medium", size: 12)!
        $0.textColor = .grey400
        $0.text = "서비스 정보"
    }
    
    private lazy var noticeLabel = UILabel().then {
        $0.font = UIFont.body1
        $0.textColor = .white
        $0.text = "공지사항"
    }
    
    private lazy var policyLabel = UILabel().then {
        $0.font = UIFont.body1
        $0.textColor = .white
        $0.text = "약관 및 정책"
    }
    
    private lazy var privacyLabel = UILabel().then {
        $0.font = UIFont.body1
        $0.textColor = .white
        $0.text = "개인정보 처리 방침"
    }
    
    private let lineView1 = UIView().then {
        $0.backgroundColor = .grey500
    }
    
    private let lineView2 = UIView().then {
        $0.backgroundColor = .grey500
    }
    
    private let lineView3 = UIView().then {
        $0.backgroundColor = .grey500
    }
    
    private let lineView4 = UIView().then {
        $0.backgroundColor = .grey500
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setLayout() {
        addSubviews([serviceInfoLabel, noticeLabel, policyLabel, privacyLabel,
                     lineView1, lineView2, lineView3, lineView4])
        
        serviceInfoLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(32)
            $0.leading.equalToSuperview().offset(20)
        }
        
        lineView1.snp.makeConstraints {
            $0.top.equalTo(serviceInfoLabel.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(0.5)
        }
        
        noticeLabel.snp.makeConstraints {
            $0.top.equalTo(lineView1.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
        }
        
        lineView2.snp.makeConstraints {
            $0.top.equalTo(noticeLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(0.5)
        }
        
        policyLabel.snp.makeConstraints {
            $0.top.equalTo(lineView2.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(20)
        }
        
        lineView3.snp.makeConstraints {
            $0.top.equalTo(policyLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(0.5)
        }
        
        privacyLabel.snp.makeConstraints {
            $0.top.equalTo(lineView3.snp.bottom).offset(28)
            $0.leading.equalToSuperview().offset(20)
        }
        
        lineView4.snp.makeConstraints {
            $0.top.equalTo(privacyLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(0.5)
        }
    }
}

