//
//  ResultVC.swift
//  MEEW-Client
//
//  Created by taehy.k on 2021/11/21.
//

import UIKit

final class ResultVC: BaseVC {
    
    @IBOutlet weak var todayContainerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
    }
    
    private func setupUI() {
        todayContainerView.layer.cornerRadius = 8
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        let nib = UINib(nibName: ReportTableViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: ReportTableViewCell.identifier)
        
        tableView.backgroundColor = .clear
    }
}

extension ResultVC: UITableViewDelegate {}

extension ResultVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ReportTableViewCell.identifier,
            for: indexPath
        ) as? ReportTableViewCell else { return UITableViewCell() }
        
        return cell
    }
}
