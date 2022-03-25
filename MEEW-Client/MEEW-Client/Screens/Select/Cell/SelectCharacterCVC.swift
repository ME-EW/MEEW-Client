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
    
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var characterInfo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }
    
    private func setUI() {
        self.layer.cornerRadius = 16
        characterImageView.layer.cornerRadius = 16
        self.layer.borderWidth = 1.5
        self.layer.borderColor = UIColor.grey2.cgColor
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
    }

}
