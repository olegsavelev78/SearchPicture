import UIKit

public protocol AppTheme {
    func apply()
}

public struct MainTheme: AppTheme {
    public static var shared: AppTheme = MainTheme()

    public func apply() {
        self.configureNavBar()
        self.configureCollectionView()
    }

    func configureNavBar() {
        let navbar = UINavigationBar.appearance()
        navbar.isTranslucent = true
        navbar.isOpaque = false
        navbar.shadowImage = UIImage()
        navbar.barTintColor = .black
        navbar.tintColor = .black
        
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            appearance.titleTextAttributes = [
                .foregroundColor: UIColor.black,
                .font: UIFont.font(ofSize: 17, weight: .medium)
            ]
            navbar.standardAppearance = appearance
        }
    }

    func configureCollectionView() {
        UICollectionView.appearance().isPrefetchingEnabled = false
    }
}
