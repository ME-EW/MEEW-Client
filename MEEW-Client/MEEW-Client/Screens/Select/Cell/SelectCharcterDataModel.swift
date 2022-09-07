//
//  SelectCharcterDataModel.swift
//  MEEW-Client
//
//  Created by 안현주 on 2021/11/21.
//
import UIKit

struct SelectCharacterDataModel {
    
	var id: Int
    var image : String
    var name : String
    var description : String

    func makeItemImage() -> UIImage? {
        return UIImage(named: image)
    }
    
}
