//
//  ArchiveDetailView.swift
//  MEEW-Client
//
//  Created by taekki on 2022/08/25.
//

import UIKit

import SnapKit
import Then

final class ArchiveDetailView: UIView {
    
    let dateLabel = UILabel()
    let dateButton = UIButton()
    let closeButton = UIButton()
    let containerView = UIView()
    let progressView = ArchiveLevelProgressView()
    let nameLabel = UILabel()
    let characterImageView = UIImageView()
    let tableView = UITableView(frame: .zero, style: .plain)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configureUI() {
        
        backgroundColor = .grey700
        
        dateLabel.do {
            $0.text = "2022.02.26"
            $0.textColor = .white
            $0.font = .head3
        }
        
        dateButton.do {
            $0.setImage(ImageLiterals.icnArrowDown, for: .normal)
            $0.contentMode = .scaleAspectFill
        }
        
        closeButton.do {
            $0.setImage(ImageLiterals.icnClose, for: .normal)
            $0.contentMode = .scaleAspectFill
        }
        
        containerView.do {
            $0.layer.borderWidth = 0.5
            $0.layer.borderColor = UIColor.grey400.cgColor
            $0.layer.cornerRadius = 8
        }
        
        nameLabel.do {
            $0.text = "즉흥적인 바람이"
            $0.textColor = .white
            $0.font = .head3
        }
        
        characterImageView.do {
            $0.image = ImageLiterals.imageCharacterToday
            $0.contentMode = .scaleAspectFill
        }
        
        tableView.do {
            $0.backgroundColor = .clear
        }
    }
    
    func configureLayout() {
        
        addSubviews([dateLabel, dateButton, closeButton, containerView])
        containerView.addSubviews([progressView, nameLabel, characterImageView, tableView])
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(13)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(24)
        }
        
        dateButton.snp.makeConstraints {
            $0.leading.equalTo(dateLabel.snp.trailing).inset(2)
            $0.size.equalTo(48)
            $0.centerY.equalTo(dateLabel)
        }
        
        closeButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(2)
            $0.size.equalTo(48)
            $0.centerY.equalTo(dateButton)
        }
        
        containerView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(81)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(506)
        }
        
        progressView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.width.equalTo(87)
            $0.height.equalTo(22)
            $0.centerX.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(progressView.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(24)
        }
        
        characterImageView.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(24)
            $0.size.equalTo(168)
            $0.centerX.equalToSuperview()
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(characterImageView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(16)
        }
    }
}
