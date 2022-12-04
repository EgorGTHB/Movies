import UIKit

final class MoviesTabBarController: UITabBarController {
 
     // MARK: - Private Properties
    private let bestFilmsViewController = UINavigationController(rootViewController: BestFilmsViewController())
    private let popFilmsViewController = UINavigationController(rootViewController: PopFilmsViewController())


    // MARK: - UITabBarController
    override func viewDidLoad() {
      super.viewDidLoad()
      setupView()
    }
    
    // MARK: - Private Methods
    private func setupView() {
      generateTabBar()
      setupSelfView()
    }
    
    private func generateTabBar() {
      viewControllers = [generateVC(viewController: bestFilmsViewController, title: "Лучшие фильмы", image: UIImage(systemName: "film"), tabBarTintColor: .black,                               tabBarUnselectedItemTintColor: .gray),
      generateVC(viewController: popFilmsViewController, title: "Популярные фильмы", image: UIImage(systemName: "heart"), tabBarTintColor: .black,                               tabBarUnselectedItemTintColor: .gray)]
    }
    
    private func setupSelfView() {
      let lineView = UIView(frame: CGRect(x: 0, y: 0, width: tabBar.frame.size.width, height: 0.3))
      lineView.backgroundColor = .darkGray
      selectedViewController = bestFilmsViewController
      tabBar.addSubview(lineView)
      tabBar.barTintColor = .white
      tabBar.isTranslucent = true
    }
    
  private func generateVC(viewController: UIViewController, title: String, image: UIImage?, tabBarTintColor: UIColor, tabBarUnselectedItemTintColor: UIColor) -> UIViewController {
      viewController.title = title
      viewController.tabBarItem.image = image
      tabBar.tintColor = tabBarTintColor
      tabBar.unselectedItemTintColor = tabBarUnselectedItemTintColor
      return viewController
    }
  }

