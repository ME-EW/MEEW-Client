//
//  AlertTableViewCell.swift
//  MEEW-Client
//
//  Created by 안현주 on 2022/08/18.
//

import UIKit

class AlertTableViewCell: UITableViewCell {

	@IBOutlet weak var alertImageView: UIImageView!
	@IBOutlet weak var alertLabel: UILabel!
	@IBOutlet weak var alertDateLabel: UILabel!
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	
	func setData(appData: AlertDataModel) {
		alertImageView.image = appData.alertImage
		alertLabel.text = appData.alertMessage
		alertDateLabel.text = appData.alertDate
	}

}
