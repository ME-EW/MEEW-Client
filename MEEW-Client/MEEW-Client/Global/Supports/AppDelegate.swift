//
//  AppDelegate.swift
//  MEEW-Client
//
//  Created by taehy.k on 2021/11/20.
//

import UIKit
import FirebaseMessaging
import UserNotifications
import FirebaseCore
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	
	
	// Tells the delegate that the launch process is almost done and the app is almost ready to run.
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.
		
		// 기존에 적었던 파이어베이스 권한 설정
		FirebaseApp.configure()
		
		// 푸시 권한 설정
		UNUserNotificationCenter.current().delegate = self
		
		let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
		UNUserNotificationCenter
			.current()
			.requestAuthorization(
				options: authOptions,completionHandler: { (_, _) in }
			)
		application.registerForRemoteNotifications()
		
		UIApplication.shared.registerForRemoteNotifications()
		
		return true
	}
	

	// Sent to the delegate when APNs cannot successfully complete the registration process.
	func application(_ application: UIApplication,
				didFailToRegisterForRemoteNotificationsWithError
					error: Error) {
	   // Try again later.
	}
	
	
	// MARK: UISceneSession Lifecycle
	
	func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
		// Called when a new scene session is being created.
		// Use this method to select a configuration to create the new scene with.
		return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
	}
	
	func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
		
	}
	
	// Called when APNs has assigned the device a unique token
	func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//		let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
//
//		print("APNs device token: \(deviceTokenString)")
//
//		Messaging.messaging().apnsToken = deviceToken
		
		
		
		
		// sendDeviceTokenToServer() 커스텀 메서드를 만들어주어서 서버로 deviceToken 을 보내면 된다.
		// self.sendDeviceTokenToServer(data: deviceToken)
	}
	
	
}



extension AppDelegate : UNUserNotificationCenterDelegate {

	// 1. Asks the delegate how to handle a notification that arrived while the app was running in the foreground.
	func userNotificationCenter(_ center: UNUserNotificationCenter,willPresent notification: UNNotification,withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
		completionHandler([.alert, .sound])
	}

	// 2. Asks the delegate to process the user's response to a delivered notification.
	func userNotificationCenter(_ center: UNUserNotificationCenter,didReceive response: UNNotificationResponse,withCompletionHandler completionHandler: @escaping () -> Void) {
		completionHandler()
	}
}

extension AppDelegate : MessagingDelegate {
	
	func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
		print("Firebase registration token: \(String(describing: fcmToken))")
		let dataDict:[String: String] = ["token": fcmToken ?? ""]
		NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
	}
	
}
