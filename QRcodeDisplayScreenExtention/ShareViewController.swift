//
//  ShareViewController.swift
//  QRcodeDisplayScreenExtention
//
//  Created by 原直也 on 2021/06/17.
//

import MobileCoreServices
import Social
import UIKit


class ShareViewController: UIViewController {
    @IBOutlet var testImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let extensionItem: NSExtensionItem = extensionContext?.inputItems.first as! NSExtensionItem
        let itemProvider = extensionItem.attachments?.first as! NSItemProvider

        let puclicURL = String(kUTTypeURL) // "public.url"
        print("puclicURL:", puclicURL)
        // shareExtension で NSURL を取得
        if itemProvider.hasItemConformingToTypeIdentifier(puclicURL) {
            itemProvider.loadItem(forTypeIdentifier: puclicURL, options: nil, completionHandler: { item, _ in
                // NSURLを取得する
                if let url: NSURL = item as? NSURL {
                    // ----------
                    // 保存処理
                    // ----------
                    print("url", url.absoluteString!)
                    let QRimage = self.generateQRCode(from: url.absoluteString!)
                    self.testImage.image = QRimage
                }
            })
        }

//        let QRimage = generateQRCode(from: "https://github.com/el-hoshino/QuickshaRe")
    }

    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        if let QRFilter = CIFilter(name: "CIQRCodeGenerator") {
            QRFilter.setValue(data, forKey: "inputMessage")
            guard let QRImage = QRFilter.outputImage else { return nil }
            return UIImage(ciImage: QRImage)
        }
        return nil
    }
}
