//
//  BigPictureViewController.swift
//  NotificationContent
//
//  Created by Work on 24/12/2022.
//

import UIKit

class BigPictureViewController: UIViewController, XibSceneBased {

    @IBOutlet private weak var bigPictureImageView: UIImageView!
    @IBOutlet private weak var summaryLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        downloadImage()
    }
    
    func downloadImage() {
        let url = URL(string: "https://www.invert.vn/media/downloads/221203T1328_631.jpg")
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                self.bigPictureImageView.image = UIImage(data: data!)
            }
        }
    }
}
