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
    
    @IBOutlet var label: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func didReceive(_ notification: UNNotification) {
        label?.text = notification.request.content.body
    }
}
