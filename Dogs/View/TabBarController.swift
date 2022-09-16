//
//  TabBarController.swift
//  Dogs
//
//  Created by Прохоренко Георгий Денисович on 07.09.2022.
//

import UIKit

final class TabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
        setTabBar()
    }

    private func generateTabBar() {
        viewControllers = [
            generateVC(viewController: UINavigationController(
                rootViewController: ViewController()), title: "Breeds"),
            generateVC(viewController: UINavigationController(
                rootViewController: FavoritViewController()), title: "Favorite")
        ]
    }

    private func generateVC(viewController: UINavigationController,
                            title: String) -> UIViewController {
        viewController.tabBarItem.title = title
//        viewController.tabBarItem.image = image
        return viewController
    }

    private func setTabBar() {
        let posicionOnX: CGFloat = 50
        let posicionOnY: CGFloat = 10
        let width: CGFloat = tabBar.bounds.width - 2 * posicionOnX
        let height: CGFloat = tabBar.bounds.height + 2 * posicionOnY

        let roundLayer = CAShapeLayer()
        let bezierPath = UIBezierPath(
            roundedRect: CGRect(
                x: posicionOnX,
                y: posicionOnY,
                width: width,
                height: height),
            cornerRadius: height / 2
        )

        roundLayer.path = bezierPath.cgPath
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        tabBar.itemWidth = width / 5
        tabBar.itemPositioning = .centered

        roundLayer.fillColor = UIColor.mainBlue.cgColor
    }
}

extension UIColor {
    static var mainBlue: UIColor {
        #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
    }
}
