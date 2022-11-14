//
//  AllowNotificationTutorialCell.swift
//  SliderApp
//
//  Created by Sun on 16/08/2022.
//

import UIKit
import Reusable

final class AllowNotificationTutorialCell: UICollectionViewCell, NibReusable {

    // MARK: - Outlet
    @IBOutlet private weak var imageView: UIImageView!
        
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    // MARK: - Data
    func setContent(data: UIImage?) {
        imageView.image = data
    }
}
