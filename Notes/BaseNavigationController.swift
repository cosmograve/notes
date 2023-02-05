//
//  BaseNavigationController.swift
//  Notes
//
//  Created by Алексей Авер on 30.01.2023.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
            
        let titleFont = UIFont.systemFont(ofSize: 17, weight: .semibold)
        let titleColor = UIColor.black
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: titleFont,
            .foregroundColor: titleColor
        ]
        
        if #available(iOS 13.0, *) {
            let standardAppearance = navigationBar.standardAppearance
            standardAppearance.titleTextAttributes = titleAttributes
            standardAppearance.backgroundColor = .white
            standardAppearance.backgroundEffect = nil
            standardAppearance.shadowColor = .black.withAlphaComponent(0.5)
            
            navigationBar.tintColor = .black
            navigationBar.standardAppearance = standardAppearance
            navigationBar.scrollEdgeAppearance = standardAppearance
        }
        else {
            navigationBar.backgroundColor = .white
            navigationBar.barTintColor = UIColor.white
            navigationBar.tintColor = .black
            navigationBar.isTranslucent = false
            navigationBar.titleTextAttributes = titleAttributes
            navigationBar.shadowImage = UIImage()
        }
    }
}
