//
//  NotificationContentData.swift
//  NotificationContent
//
//  Created by Work on 25/12/2022.
//

import Foundation

struct NotificationContentData: Codable {
    let bigPicture: BigPicture?

    enum CodingKeys: String, CodingKey {
        case bigPicture = "big_picture"
    }
}
