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
    
    private var cancelable:AnyCancellable?
        
    private var model:CellModel
    @Published var value:String = ""

    init(cellModel:CellModel) {
        model = cellModel
    }
    
    var title:String {
        return model.title
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
                        return aCell
                    }
                    break;
                case .LabelAndFieldCellType:
                    if let aCell = tableView.dequeueReusableCell(withIdentifier: LabelAndFieldTableViewCell.reuseIdentifer, for: indexPath) as? LabelAndFieldTableViewCell {
                        aCell.title.text = self.title
                        aCell.textField.text = self.value
                        return aCell
                    }
                    break;
                case .ButtonCellStype:
                    if let aCell = tableView.dequeueReusableCell(withIdentifier: ButtonTableViewCell.reuseIdentifer, for: indexPath) as? ButtonTableViewCell {
                        aCell.button.setTitle(self.titleForCellType, for: .normal)
                        return aCell
                }
                break;
            case .BlankCellStype:
                return UITableViewCell()
            }
         return UITableViewCell()
    }
    
    
    func makeBinding(with formVM:FormViewModel) {
        cancelable = formVM.formFieldInfoFrom(title: self.title)?
            .assign(to: \.value, on: self).self
        print("\n\n\n\n>>> cancelable: \(String(describing: cancelable))")
        print("\n\n\n\n>>> value: \(String(describing: self.value))")

    }
    
    func cancle(){
        cancelable?.cancel()
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
