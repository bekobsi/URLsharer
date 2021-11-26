//
//  SharedHistoryPresenter.swift
//  URLsharer
//
//  Created by 原直也 on 2021/07/12.
//

import Foundation

protocol SharedHistoryPresenterInput {
    var todo: [String] { get }
    func fetchURLMetadata()
}

protocol SharedHistoryPresenterOutput: AnyObject {
    func showURLMetadata()
}

final class SharedHistoryPresenter: SharedHistoryPresenterInput {
    private(set) var todo: [String] = []

    private weak var view: SharedHistoryPresenterOutput!

    init(view: SharedHistoryPresenterOutput) {
        self.view = view
    }

    func fetchURLMetadata() {
        todo = ["渋谷", "五反田", "新宿"]
    }
}
