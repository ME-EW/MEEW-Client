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
        //✅ 서버연결 시 사용할 원래 코드
        //        let url = URL(string: appData.image)
        //        characterImageView.kf.setImage(with: url)
        //        characterName.text = appData.name
        //        characterInfo.text = appData.info
        
        //❌ UI 점검용으로 사용할 코드
        characterImageView.image = appData.makeItemImage()
        characterName.text = appData.name
        characterInfo.text = appData.info
        
        switch(characterName.text) {
        case "태양이" :
            return checkIconColor = ImageLiterals.checkIcon.redCheckIcon
        case "마음이" :
            return checkIconColor = ImageLiterals.checkIcon.yellowCheckIcon
        case "정직이" :
            return checkIconColor = ImageLiterals.checkIcon.purpleCheckIcon
        case "하늘이" :
            return checkIconColor = ImageLiterals.checkIcon.blueCheckIcon
        case "구름이" :
            return checkIconColor = ImageLiterals.checkIcon.lightpinkCheckIcon
        case "바람이" :
            return checkIconColor = ImageLiterals.checkIcon.purpleCheckIcon
        case "방향이" :
            return checkIconColor = ImageLiterals.checkIcon.greenCheckIcon
        case "꽃님이" :
            return checkIconColor = ImageLiterals.checkIcon.orangeCheckIcon
        case .none:
            return checkIconColor = ImageLiterals.checkIcon.redCheckIcon
        case .some(_):
            return checkIconColor = ImageLiterals.checkIcon.redCheckIcon
        }
    }
    
}
