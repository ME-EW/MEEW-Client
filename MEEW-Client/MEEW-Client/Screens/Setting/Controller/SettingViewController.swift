//
//  SettingViewController.swift
//  MEEW-Client
//
//  Created by taehy.k on 2022/06/08.
//

import UIKit

final class SettingViewController: UIViewController {
    
    let navigationBarView = NavigationBarView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(navigationBarView)
        navigationBarView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(48)
        }
    }
}
