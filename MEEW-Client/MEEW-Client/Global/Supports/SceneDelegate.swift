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
    guard let _ = (scene as? UIWindowScene) else { return }
    if let windowScene = scene as? UIWindowScene {
      let window = UIWindow(windowScene: scene as! UIWindowScene)
      window.rootViewController = TabbarViewController()
      self.window = window
      window.makeKeyAndVisible()
    }
  }
  
}
