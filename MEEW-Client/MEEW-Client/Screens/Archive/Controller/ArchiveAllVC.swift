//
//  ArchiveAllVC.swift
//  MEEW-Client
//
//  Created by taekki on 2022/08/18.
//

import UIKit

import SnapKit
import Then

final class ArchiveAllVC: BaseVC {
    
    // MARK: - Properties
    
    var data: [All] = [] { didSet { tableView.reloadData() } }
    var month: [Int] = [] { didSet { tableView.reloadData() } }
    
    // MARK: - UI Properties
    
    lazy var navigationBarView = NavigationBarView().then {
        $0.title = "전체 기록"
    }
    lazy var emptyView = ArchiveEmptyView()
    let tableView = UITableView(frame: .zero, style: .grouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureLayout()
        configureTableView()
        dismissController()
        requestAllArchive()
    }
    
    private func requestAllArchive(page: Int = 1) {
        ArchiveService.shared.fetchAllArchive(page: page) { response in
            switch response {
            case .success(let result):
                guard let response = result as? AllArchiveDTO else { return }
                if let data = response.data,
                   let all = data.all {
                    self.data = all
                    self.month = all.compactMap {
                        let df = DateFormatter()
                        df.dateFormat = "YYYY-MM-dd'T'hh:mm:ss.sss'Z'"
                        return df.date(from: $0.date)
                    }.map {
                        return Calendar.current.dateComponents([.month], from: $0).month!
                    }.reduce(into: [Int]()) { result, currentValue in
                        if (result.isEmpty || result.last != currentValue) {
                            result.append(currentValue)
                        }
                    }
                }
                
            default:
                print("Error")
                return
            }
        }
    }
}

extension ArchiveAllVC {
    
    private func configureUI() {
        view.backgroundColor = .grey700
    }
    
    private func configureLayout() {
        view.addSubviews([navigationBarView, tableView])

        navigationBarView.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(navigationBarView.snp.bottom).offset(18)
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    private func configureTableView() {
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ArchiveAllHeaderView.self, forHeaderFooterViewReuseIdentifier: ArchiveAllHeaderView.reuseIdentifier)
        tableView.register(ArchiveTVC.self, forCellReuseIdentifier: ArchiveTVC.reuseIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func dismissController() {
        navigationBarView.dismissClosure = {
            self.navigationController?.popViewController(animated: true)
        }
    }
}

extension ArchiveAllVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 34
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: ArchiveAllHeaderView.reuseIdentifier) as? ArchiveAllHeaderView else {
            return UITableViewHeaderFooterView()
        }
        
        return data.isEmpty ? nil : header
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        tableView.backgroundView = data.isEmpty ? emptyView : nil
        return month.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.isEmpty ? 0 : data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ArchiveTVC.reuseIdentifier) as! ArchiveTVC
        cell.configure(withAll: data[indexPath.row])
        return cell
    }
}
