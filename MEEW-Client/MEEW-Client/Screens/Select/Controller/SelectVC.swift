//
//  SelectVC.swift
//  MEEW-Client
//
//  Created by taehy.k on 2021/11/21.
//

import UIKit

class SelectVC: BaseVC {
    
    
    @IBOutlet weak var selectCV: UICollectionView!
    
    @IBOutlet weak var backgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    
    func setUI(){
        backgroundView.layer.cornerRadius = 8
    }
    
    
}
