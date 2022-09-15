//
//  ArchiveLevelProgressView.swift
//  MEEW-Client
//
//  Created by taekki on 2022/08/18.
//

import UIKit

import SnapKit
import Then

final class ArchiveLevelProgressView: UIView {
    
    private let levelLabel = UILabel().then {
        $0.text = "Lv.1"
        $0.textColor = .purple
        $0.font = .body3
    }
    
    private lazy var progressHStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 4
        
        for index in 0...3 {
            let pointView = UIView()
            pointView.backgroundColor = .grey700
            pointView.layer.cornerRadius = 2
            $0.addArrangedSubview(pointView)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureUI()
        configureLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension ArchiveLevelProgressView {
    
    private func configureUI() {
        self.backgroundColor = .grey600
    }
    
    private func configureLayout() {
        addSubviews([levelLabel, progressHStackView])
        levelLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(10)
            $0.top.bottom.equalTo(2)
        }
        
        progressHStackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.height.equalTo(6)
            $0.leading.equalTo(levelLabel.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().inset(10)
        }
    }
}
