//
//  ProfileView.swift
//  MEEW-Client
//
//  Created by taehy.k on 2022/06/09.
//

import UIKit

import SnapKit
import Then

final class ProfileView: UIView {
    private lazy var nameLabel = UILabel().then {
        $0.text = name
        $0.font = UIFont(name: "SpoqaHanSansNeo-Bold", size: 21)!
        $0.textColor = .white
    }
    
    private lazy var emailLabel = UILabel().then {
        $0.text = email
        $0.font = UIFont(name: "SpoqaHanSansNeo-Medium", size: 12)!
        $0.textColor = .grey400
    }
    
    lazy var manageButton = UIButton().then {
        $0.setTitle("관리", for: .normal)
        $0.titleLabel?.font = UIFont.body2
        $0.setTitleColor(.white, for: .normal)
        $0.addTarget(self, action: #selector(manageButtonDidTap), for: .touchUpInside)
    }
    
    private let lineView = UIView().then {
        $0.backgroundColor = .grey500
    }
    
    var name: String? {
        didSet {
            nameLabel.text = name
        }
    }
    
    var email: String? {
        didSet {
            emailLabel.text = email
        }
    }
    
    var manageButtonClosure: (() -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setLayout() {
        addSubviews([nameLabel, emailLabel, manageButton, lineView])
        
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(32)
            $0.leading.equalToSuperview().inset(20)
            $0.height.equalTo(28)
        }
        
        emailLabel.snp.makeConstraints {
            $0.leading.equalTo(nameLabel.snp.leading)
            $0.top.equalTo(nameLabel.snp.bottom).offset(7)
            $0.height.equalTo(18)
        }
        
        manageButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalTo(emailLabel.snp.centerY)
            $0.width.equalTo(26)
            $0.height.equalTo(18)
        }
        
        lineView.snp.makeConstraints {
            $0.top.equalTo(emailLabel.snp.bottom).offset(31)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(0.5)
        }
    }
    
    @objc
    func manageButtonDidTap() {
        manageButtonClosure?()
    }
}
