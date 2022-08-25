//
//  SceneDelegate.swift
//  MEEW-Client
//
//  Created by taehy.k on 2021/11/20.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        window?.rootViewController = UINavigationController(rootViewController: ArchiveDetailVC())
        window?.makeKeyAndVisible()
    }
}

