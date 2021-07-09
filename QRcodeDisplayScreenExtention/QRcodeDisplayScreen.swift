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
        let leftBarButton = UIBarButtonItem(title: "戻る", style: .plain, target: self, action: #selector(tappedLeftBarButton))
        navigationItem.leftBarButtonItem = leftBarButton
    }

    @objc func tappedLeftBarButton() {
        extensionContext!.completeRequest(returningItems: nil, completionHandler: nil)
    }

    private func retrieveData() {
        guard let extensionItem: NSExtensionItem = extensionContext?.inputItems.first as? NSExtensionItem,
              let itemProviders = extensionItem.attachments?.first else { return }
        let puclicURL = String(kUTTypeURL)
        print("puclicURL:", puclicURL)
        // shareExtension で NSURL を取得
        if itemProviders.hasItemConformingToTypeIdentifier(puclicURL) {
            itemProviders.loadItem(forTypeIdentifier: puclicURL, options: nil, completionHandler: { item, _ in
                if let url: NSURL = item as? NSURL {
                    // QRcodeに変換
                    // ----------
                    let QRimage = self.generateQRCode(from: url.absoluteString ?? "")
                    DispatchQueue.main.async {
                        self.testImage.image = QRimage
                        self.urlLabel.text = url.absoluteString
                    }
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
