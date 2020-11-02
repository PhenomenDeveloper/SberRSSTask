//
//  ReaderBaseVC.swift
//  SberRSSTask
//
//  Created by Lev Kolesnikov on 02.11.2020.
//

import UIKit

class ReaderBaseVC: UITabBarController {
    
    // MARK: - Свойства
    
    private var currentTabBarIndex: Int = 0
    
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        configureViewController()
        
    }
    
    // MARK: - Расстановка UI элементов
    /// Настраиваем все страницы Tab Bar на необходимые контроллеры представления
    private func configureViewController() {
        
        // TODO - Вставить новые VC
        
        setupTabBar()
    }
    
    /// Установка TabBar
    private func setupTabBar() {
        guard let tabItems = tabBar.items else { return }
        
        let numberOfItems = CGFloat(tabItems.count)
        let tabBarItemSize = CGSize(width: tabBar.frame.width / numberOfItems + 10, height: tabBar.frame.height + 34)
        
        tabBar.selectionIndicatorImage = UIImage.imageWithColor(color: ThemeManager.Color.sberColor, size: tabBarItemSize)
        
        tabBar.tintColor = .white
        tabBar.barTintColor = #colorLiteral(red: 0.9759238362, green: 0.9766622186, blue: 0.9760381579, alpha: 1)
        tabBar.isTranslucent = false
    }
    
    /// Настраивает контроллер навигации
    ///
    /// - Parameters:
    ///     - unselectedImage: Изображение которое представляет текущую страницу
    ///     - rootViewController: Родительский экран
    ///     - containerColor: Цвет контейнера, где лежат все элементы
    ///     - navTitle: Заголовок NavigationController
    ///     - tabBarTag: Порядковый номер в Tab Bar
    /// - Returns:
    ///     Созданный контроллер навигации
    private func constructNavController(unselectedImage: UIImage, rootViewController: UIViewController, containerColor: UIColor = #colorLiteral(red: 0.9529411765, green: 0.9529411765, blue: 0.9607843137, alpha: 1), navTitle: String, tabBarTag: Int) -> UINavigationController {
        
        // Создаем контроллер навигации с необходимыми настройками
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.image = unselectedImage
        navController.tabBarItem.title = navTitle
        navController.tabBarItem.tag = tabBarTag
        
        navController.navigationBar.tintColor = .black
        
        navController.viewControllers.first?.navigationItem.title = navTitle
        
        return navController
    }
}

extension ReaderBaseVC: UITabBarControllerDelegate {
    
}

