import UserNotifications

class NotificationService: UNNotificationServiceExtension {
    
    struct Constant {
        static let mediaUrlKey = "mediaUrl"
    }
    
    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?
    let fileManager = FileManager.default
    
    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        
        self.contentHandler = contentHandler
        bestAttemptContent = request.content.mutableCopy() as? UNMutableNotificationContent
        let userInfo = request.content.userInfo
        
        if let mediaUrl = userInfo[Constant.mediaUrlKey] as? String {
            loadAttachment(urlString: mediaUrl) { [self] attachment in
                bestAttemptContent?.attachments = [attachment]
                self.contentHandler?(bestAttemptContent!)
            }
        }
    }
    
    func loadAttachment(urlString: String, completionHandler: @escaping (UNNotificationAttachment) -> Void) {
        var attachment: UNNotificationAttachment!
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: URLSessionConfiguration.default)
        session.downloadTask(with: url) { temporaryFileLocation, response, error in
            guard let temporaryFileLocation = temporaryFileLocation else { return }
            let fileExtension = self.fileExtension(urlString: urlString)
            let localURL = URL(fileURLWithPath: (temporaryFileLocation.path) + fileExtension)
            try? self.fileManager.moveItem(at: temporaryFileLocation, to: localURL)
            attachment = try? UNNotificationAttachment(identifier: "", url: localURL, options: nil)
            completionHandler(attachment)
        }.resume()
    }
    
    func fileExtension(urlString: String) -> String {
        if let lastDot = urlString.lastIndex(of: ".") {
            let extensionPath = urlString[lastDot...]
            return String(extensionPath)
        } else {
            return ""
        }
    }
}
