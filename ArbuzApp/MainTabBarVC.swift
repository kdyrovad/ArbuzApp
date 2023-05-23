//
//  MainTabBarVC.swift
//  ArbuzApp
//
//  Created by Дильяра Кдырова on 23.05.2023.
//

import UIKit

class MainTabBarVC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc1 = catalogueVC()
        let vc2 = UINavigationController(rootViewController: BasketViewController())
        
        vc1.tabBarItem.image = UIImage(systemName: "house")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 19, weight: .bold))
        vc2.tabBarItem.image = UIImage(systemName: "cart")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 19, weight: .bold))
        
        tabBar.tintColor = UIColor(hexString: "#2cbc34")
        
        setViewControllers([vc1, vc2], animated: true)
    }
    
    private func catalogueVC() -> UINavigationController {
        let presenter = CataloguePresenter()
        let vc = CatalogueViewController(presenter: presenter)
        presenter.view = vc
        return UINavigationController(rootViewController: vc)
    }
    
    static func createProductDetails(product: Product) -> ProductDetailsViewController {
        let viewController = ProductDetailsViewController(product: product)
        let presenter = ProductDetailsPresenter(view: viewController, product: product)
        viewController.presenter = presenter
        
        return viewController
    }
}


extension UIImage {
    func resizedToFill(size: CGSize) -> UIImage {
        let imageSize = self.size
        let targetSize = size

        let widthRatio = targetSize.width / imageSize.width
        let heightRatio = targetSize.height / imageSize.height
        let scaleFactor = max(widthRatio, heightRatio)

        let scaledSize = CGSize(width: imageSize.width * scaleFactor, height: imageSize.height * scaleFactor)

        UIGraphicsBeginImageContextWithOptions(targetSize, false, 0.0)
        draw(in: CGRect(origin: .zero, size: scaledSize))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return scaledImage ?? self
    }
}








