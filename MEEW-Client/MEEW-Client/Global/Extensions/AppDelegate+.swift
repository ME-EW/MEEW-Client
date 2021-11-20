//
//  AppDelegate+.swift
//  MEEW-Client
//
//  Created by taehy.k on 2021/11/21.
//

import UIKit

extension AppDelegate {
    static var currentKeyWindow: UIWindow? {
        UIApplication.shared.windows.first { $0.isKeyWindow }
    }
}
