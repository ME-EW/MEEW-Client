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
    lazy var datePicker = UIDatePicker()
    
    var data: Specific? { didSet { rootView.tableView.reloadData() } }
    
    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        configureTarget()
        requestArchive()
    }
    
    private func configureTableView() {
        rootView.tableView.delegate = self
        rootView.tableView.dataSource = self
        rootView.tableView.register(ArchiveTodoTVC.self, forCellReuseIdentifier: ArchiveTodoTVC.reuseIdentifier)
        rootView.tableView.rowHeight = 56
        rootView.tableView.isScrollEnabled = false
        rootView.tableView.separatorStyle = .singleLine
        rootView.tableView.separatorInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        rootView.tableView.separatorColor = .grey500
    }
    
    private func configureTarget() {
        rootView.dateButton.addTarget(self, action: #selector(pickDate), for: .touchUpInside)
        rootView.closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
    }
}

extension ArchiveDetailVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.fail?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArchiveTodoTVC.reuseIdentifier) as? ArchiveTodoTVC else {
            return UITableViewCell()
        }
        cell.configure(data?.fail?[indexPath.row])
        return cell
    }
}

extension ArchiveDetailVC {
    
    @objc func pickDate() {
        DatePickerView.shared.show()
    }
    
    @objc func close() {
        dismiss(animated: true)
    }
    
    private func requestArchive() {
        ArchiveService.shared.fetchSpecificArchive(for: "2022-09-11") { response in
            switch response {
            case .success(let result):
                guard let response = result as? SpecificArchiveDTO else { return }
                if let data = response.data {
                    self.data = data
                }
            default:
                print("error")
                return
            }
        }
    }
}
