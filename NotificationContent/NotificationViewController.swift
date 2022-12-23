//
//  NotificationViewController.swift
//  NotificationContent
//
//  Created by Work on 21/11/2022.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        preferredContentSize.height = .infinity
    }
    
     func didReceive(_ notification: UNNotification) {
        let viewController = BigPictureViewController.instantiate()
//         if let subview = viewController.view {
//             subview.frame = view.frame
//             view.addSubview(subview)
//         }
         addChild(viewController)
         viewController.view.frame = view.bounds
         view.addSubview(viewController.view)
         didMove(toParent: self)
    }
}
