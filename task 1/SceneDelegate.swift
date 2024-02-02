//
//  SceneDelegate.swift
//  task 1
//
//  Created by thrxmbxne on 19/01/24.
//

import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?
	let messageFieldVM = MessageFieldViewModel()

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		if let windowScene = scene as? UIWindowScene {
			let window = UIWindow(windowScene: windowScene)

			//AUse the top-level messageFieldVM consistently
			let contentView = ContentView().environmentObject(messageFieldVM)

			window.rootViewController = UIHostingController(rootView: contentView)
			self.window = window
			window.makeKeyAndVisible()
		}
	}
}
