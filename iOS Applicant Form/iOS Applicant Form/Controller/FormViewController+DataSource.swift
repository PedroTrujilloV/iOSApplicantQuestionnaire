//
//  FormViewController+DataSource.swift
//  iOS Applicant Form
//
//  Created by Pedro Trujillo on 6/27/20.
//  Copyright © 2020 Pedro Trujillo V. All rights reserved.
//

import Foundation
import UIKit
import Combine
import SwiftUI

// MARK: FormViewController Data Source

extension FormViewController  {
    
    func setupDataSource() {
        self.dataSource = UITableViewDiffableDataSource<Section, CellViewModel>(tableView: self.tableView, cellProvider: { (tableView, indexPath, cellVM) -> UITableViewCell? in
            let cell = cellVM.cellFor(tableView: tableView, at: indexPath)
            return cell
        })
    }
    
    func loadPlistToSnapshot() {
        if let url = Bundle.main.url(forResource: "form", withExtension: "plist") {
            do {
                var cellVMs: [CellViewModel] = []
                if let data =  try? Data(contentsOf: url) {
                    let decoder = PropertyListDecoder()
                    cellVMs = try decoder.decode([CellModel].self, from: data)
                        .map({ (cellM) -> CellViewModel in
                            let aCellVM = CellViewModel(cellModel: cellM)
                            aCellVM.makeBinding(with: formVM)
                            return aCellVM
                        })
                }
                snapshotForCurrentState(cells: cellVMs)
            } catch {
                print("FormViewController.loadPlist(): problem \(error)")
            }
        }
    }
    
    private func snapshotForCurrentState(cells:[CellViewModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, CellViewModel>()
        snapshot.appendSections([.Form])
        snapshot.appendItems(cells)
        self.dataSource.apply(snapshot,animatingDifferences: true)
    }
}
