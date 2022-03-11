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
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var todayView: UIView!
    @IBOutlet weak var todayEmptyView: UIView!
    
    private var dataSourceCount: Int = 0 {
        didSet {
            updateUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        updateUI()
        setupTableView()
    }
    
    private func setupUI() {
        todayContainerView.layer.cornerRadius = 8
        todayEmptyView.isHidden = true
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        let nib = UINib(nibName: ReportTableViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: ReportTableViewCell.identifier)
        
        tableView.backgroundColor = .clear
    }
    
    private func updateUI() {
        if dataSourceCount != 0 {
            todayView.isHidden = false
            todayEmptyView.isHidden = true
        } else {
            todayView.isHidden = true
            todayEmptyView.isHidden = false
        }
    }
}

extension ResultVC: UITableViewDelegate {}

extension ResultVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        emptyView.isHidden = dataSourceCount != 0
        return dataSourceCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ReportTableViewCell.identifier,
            for: indexPath
        ) as? ReportTableViewCell else { return UITableViewCell() }
        return cell
    }
}
