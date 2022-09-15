//
//  ArchiveEmptyView.swift
//  MEEW-Client
//
//  Created by taekki on 2022/08/18.
//

import UIKit

import SnapKit
import Then

final class ArchiveEmptyView: UIView {
    
    lazy var imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.image = ImageLiterals.imageCharacterNothing
    }
    
    private let descriptionLabel = UILabel().then {
        $0.text = "아직 기록이 없어요."
        $0.textColor = .white
        $0.font = .body2
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        configureLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension ArchiveEmptyView {
    
    func configureLayout() {
        self.addSubviews([imageView, descriptionLabel])
        
        imageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().inset(14)
            $0.width.height.equalTo(100)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(8)
            $0.centerX.equalTo(imageView)
        }
    }
}
