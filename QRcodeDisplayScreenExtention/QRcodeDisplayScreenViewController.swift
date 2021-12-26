//
//  ShareViewController.swift
//  QRcodeDisplayScreenExtention
//
//  Created by 原直也 on 2021/06/17.
//
import MobileCoreServices
import Social
import UIKit

class QRcodeDisplayScreenViewController: UIViewController {
    @IBOutlet var halfModalView: UIView!
    @IBOutlet var qRCodeImageView: UIImageView!
    @IBOutlet var urlLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveData()
        setUpView()
    }

    private func setUpView() {
        halfModalView.layer.cornerRadius = halfModalView.frame.size.width * 0.05
        halfModalView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

        qRCodeImageView.layer.cornerRadius = qRCodeImageView.frame.size.width * 0.05
        qRCodeImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
    }

    override func touchesBegan(_: Set<UITouch>, with _: UIEvent?) {
        extensionContext!.completeRequest(returningItems: nil, completionHandler: nil)
    }

    private func retrieveData() {
        guard let extensionItem: NSExtensionItem = extensionContext?.inputItems.first as? NSExtensionItem,
              let itemProviders = extensionItem.attachments?.first else { return }
        let puclicURL = String(kUTTypeURL)
        // shareExtension で NSURL を取得
        if itemProviders.hasItemConformingToTypeIdentifier(puclicURL) {
            itemProviders.loadItem(forTypeIdentifier: puclicURL, options: nil, completionHandler: { item, _ in
                if let url: NSURL = item as? NSURL {
                    self.urlAddToUserDefaults(url: url.absoluteString!)
                    // QRcodeに変換
                    // ----------
                    DispatchQueue.main.async {
                        self.qRCodeImageView.image = UIImage.makeQRCode(text: url.absoluteString!)
                        self.urlLabel.text = url.absoluteString
                    }
                }
            })
        }
    }

    private func urlAddToUserDefaults(url: String) {
        let userDefaults = UserDefaults(suiteName: ConstantList.groupName)
        var urlHistoryList = userDefaults?.array(forKey: ConstantList.urlHistoryList) as? [String] ?? []
        urlHistoryList.insert(url, at: 0)
        userDefaults?.set(urlHistoryList, forKey: ConstantList.urlHistoryList)
    }
}
