//
//  ShareViewController.swift
//  QRcodeDisplayScreenExtention
//
//  Created by 原直也 on 2021/06/17.
//

import MobileCoreServices
import Social
import UIKit

class QRcodeDisplayScreen: UIViewController {
    @IBOutlet var testImage: UIImageView!
    @IBOutlet var urlLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveData()
    }

    private func retrieveData() {
        let extensionItem: NSExtensionItem = extensionContext?.inputItems.first as! NSExtensionItem
        guard let itemProvider = extensionItem.attachments?.first else { return }

        let puclicURL = String(kUTTypeURL) // "public.url"
        print("puclicURL:", puclicURL)
        // shareExtension で NSURL を取得
        if itemProvider.hasItemConformingToTypeIdentifier(puclicURL) {
            itemProvider.loadItem(forTypeIdentifier: puclicURL, options: nil, completionHandler: { item, _ in
                // NSURLを取得する
                if let url: NSURL = item as? NSURL {
                    // ----------
                    // QRcodeに変換
                    // ----------
                    print("url", url.absoluteString!)
                    let QRimage = self.generateQRCode(from: url.absoluteString!)
                    self.testImage.image = QRimage!
                    self.urlLabel.text = url.absoluteString
                }
            })
        }
    }

    private func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        if let QRFilter = CIFilter(name: "CIQRCodeGenerator") {
            QRFilter.setValue(data, forKey: "inputMessage")
            guard let QRImage = QRFilter.outputImage else { return nil }
            return UIImage(ciImage: QRImage)
        }
        return nil
    }
}
