//
//  SharedHistoryViewController.swift
//  URLsharer
//
//  Created by 原直也 on 2021/06/16.
//

import UIKit

class SharedHistoryViewController: UIViewController {
    @IBOutlet var testImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let QRimage = generateQRCode(from: "https://github.com/el-hoshino/QuickshaRe")

        testImage.image = QRimage
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
