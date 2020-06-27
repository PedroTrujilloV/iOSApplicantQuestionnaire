//
//  CellViewModel.swift
//  iOS Applicant Form
//
//  Created by Pedro Trujillo on 6/19/20.
//  Copyright © 2020 Pedro Trujillo V. All rights reserved.
//

import Foundation
import UIKit
import Combine
import SwiftUI

class CellViewModel: ObservableObject  {
    
    let identifier = UUID()
    private var cancelable = Set<AnyCancellable>()
    
    @ObservedObject private var fvm = FormViewModel()
    private var textFieldDidChange:AnyPublisher<String,Never> = PassthroughSubject<String,Never>().eraseToAnyPublisher()
    private var cellDidChange = PassthroughSubject<CellViewModel,Never>()
    
    private var model:CellModel
    @Published var value:String = ""  {
           didSet {
                fvm.cellDidChange(sender: cellDidChange.eraseToAnyPublisher())
               print("\n\n\n\n>>>>CellViewModel.value: \(String(describing: self.value))")
           }
       }

    init() {
        model = CellModel(type: "", title: "")
    }
    
    init(cellModel:CellModel) {
        model = cellModel
    }
    
    deinit {
        self.cancle()
    }
    
    var title:String {
        return model.title
    }
    
    public func textDidChange(sender:AnyPublisher<String,Never>){
        self.textFieldDidChange = sender
        self.textFieldDidChange.setFailureType(to: Error.self)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (completion) in
            }) {[weak self] output in
                self?.value = output
        }.store(in: &cancelable)
        self.cellDidChange.send(self) // keep the send here to avoid a Publisher subscriber retained cycle

    }
    
    var  titleForCellType:String {
        switch model.type {
        case FormCellType.FieldCellType.rawValue:
            return model.title.uppercased()
        case FormCellType.LabelAndFieldCellType.rawValue:
            return model.title.capitalized
        case FormCellType.ButtonCellStype.rawValue:
            return model.title.capitalized
        default:
            return model.title
        }
    }

    
    var type:FormCellType {
        switch model.type {
        case FormCellType.FieldCellType.rawValue:
            return .FieldCellType
        case FormCellType.LabelAndFieldCellType.rawValue:
            return .LabelAndFieldCellType
        case FormCellType.ButtonCellStype.rawValue:
            return .ButtonCellStype
        default:
            return .BlankCellStype
        }
    }
    
    func cellFor(tableView:UITableView, at indexPath:IndexPath) -> UITableViewCell {
        switch self.type {
                case .FieldCellType:
                    if let aCell = tableView.dequeueReusableCell(withIdentifier: FieldTableViewCell.reuseIdentifer, for: indexPath) as? FieldTableViewCell {
                        aCell.textField.placeholder = self.titleForCellType
                        aCell.textField.text = self.value
//                       cancelable = fvm.getFieldInfo(for: self.title)?
//                        .assign(to: \.text!, on: aCell.textField).self
                        aCell.setViewModel(cellVM: self)
                        return aCell
                    }
                    break;
                case .LabelAndFieldCellType:
                    if let aCell = tableView.dequeueReusableCell(withIdentifier: LabelAndFieldTableViewCell.reuseIdentifer, for: indexPath) as? LabelAndFieldTableViewCell {
                        aCell.title.text = self.title
                        aCell.textField.text = self.value
//                        cancelable = fvm.getFieldInfo(for: self.title)?
//                        .assign(to: \.text!, on: aCell.textField).self
                        aCell.setViewModel(cellVM: self)
                        return aCell
                    }
                    break;
                case .ButtonCellStype:
                    if let aCell = tableView.dequeueReusableCell(withIdentifier: ButtonTableViewCell.reuseIdentifer, for: indexPath) as? ButtonTableViewCell {
                        aCell.button.setTitle(self.titleForCellType, for: .normal)
                        aCell.setViewModel(cellVM: self)
                        return aCell
                }
                break;
            case .BlankCellStype:
                return UITableViewCell()
            }
         return UITableViewCell()
    }
    
    
    func makeBinding(with formVM:FormViewModel) {
        self.fvm = formVM
        fvm.getFieldInfo(for: self.title)?
            .assign(to: \.value, on: self)
        .store(in: &cancelable)
    }
    
    func cancle(){
      var canceled: [()] = cancelable.map{ $0.cancel()}
    }
    
    
    

}
extension CellViewModel: Hashable {
    
    static func == (lhs: CellViewModel, rhs: CellViewModel) -> Bool {
        lhs.identifier == rhs.identifier
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self).hashValue)
    }
    
}
