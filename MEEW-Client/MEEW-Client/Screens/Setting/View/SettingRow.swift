//
//  SettingRow.swift
//  MEEW-Client
//
//  Created by taehy.k on 2022/06/09.
//

import UIKit

import SnapKit
import Then

final class SettingRow: UIView {
    private lazy var rowTitleLabel = UILabel().then {
        $0.font = UIFont.body1
        $0.textColor = .white
    }
    
    private lazy var moreIcon = UIImageView().then {
        $0.image = UIImage(named: "icn_more")
        $0.contentMode = .scaleAspectFit
    }
    
    private lazy var infoLabel = UILabel().then {
        $0.isHidden = true
        $0.font = UIFont.body4
        $0.text = "최신 버전"
        $0.textColor = .grey400
    }
    
    private let lineView = UIView().then {
        $0.backgroundColor = .grey500
    }
    
    var rowTitle: String? {
        didSet {
            rowTitleLabel.text = rowTitle
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    convenience init(isVersionRow: Bool) {
        self.init(frame: .zero)
        moreIcon.isHidden.toggle()
        infoLabel.isHidden.toggle()
        lineView.isHidden.toggle()
    }
    
    private func setLayout() {
        addSubviews([rowTitleLabel, moreIcon, infoLabel, lineView])
        
        rowTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(30)
            $0.centerY.equalToSuperview()
        }
        
        moreIcon.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(4)
            $0.width.height.equalTo(48)
            $0.centerY.equalToSuperview()
        }
        
        infoLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }
        
        lineView.snp.makeConstraints {
            $0.top.equalTo(rowTitleLabel.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(0.5)
        }
    }
}
