//
//  SharedHistoryPresenter.swift
//  URLsharer
//
//  Created by 原直也 on 2021/07/12.
//

import Foundation
import LinkPresentation
import RxSwift

protocol SharedHistoryPresenterInput {
    var linkMetadata: [LPLinkMetadata] { get }
    var linkMetadataTitle: String { get }
    func fetchURLMetadata()
}

protocol SharedHistoryPresenterOutput: AnyObject {
    func sharedHistoryTableViewReloadData()
}

final class SharedHistoryPresenter: SharedHistoryPresenterInput {
    private(set) var linkMetadata: [LPLinkMetadata] = []
    private(set) var linkMetadataTitle: String = ""

    private weak var view: SharedHistoryPresenterOutput!
    private let linkMetadataRepository: LinkMetadataRepository

    private let disposeBag = DisposeBag()

    init(
        view: SharedHistoryPresenterOutput,
        linkMetadataRepository: LinkMetadataRepository = FetchLinkMetadata()
    ) {
        self.view = view
        self.linkMetadataRepository = linkMetadataRepository
    }

    func fetchURLMetadata() {
        linkMetadataRepository.get().subscribe(onSuccess: { [weak self] linkmetadata in
            self?.linkMetadata = linkmetadata
            self?.view.sharedHistoryTableViewReloadData()
        })
            .disposed(by: disposeBag)
    }
}
