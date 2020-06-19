//
//  FormViewController.swift
//  iOS Applicant Form
//
//  Created by Pedro Trujillo on 6/17/20.
//  Copyright © 2020 Pedro Trujillo V. All rights reserved.
//

import UIKit

class FormViewController: UIViewController {

    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var projectRepoTextField: UITextField!
    @IBOutlet weak var projectURLTextField: UITextField!
    @IBOutlet weak var bpOOPTextField: UITextField!
    @IBOutlet weak var modularDevTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
    }
    private func setup() {
        setupFont()
    }
    
    private func setupFont(){
//        fullNameTextField.font = UIFont(name: "MuseoSans_500", size: 12)
    }

    @IBAction func submitButtonTouchUpAction(_ sender: Any) {
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
