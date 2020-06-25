//
//  FormViewController.swift
//  iOS Applicant Form
//
//  Created by Pedro Trujillo on 6/17/20.
//  Copyright © 2020 Pedro Trujillo V. All rights reserved.
//

import UIKit
import Combine
import SwiftUI

class FormViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var submitButton: UIButton!
    @ObservedObject var formVM = FormViewModel()
    private var subscriptions = Set<AnyCancellable>()
    var dataSource: UITableViewDiffableDataSource<Section, CellViewModel>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
//        printFontFamilies()
    }
    
    func printFontFamilies(){
        for familyString in UIFont.familyNames {
            for fontName in UIFont.fontNames(forFamilyName: familyString) {
                print("\n> fontName: \(fontName)")
            }
        }
    }
    private func setup() {
        registerNibs()
        setupDataSource()
        loadPlistToSnapshot()
    }
    
    private func registerNibs() {
        self.tableView.register(UINib(nibName: FieldTableViewCell.reuseIdentifer, bundle: nil), forCellReuseIdentifier: FieldTableViewCell.reuseIdentifer)
        self.tableView.register(UINib(nibName: LabelAndFieldTableViewCell.reuseIdentifer, bundle: nil), forCellReuseIdentifier: LabelAndFieldTableViewCell.reuseIdentifer)
        self.tableView.register(UINib(nibName: ButtonTableViewCell.reuseIdentifer, bundle: nil), forCellReuseIdentifier: ButtonTableViewCell.reuseIdentifer)
    }

    @IBAction func submitButtonTouchUpAction(_ sender: Any) {
        
    }

}

extension FormViewController  {
    
    private func setupDataSource() {
        self.dataSource = UITableViewDiffableDataSource<Section, CellViewModel>(tableView: self.tableView, cellProvider: { (tableView, indexPath, cellVM) -> UITableViewCell? in
            return cellVM.cellFor(tableView: tableView, at: indexPath)
        })
    }
    
    private func loadPlistToSnapshot() {
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
                //print("cellVM: \(cellVM)")
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

extension FormViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        self
    }
    
}

