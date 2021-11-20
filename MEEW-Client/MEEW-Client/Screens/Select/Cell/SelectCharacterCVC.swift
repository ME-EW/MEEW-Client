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
    
    func setUI() {
        self.layer.cornerRadius = 16
    }
    
    func setData(appData: SelectCharacterDataModel){
        let url = URL(string: appData.image)
        characterImageView.kf.setImage(with: url)
        characterName.text = appData.name
        characterInfo.text = appData.info
    }

}
