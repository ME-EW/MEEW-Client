//
//  AlertViewController.swift
//  MEEW-Client
//
//  Created by 안현주 on 2022/08/18.
//

import UIKit

class AlertViewController: UIViewController {

	@IBOutlet weak var navigationBar: UINavigationBar!
	
	override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
	
	private func setUI(){
		navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
		navigationBar.shadowImage = UIImage()
	}
    


}
