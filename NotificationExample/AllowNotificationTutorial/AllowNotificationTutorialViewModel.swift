//
//  AllowNotificationTutorialViewModel.swift
//
//
//  Created by Sun on 11/11/2022.
//

import UIKit

class AllowNotificationTutorialViewModel {
    
    let imageStringArray = [
        "https://farm66.staticflickr.com/65535/52491120992_f6f5bd462c_b.jpg",
        "https://farm66.staticflickr.com/65535/52492160528_0487c237df_b.jpg",
        "https://farm66.staticflickr.com/65535/52491891524_a8de307078_b.jpg",
        "https://farm66.staticflickr.com/65535/52492160583_237effc263_b.jpg",
    ]
    let group = DispatchGroup()
    var imageDataDictionary = [String: UIImage]()
    
    func showTutorial() {
            downloadAllImage()
            group.notify(queue: .main) {
                self.gotoTutorial()
            }
    }
    
    func gotoTutorial() {
        let viewController = AllowNotificationTutorialViewController()
        viewController.viewModel = self
        viewController.modalPresentationStyle = .overFullScreen
        if let topController = UIApplication.shared.keyWindow?.rootViewController {
            topController.present(viewController, animated: true, completion: nil)
        }
    }
    
    private func downloadAllImage() {
        imageStringArray.forEach { urlString in
            downloadImage(from: urlString)
        }
    }
    
    private func downloadImage(from URLString: String) {
        group.enter()
        guard let url = URL(string: URLString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                let image = UIImage(data: data)
                self.imageDataDictionary[URLString] = image
                self.group.leave()
            }
        }.resume()
    }
    
    func gotoSettingScreen() {
        if let appSettings = URL(string: UIApplication.openSettingsURLString),
           UIApplication.shared.canOpenURL(appSettings) {
            UIApplication.shared.open(appSettings)
        }
    }
}
