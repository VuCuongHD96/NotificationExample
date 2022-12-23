//
//  BigPictureViewController.swift
//  NotificationContent
//
//  Created by Work on 24/12/2022.
//

import UIKit

final class BigPictureViewController: UIViewController, NotificationContentViewControllerType {

    // MARK: - Outlet
    @IBOutlet private weak var bigPictureImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var summaryLabel: UILabel!

    // MARK: - Property
    typealias NotificationContentDataType = BigPicture
    
    // MARK: - Property
    var notificationContentData: BigPicture!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        downloadImage()
    }
    
    // MARK: - View
    func setupView() {
        titleLabel.text = notificationContentData.title
        summaryLabel.text = notificationContentData.summary
    }
    
    // MARK: - Data
    func downloadImage() {
        guard let url = URL(string: notificationContentData.imageString) else { return }
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                self.bigPictureImageView.image = UIImage(data: data)
            }
        }
    }
}
