//
//  ArchiveTodoTVC.swift
//  MEEW-Client
//
//  Created by taekki on 2022/08/25.
//

import UIKit

import SnapKit
import Then

final class ArchiveTodoTVC: UITableViewCell {
    
    
    private let checkImageView = UIImageView()
    private let todoLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        configureUI()
        configureLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    // MARK: - Configure Functions
    
    func configureUI() {
        backgroundColor = .clear
        selectionStyle = .none
        
        checkImageView.do {
            $0.image = ImageLiterals.icnCheckEmpty
            $0.contentMode = .scaleAspectFill
        }
        
        todoLabel.do {
            $0.text = "평소 먹지 않은 메뉴 시키기"
            $0.textColor = .white
            $0.font = UIFont(name: "SpoqaHanSansNeo-Regular", size: 14.0)!
        }
    }

    func configureLayout() {
        contentView.addSubviews([checkImageView, todoLabel])
        
        checkImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.size.equalTo(24)
            $0.centerY.equalToSuperview()
        }
        
        todoLabel.snp.makeConstraints {
            $0.leading.equalTo(checkImageView.snp.trailing).offset(8)
            $0.centerY.equalTo(checkImageView.snp.centerY)
            $0.trailing.equalToSuperview().inset(16)
        }
    }
}

