//
//  ArchiveCVC.swift
//  MEEW-Client
//
//  Created by taehy.k on 2021/11/21.
//

import UIKit

class ArchiveCVC: UICollectionViewCell {

    @IBOutlet weak var archiveImageView: UIImageView!
    @IBOutlet weak var archiveDayLabel: UILabel!
    @IBOutlet weak var archiveTitleLabel: UILabel!
    @IBOutlet weak var archivePercentLabel: UILabel!
    @IBOutlet weak var archiveGageView: UIView!
    @IBOutlet weak var archiveGageBackgroundView: UIView!

    @IBOutlet weak var gageConstraint: NSLayoutConstraint!
    
    var percent: CGFloat = 70
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
        setGage()
    }
    
    private func setup() {
        archiveImageView.layer.cornerRadius = 8
        archiveGageView.layer.cornerRadius = 8
        archiveGageBackgroundView.layer.cornerRadius = 8
        layer.masksToBounds = true
        layer.cornerRadius = 8
    }
    
    private func setGage() {
        let ratio  = percent / 100
        gageConstraint.constant = archiveGageBackgroundView.frame.width * ratio
        self.layoutSubviews()
    }
}
