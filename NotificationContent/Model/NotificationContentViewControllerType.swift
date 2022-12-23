//
//  NotificationContentViewControllerType.swift
//  NotificationContent
//
//  Created by Work on 24/12/2022.
//

import UIKit

protocol NotificationContentViewControllerType: XibSceneBased {
    associatedtype NotificationContentDataType
    var notificationContentData: NotificationContentDataType! { get set }
}
