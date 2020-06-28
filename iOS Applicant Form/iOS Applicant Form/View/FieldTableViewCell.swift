//
//  FieldTableViewCell.swift
//  iOS Applicant Form
//
//  Created by Pedro Trujillo on 6/19/20.
//  Copyright © 2020 Pedro Trujillo V. All rights reserved.
//

import UIKit
import SwiftUI
import Combine

class FieldTableViewCell: UITableViewCell, UITextFieldDelegate {
    @IBOutlet weak var textField: UITextField!
    private var cancelable: AnyCancellable!
    @ObservedObject public var cellVM = CellViewModel()
    private var didChange = PassthroughSubject<String,Never>()

    static let reuseIdentifer = "FieldTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setup()
        setupBinding ()
    }
    
    func setViewModel(cellVM:CellViewModel) {
           self.cellVM = cellVM
    }
    
    func setupBinding (){
        cancelable = cellVM.$value
//            .receive(on: DispatchQueue.main)
            .assign(to: \.text!, on: textField)
    }
    
    deinit {
        self.cancle()
    }
    
    func cancle(){
        cancelable?.cancel()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    private func setup(){
        configureStyle()
    }
    private func configureStyle(){
        textField.font = UIFont(name: "MuseoSans-500", size: 15)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textField.resignFirstResponder()
        return false
    }
    @IBAction func editingChanged(_ sender: UITextField) {
        print("FieldTableViewCell IBAction editingChanged sender.text: \(String(describing: sender.text))")
    }
    @IBAction func editingDidEnd(_ sender: UITextField) {
        cellVM.textDidChange(sender: self.didChange.eraseToAnyPublisher())
        self.didChange.send(sender.text!)
        print("FieldTableViewCell IBAction editingDidEnd sender.text: \(String(describing: sender.text))")

    }
    
}
