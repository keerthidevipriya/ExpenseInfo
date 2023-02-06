//
//  ExpenseInputVC.swift
//  ExpenseInfo
//
//  Created by Keerthi Devipriya(kdp) on 05/02/23.
//

import UIKit

protocol ExpenseProtocol {
    func saveExpenseData(expType: String, amount: String)
}

class ExpenseInputVC: UIViewController {
    
    var dataModel = [ExpenseModel]()
    var delegate: ExpenseProtocol?
    
    lazy var expenseTypeTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .black
        textField.placeholder = "Enter expense Type"
        textField.tintColor = .white
        return textField
    }()
    
    lazy var amountTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .black
        textField.placeholder = "Enter amount"
        textField.keyboardType = .numberPad
        textField.tintColor = .white
        return textField
    }()

    lazy var btn: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupAutoLayout()
    }
    
    func setupUI() {
        view.backgroundColor = .clear
        btn.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        view.addSubview(expenseTypeTextField)
        view.addSubview(amountTextField)
        view.addSubview(btn)
    }
    
    func setupAutoLayout() {
        NSLayoutConstraint.activate([
            expenseTypeTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            expenseTypeTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            expenseTypeTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            expenseTypeTextField.heightAnchor.constraint(equalToConstant: 50),
            
            amountTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            amountTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            amountTextField.heightAnchor.constraint(equalToConstant: 50),
            amountTextField.topAnchor.constraint(equalTo: expenseTypeTextField.bottomAnchor, constant: 16),
            
            btn.topAnchor.constraint(equalTo: amountTextField.bottomAnchor, constant: 24),
            btn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            btn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            btn.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
    
    @objc func saveTapped() {
        if !(expenseTypeTextField.text?.isEmpty ?? true),
           !(amountTextField.text?.isEmpty ?? true) {
            self.delegate?.saveExpenseData(expType: expenseTypeTextField.text ?? "", amount: amountTextField.text ?? "")
        }
    }
}
