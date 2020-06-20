//
//  CellViewModel.swift
//  iOS Applicant Form
//
//  Created by Pedro Trujillo on 6/19/20.
//  Copyright © 2020 Pedro Trujillo V. All rights reserved.
//

import Foundation
import UIKit

struct CellViewModel:Codable, Hashable {
    
    let identifier = UUID()
        
    private var model:CellModel

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
                        return aCell
                    }
                    break;
                case .LabelAndFieldCellType:
                    if let aCell = tableView.dequeueReusableCell(withIdentifier: LabelAndFieldTableViewCell.reuseIdentifer, for: indexPath) as? LabelAndFieldTableViewCell {
                        aCell.title.text = self.title
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
    
    
    static func == (lhs: CellViewModel, rhs: CellViewModel) -> Bool {
        lhs.identifier == rhs.identifier
    }
    

}
