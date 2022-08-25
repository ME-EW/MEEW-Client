//
//  ArchiveDetailVC.swift
//  MEEW-Client
//
//  Created by taekki on 2022/08/25.
//

import UIKit

import SnapKit
import Then

final class ArchiveDetailVC: BaseVC {
    
    let rootView = ArchiveDetailView()
    
    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
    }
    
    private func configureTableView() {
        rootView.tableView.delegate = self
        rootView.tableView.dataSource = self
        rootView.tableView.register(ArchiveTodoTVC.self, forCellReuseIdentifier: ArchiveTodoTVC.reuseIdentifier)
        rootView.tableView.rowHeight = 56
    }
}

extension ArchiveDetailVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArchiveTodoTVC.reuseIdentifier) as? ArchiveTodoTVC else {
            return UITableViewCell()
        }
        
        return cell
    }
}
