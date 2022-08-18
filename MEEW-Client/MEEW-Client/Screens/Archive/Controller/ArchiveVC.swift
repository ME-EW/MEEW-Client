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
    
    // MARK: - Properties
    
    var data: [Any] = ["1", "2", "3"]
    
    // MARK: - UI Properties
    
    lazy var archiveBannerView = ArchiveBannerView()
    lazy var archiveHeaderView = ArchiveHeaderView()
    lazy var emptyView = ArchiveEmptyView()
    let progressView = ArchiveLevelProgressView()
    let tableView = UITableView().then {
        $0.isScrollEnabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureLayout()
        configureTableView()
    }
}

extension ArchiveVC {
    
    private func configureUI() {
        view.backgroundColor = .grey700
        archiveBannerView.layer.cornerRadius = 8
    }
    
    private func configureLayout() {
        view.addSubviews([archiveBannerView, archiveHeaderView, tableView])
        
        archiveBannerView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(29)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(180)
        }

        archiveHeaderView.snp.makeConstraints {
            $0.top.equalTo(archiveBannerView.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(40)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(archiveHeaderView.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(80)
        }
    }
    
    private func configureTableView() {
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ArchiveTVC.self, forCellReuseIdentifier: ArchiveTVC.reuseIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
    }
}

extension ArchiveVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.backgroundView = data.isEmpty ? emptyView : nil
        return data.isEmpty ? 0 : data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ArchiveTVC.reuseIdentifier) as! ArchiveTVC
        return cell
    }
}
