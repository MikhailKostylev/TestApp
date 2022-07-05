//
//  SceneDelegate.swift
//  TestApp
//
//  Created by Mikhail Kostylev on 04.07.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        setupWindow(scene: scene)
    }
    
    // MARK: - Private Methods
    
    private func setupWindow(scene: UIScene) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let assembly = Assembly()
        let router = Router(assembly: assembly)
        let leaguesScreen = assembly.createLeaguesScreen(router: router)
        let rootVC = UINavigationController(rootViewController: leaguesScreen)
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = rootVC
        window?.backgroundColor = Resources.Colors.appGreen
        window?.makeKeyAndVisible()
    }
    
    // MARK: - Scene Lifecycle

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}

