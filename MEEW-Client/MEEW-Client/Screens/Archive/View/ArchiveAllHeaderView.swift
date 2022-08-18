//
//  ArchiveAllHeaderView.swift
//  MEEW-Client
//
//  Created by taekki on 2022/08/18.
//

import UIKit

import SnapKit
import Then

final class ArchiveAllHeaderView: UITableViewHeaderFooterView {
    
    static let reuseIdentifier = "ArchiveAllHeaderView"
    
    private let timeLabel = UILabel().then {
        $0.text = "YYYY년 M월"
        $0.textColor = .grey400
        $0.font = .body3
    }
    
    private let lineView = UIView().then {
        $0.backgroundColor = .grey500
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        configureUI()
        configureLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension ArchiveAllHeaderView {
    
    func configureUI() {
    }
    
    private func configureLayout() {
        self.addSubviews([timeLabel, lineView])

        timeLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.top.equalToSuperview().inset(8)
        }
        
        lineView.snp.makeConstraints {
            $0.top.equalTo(timeLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(0.5)
        }
    }
}
