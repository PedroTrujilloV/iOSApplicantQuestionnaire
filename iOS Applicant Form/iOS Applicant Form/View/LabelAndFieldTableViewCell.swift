//
//  LabelAndFieldTableViewCell.swift
//  iOS Applicant Form
//
//  Created by Pedro Trujillo on 6/19/20.
//  Copyright © 2020 Pedro Trujillo V. All rights reserved.
//

import UIKit
import SwiftUI
import Combine

class LabelAndFieldTableViewCell: UITableViewCell, UITextFieldDelegate {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var textField: UITextField!
    private var cancelable: AnyCancellable!
    @ObservedObject public var cellVM = CellViewModel()
    private var didChange = PassthroughSubject<String,Never>()
    
    static let reuseIdentifer = "LabelAndFieldTableViewCell"
    
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
            .sink(receiveValue: {[weak self] (outPutString) in
                self?.textField.text =  outPutString
                if (outPutString == "0"){
                    self?.textField.text = ""
                }
        })
        cellVM.textDidChange(sender: self.didChange.eraseToAnyPublisher())
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
        textField.placeholder = "0"
        textField.keyboardType = UIKeyboardType.numberPad
        textField.font = UIFont(name: "MuseoSans-500", size: 15)
        title.font = UIFont(name: "MuseoSans-500", size: 15)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textField.resignFirstResponder()
        return false
    }
    
    @IBAction func editingChanged(_ sender: UITextField) {
        cellVM.textDidChange(sender: self.didChange.eraseToAnyPublisher())
        print("LabelAndFieldTableViewCell IBAction editingChanged sender.text: \(String(describing: sender.text))")
    }
    
    @IBAction func editingDidEnd(_ sender: UITextField) {
        let validated = sender.text!.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")

        self.didChange.send(validated)
        cancelable = cellVM.$value
//            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self]  (outPutString) in
                self?.textField.text =  outPutString
                if (outPutString == "0"){
                    self?.textField.text = ""
                }
        })
    }
    @IBAction func editingDidBegin(_ sender: UITextField) {
        if (sender.text == "0"){
            self.textField.text = ""
        }
    }
    
}
