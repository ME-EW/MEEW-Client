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
    lazy var archiveHeaderView = ArchiveHeaderView()
    lazy var emptyView = ArchiveEmptyView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureLayout()
    }
}

extension ArchiveVC {
    
    private func configureUI() {
        view.backgroundColor = .grey700
        archiveBannerView.layer.cornerRadius = 8
    }
    
    private func configureLayout() {
        view.addSubviews([archiveBannerView, archiveHeaderView, emptyView])
        
        archiveBannerView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(29)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(180)
        }
        
        archiveHeaderView.snp.makeConstraints {
            $0.top.equalTo(archiveBannerView.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview()
        }
        
        emptyView.snp.makeConstraints {
            $0.top.equalTo(archiveHeaderView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(80)
        }
    }
}
