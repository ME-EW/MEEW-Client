//
//  ArchiveHeaderView.swift
//  MEEW-Client
//
//  Created by taekki on 2022/08/18.
//

import UIKit

import SnapKit
import Then

protocol ArchiveHeaderViewDelegate: AnyObject {
    func archiveButtonTapped()
}

final class ArchiveHeaderView: UIView {
    
    private let titleLabel = UILabel().then {
        $0.text = "최근기록"
        $0.textColor = .white
        $0.font = .title4
    }
    
    private lazy var archiveButton = UIButton().then {
        $0.setTitle("전체보기", for: .normal)
        $0.setTitleColor(.grey300, for: .normal)
        $0.titleLabel?.font = .body2
    }
    
    private let lineView = UIView().then {
        $0.backgroundColor = .grey500
    }
    
    weak var delegate: ArchiveHeaderViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        configureLayout()
        archiveButton.addTarget(self, action: #selector(archiveButtonTapped), for: .touchUpInside)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension ArchiveHeaderView {
    
    private func configureLayout() {
        self.addSubviews([titleLabel, archiveButton, lineView])

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
            $0.height.equalTo(24)
        }
        
        archiveButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalTo(titleLabel)
            $0.height.equalTo(18)
        }
        
        lineView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(0.5)
        }
    }
    
    @objc func archiveButtonTapped() {
        delegate?.archiveButtonTapped()
    }
}

