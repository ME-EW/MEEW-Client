//
//  ArchiveBannerView.swift
//  MEEW-Client
//
//  Created by taekki on 2022/08/18.
//

import UIKit

import SnapKit
import Then

final class ArchiveBannerView: UIView {
    
    private lazy var characterImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.image = ImageLiterals.imageCharacterNothing
    }
    
    private let todayLabel = UILabel().then {
        $0.text = "Today"
        $0.textColor = .grey300
        $0.font = .body2
    }
    
    private let characterNameLabel = UILabel().then {
        $0.textColor = .white
        $0.font = .head3
    }
    
    private let characterDescriptionLabel = UILabel().then {
        $0.textColor = .grey300
        $0.font = .body4
        $0.numberOfLines = 0
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

extension ArchiveBannerView {
    
    private func configureUI() {
        self.backgroundColor = .grey600
    }
    
    private func configureLayout() {
        self.addSubviews([characterImageView, todayLabel, characterNameLabel, characterDescriptionLabel])

        characterImageView.snp.makeConstraints {
            $0.width.height.equalTo(140)
            $0.leading.equalToSuperview().inset(8)
            $0.top.bottom.equalToSuperview().inset(20)
        }
        
        todayLabel.snp.makeConstraints {
            $0.leading.equalTo(characterImageView.snp.trailing).offset(6)
            $0.top.equalToSuperview().inset(53)
            $0.height.equalTo(18)
        }
        
        characterNameLabel.snp.makeConstraints {
            $0.leading.equalTo(todayLabel)
            $0.top.equalTo(todayLabel.snp.bottom).offset(8)
            $0.height.equalTo(24)
        }
        
        characterDescriptionLabel.snp.makeConstraints {
            $0.leading.equalTo(todayLabel)
            $0.trailing.equalToSuperview().inset(22)
            $0.top.equalTo(characterNameLabel.snp.bottom).offset(8)
            $0.bottom.equalToSuperview().inset(33)
        }
    }
}
