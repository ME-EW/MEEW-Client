//
//  BaseVC.swift
//  MEEW-Client
//
//  Created by taehy.k on 2021/11/20.
//

import UIKit

class BaseVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
    }
}
