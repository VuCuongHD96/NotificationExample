//
//  NotificationViewController.swift
//  NotificationContent
//
//  Created by Work on 21/11/2022.
//

import UIKit
import UserNotifications
import UserNotificationsUI

final class NotificationViewController: UIViewController, UNNotificationContentExtension {
    
    // MARK: - Property
    var viewController: (any NotificationContentViewControllerType)!

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Notification
    func didReceive(_ notification: UNNotification) {
        guard let remoteNotification = JSONManager.decode(RemoteNotification.self, from: notification.request.content.userInfo) else {
            return
        }
        let aps = remoteNotification.aps
        let notificationContentData = aps.notificationContentData
        if let bigPictureData = notificationContentData.bigPicture {
            let bigPictureViewController = BigPictureViewController.instantiate()
            bigPictureViewController.notificationContentData = bigPictureData
            viewController = bigPictureViewController
        }
        viewController.view.frame = view.bounds
        view.addSubview(viewController.view)
    }
}
