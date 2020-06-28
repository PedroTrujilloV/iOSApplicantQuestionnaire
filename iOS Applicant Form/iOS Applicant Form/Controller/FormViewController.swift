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
    private var cancelables = Set<AnyCancellable>()
    var dataSource: UITableViewDiffableDataSource<Section, CellViewModel>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    deinit {
        self.cancel()
    }
    
    func cancel(){
        _ = cancelables.map{$0.cancel()}
    }

    private func setup() {
        registerNibs()
        setupDataSource()
        loadPlistToSnapshot()
        tableView.keyboardDismissMode = .interactive
    }
    
    private func registerNibs() {
        self.tableView.register(UINib(nibName: FieldTableViewCell.reuseIdentifer, bundle: nil), forCellReuseIdentifier: FieldTableViewCell.reuseIdentifer)
        self.tableView.register(UINib(nibName: LabelAndFieldTableViewCell.reuseIdentifer, bundle: nil), forCellReuseIdentifier: LabelAndFieldTableViewCell.reuseIdentifer)
        self.tableView.register(UINib(nibName: ButtonTableViewCell.reuseIdentifer, bundle: nil), forCellReuseIdentifier: ButtonTableViewCell.reuseIdentifer)
    }

    @IBAction func submitButtonTouchUpAction(_ sender: Any) {
        self.formVM.submit()
        self.tableView.reloadData()
        print("\n\n\n\n>>> Saved")
    }

}


