//
//  SceneDelegate.swift
//  PokeDex
//
//  Created by Chung Han Hsin on 2024/4/17.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        let navigationController = makeNavigationController(with: AllPokemonListViewController())
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func makeNavigationController(with rootViewController: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.setNavigationBarHidden(false, animated: false)
        navigationController.navigationBar.tintColor = UIColor.white   
        navigationController.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        return navigationController
    }
}


