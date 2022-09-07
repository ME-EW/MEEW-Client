//
//  SelectCharcterCVC.swift
//  MEEW-Client
//
//  Created by 안현주 on 2021/11/21.
//

import UIKit
import Kingfisher

class SelectCharacterCVC: UICollectionViewCell {
	
	static let identifier = "SelectCharacterCVC"
	var checkIconColor = ImageLiterals.checkIcon.redCheckIcon
	lazy var active: (() -> Void) = {}
	
	
	@IBOutlet weak var characterImageView: UIImageView!
	@IBOutlet weak var characterName: UILabel!
	@IBOutlet weak var characterInfo: UILabel!
	@IBOutlet weak var checkImageView: UIImageView!
	
	override var isSelected: Bool {
		didSet{
			if isSelected {
				self.layer.backgroundColor = UIColor.grey600.cgColor
				self.layer.borderColor = UIColor.grey300.cgColor
				self.checkImageView.image = checkIconColor
				active()
				
				var count = characterName.text?.count
				var sliced_str = characterName.text![(count ?? 0)-3 ..< (count ?? 0)]
				
				setNotification(name: sliced_str ?? "마음이")
//				print("CVC에서 쏜 이름",characterName.text)
			}
			else {
				self.layer.backgroundColor = .none
				self.layer.borderColor = UIColor.grey500.cgColor
				self.checkImageView.image = UIImage(named: "icn_roundcheck")
			}
		}
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		setUI()
	}
	
	private func setUI() {
		self.layer.cornerRadius = 8
		characterImageView.layer.cornerRadius = 8
		self.layer.borderWidth = 1.5
		self.layer.borderColor = UIColor.grey500.cgColor
	}
	
	
	func setData(appData: SelectCharacterDataModel){
		let url = URL(string: appData.image)
		characterImageView.kf.setImage(with: url)
		
		
		characterName.text = appData.name
		characterInfo.text = appData.description

		switch(appData.id) {
		case 2 :
			return checkIconColor = ImageLiterals.checkIcon.redCheckIcon
		case 8 :
			return checkIconColor = ImageLiterals.checkIcon.yellowCheckIcon
		case 4 :
			return checkIconColor = ImageLiterals.checkIcon.purpleCheckIcon
		case 3 :
			return checkIconColor = ImageLiterals.checkIcon.blueCheckIcon
		case 6 :
			return checkIconColor = ImageLiterals.checkIcon.lightpinkCheckIcon
		case 1 :
			return checkIconColor = ImageLiterals.checkIcon.purpleCheckIcon
		case 7 :
			return checkIconColor = ImageLiterals.checkIcon.greenCheckIcon
		case 5 :
			return checkIconColor = ImageLiterals.checkIcon.orangeCheckIcon
		default :
			return checkIconColor = ImageLiterals.checkIcon.redCheckIcon
		}
	}
	
	func setNotification(name : String) {
		NotificationCenter.default.post(name:NSNotification.Name(rawValue: "characterName"),
										object: name)
	}
	
}
