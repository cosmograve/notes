//
//  StartViewController.swift
//  Notes
//
//  Created by Алексей Авер on 30.01.2023.
//

import UIKit

class StartViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        initLabel()
        startAnimation()
    }
    
    private func initLabel() {
        titleLabel?.alpha = 0
        titleLabel?.font = UIFont.systemFont(ofSize: 60, weight: .bold)
        titleLabel?.textColor = .black
        titleLabel?.text = "ЗАМЕТКИ"
    }
    
    private func startAnimation() {
        UIView.animate(withDuration: 0.5) {
            self.titleLabel?.alpha = 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                UIView.animate(withDuration: 0.5) {
                    self.titleLabel?.alpha = 0
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.showNextVC()
                    }
                    
                }
            }
        }
    }
    
    private func showNextVC() {
        let main = MainViewController()
        let mainVC = BaseNavigationController(rootViewController: main)
        mainVC.modalTransitionStyle = .crossDissolve
        mainVC.modalPresentationStyle = .currentContext
        self.present(mainVC, animated: true)

    }
}

