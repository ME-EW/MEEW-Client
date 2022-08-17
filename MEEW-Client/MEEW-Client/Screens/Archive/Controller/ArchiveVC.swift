//
//  ArchiveVC.swift
//  MEEW-Client
//
//  Created by taekki on 2022/08/18.
//

import UIKit

import SnapKit
import Then

final class ArchiveVC: BaseVC {
    
    lazy var archiveBannerView = ArchiveBannerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureLayout()
    }
}

extension ArchiveVC {
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        archiveBannerView.layer.cornerRadius = 8
    }
    
    private func configureLayout() {
        view.addSubviews([archiveBannerView])
        
        archiveBannerView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(29)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(180)
        }
    }
}
