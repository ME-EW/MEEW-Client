//
//  SelectCharcterCVC.swift
//  MEEW-Client
//
//  Created by 안현주 on 2021/11/21.
//

import UIKit

class SelectCharacterCVC: UICollectionViewCell {

    static let identifier = "SelectCharacterCVC"
    
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var characterInfo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(appData: SelectCharacterDataModel){
        characterImageView.image = appData.makeItemImage()
        characterName.text = appData.name
        characterInfo.text = appData.info
    }

}
