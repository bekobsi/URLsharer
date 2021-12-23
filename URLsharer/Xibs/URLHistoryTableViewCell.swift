//
//  URLHistoryTableVIewCell.swift
//  URLsharer
//
//  Created by 原直也 on 2021/11/10.
//

import LinkPresentation
import MobileCoreServices
import UIKit

class URLHistoryTableViewCell: UITableViewCell {
    @IBOutlet var siteTitleTextView: UITextView!
    @IBOutlet var siteThumbnailImageProvider: UIImageView!

    let contentType = kUTTypeImage as String
    var siteThumbnail: UIImage?
    var siteMetadataInfo: LPLinkMetadata? {
        didSet {
            siteMetadataInfo?.imageProvider?.loadItem(forTypeIdentifier: contentType, options: nil) { data, _ in
                self.siteThumbnail = UIImage(data: data as! Data)
                DispatchQueue.main.async { [weak self] in
                    self?.siteTitleTextView.text = self?.siteMetadataInfo?.title
                    self?.siteThumbnailImageProvider.image = self?.siteThumbnail
                }
            }
        }
    }
}
