//
//  SharedHistoryViewController.swift
//  URLsharer
//
//  Created by 原直也 on 2021/06/16.
//

import UIKit

class SharedHistoryViewController: UIViewController {
    private var presenter: SharedHistoryPresenterInput!
    func inject(presenter: SharedHistoryPresenterInput) {
        self.presenter = presenter
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension SharedHistoryViewController: SharedHistoryPresenterOutput {}
