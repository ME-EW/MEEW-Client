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
        navigationBarView.backgroundColor = .blue
        navigationBarView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(48)
        }
    }
}
