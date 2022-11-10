import UIKit

final class TabBarViewController: UIViewController {
    
    //MARK: - Private properties
    
    private let tabBar = UITabBarController()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
    }
    
    //MARK: - Private properties
    
    private func configureTabBar() {
        let mainVC    = UINavigationController(rootViewController: MainViewController())
        let historyVC = UINavigationController(rootViewController: HistoryViewController())
        let newVC     = UINavigationController(rootViewController: NewViewController())

        mainVC.title    = "Main"
        historyVC.title = "History"
        newVC.title     = "New"

        mainVC.tabBarItem.image    = UIImage(systemName: "list.bullet.clipboard.fill")
        historyVC.tabBarItem.image = UIImage(systemName: "clock")
        newVC.tabBarItem.image     = UIImage(systemName: "plus")

        tabBar.tabBar.tintColor               = .blueCustomColor
        tabBar.tabBar.unselectedItemTintColor = .white
        tabBar.modalPresentationStyle         = .fullScreen
        tabBar.tabBar.backgroundColor         = .tabBarCustomColor
        tabBar.setViewControllers([mainVC, newVC, historyVC], animated: true)

        present(tabBar, animated: true)
    }
}
