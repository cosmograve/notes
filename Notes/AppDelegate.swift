//
//  AppDelegate.swift
//  Notes
//
//  Created by Алексей Авер on 30.01.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    static var appDelegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = StartViewController()
        
        firstLaunch()
        return true
    }

    private func firstLaunch() {
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if launchedBefore  {
            print("launched before")
        } else {
            makeFirstNote()
            UserDefaults.standard.set(true, forKey: "launchedBefore")
        }
    }
    
    private func makeFirstNote() {
        let currentDate = Date()
        let firstNote = Note(text: "Ваша самая первая заметка", date: currentDate, imageData: nil)
        NoteManager.saveObject(firstNote)
        
    }
}

