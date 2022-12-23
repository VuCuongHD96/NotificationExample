//
//  Aps.swift
//  NotificationContent
//
//  Created by Work on 25/12/2022.
//

import Foundation

struct Aps: Codable {
    let alert: Alert
    let category, sound: String
    let notificationContentData: NotificationContentData

    enum CodingKeys: String, CodingKey {
        case alert, category, sound
        case notificationContentData = "notification_content_data"
    }
}
