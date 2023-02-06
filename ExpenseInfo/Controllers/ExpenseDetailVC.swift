//
//  ExpenseDetailVC.swift
//  ExpenseInfo
//
//  Created by Keerthi Devipriya(kdp) on 05/02/23.
//

import UIKit

protocol ExpenseDetailProtocol {
    func updateExpense(amount: String, index: Int)
}

class ExpenseDetailVC: UIViewController {
    
    var dataModel = ExpenseModel()
    var index: Int = 0
    var delegate: ExpenseDetailProtocol?
    
    lazy var expenseTypeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.textColor = .white
        return label
    }()
    
    lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .black
        label.textColor = .white
        return label
    }()
    
    lazy var updateAmtTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .black
        textField.placeholder = "Enter amount to update"
        textField.tintColor = .white
        return textField
    }()

    lazy var increaseBtn: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    lazy var decreaseBtn: UIButton = {
        let button = UIButton()
        button.setTitle("-", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    lazy var btnView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = dataModel.type
        setupUI()
        setupAutoLayout()
    }
    
    convenience init(dataModel: ExpenseModel, index: Int) {
        self.init()
        self.dataModel = dataModel
        self.index = index
    }
    
    func setupUI() {
        view.backgroundColor = .clear
        increaseBtn.addTarget(self, action: #selector(plusTapped), for: .touchUpInside)
        decreaseBtn.addTarget(self, action: #selector(minusTapped), for: .touchUpInside)
        
        expenseTypeLabel.text = "Expense type: " + dataModel.type
        amountLabel.text = "Amount: " + dataModel.amount
        
        view.addSubview(expenseTypeLabel)
        view.addSubview(amountLabel)
        btnView.addSubview(increaseBtn)
        btnView.addSubview(decreaseBtn)
        
        btnView.addSubview(updateAmtTextField)
        view.addSubview(btnView)
    }
    
    func setupAutoLayout() {
        NSLayoutConstraint.activate([
            expenseTypeLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            expenseTypeLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            expenseTypeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            expenseTypeLabel.heightAnchor.constraint(equalToConstant: 50),
            
            amountLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            amountLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            amountLabel.heightAnchor.constraint(equalToConstant: 50),
            amountLabel.topAnchor.constraint(equalTo: expenseTypeLabel.bottomAnchor, constant: 16),
            
            btnView.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 24),
            btnView.leftAnchor.constraint(equalTo: view.leftAnchor),
            btnView.rightAnchor.constraint(equalTo: view.rightAnchor),
            btnView.heightAnchor.constraint(equalToConstant: 60),
            btnView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            decreaseBtn.topAnchor.constraint(equalTo: btnView.topAnchor),
            decreaseBtn.widthAnchor.constraint(equalToConstant: 60),
            decreaseBtn.heightAnchor.constraint(equalToConstant: 50),
            decreaseBtn.leftAnchor.constraint(equalTo: btnView.leftAnchor, constant: 16),
            
            updateAmtTextField.leftAnchor.constraint(equalTo: decreaseBtn.rightAnchor, constant: 16),
            updateAmtTextField.heightAnchor.constraint(equalToConstant: 50),
            updateAmtTextField.topAnchor.constraint(equalTo: btnView.topAnchor),
            
            increaseBtn.topAnchor.constraint(equalTo: btnView.topAnchor),
            increaseBtn.widthAnchor.constraint(equalToConstant: 60),
            increaseBtn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            increaseBtn.heightAnchor.constraint(equalToConstant: 50),
            increaseBtn.leftAnchor.constraint(equalTo: updateAmtTextField.rightAnchor)
            
        ])
    }

}

extension ExpenseDetailVC {
    @objc func plusTapped() {
        let textFieldText = updateAmtTextField.text ?? ""
        let amount = dataModel.amount
        
        let updatedAmount = (Int(amount) ?? 0) + (Int(textFieldText) ?? 0)
        self.delegate?.updateExpense(amount: String(updatedAmount), index: index)
    }
    
    @objc func minusTapped() {
        let textFieldText = updateAmtTextField.text ?? "0"
        let amount = dataModel.amount
        
        let updatedAmount = (Int(amount) ?? 0) - (Int(textFieldText) ?? 0)
        self.delegate?.updateExpense(amount: String(updatedAmount), index: index)
    }
}
