//
//  ReportTableViewCell.swift
//  MEEW-Client
//
//  Created by taehy.k on 2022/03/11.
//

import UIKit

class ReportTableViewCell: UITableViewCell {
    
    static let identifier = "ReportTableViewCell"

    @IBOutlet weak var progressContainerView: UIView!
    @IBOutlet weak var progressView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        progressContainerView.layer.cornerRadius = progressContainerView.bounds.height / 2
        progressView.layer.cornerRadius = progressView.bounds.height / 2
    }
}
