//
//  ExpenseListVC.swift
//  ExpenseInfo
//
//  Created by Keerthi Devipriya(kdp) on 04/02/23.
//

import UIKit

class ExpenseListVC: UIViewController {
    
    static let reuseIdentifier = "UITableViewCell"

    var dataModel = [ExpenseModel]()
    
    lazy var btn: UIButton = {
        let button = UIButton()
        button.setTitle("Push to next VC", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .singleLine
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let ele = ExpenseModel(type: "TestExpense", amount: "10000")
        dataModel.append(ele)
        title = "Expenses"
        setupUI()
        setupTableView()
        setupAutoLayout()
        setupNavigation()
    }
    
    func setupUI() {
        view.backgroundColor = .clear
        view.addSubview(tableView)
    }
    
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: ExpenseListVC.reuseIdentifier)
    }
    
    func setupAutoLayout() {
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension ExpenseListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: ExpenseListVC.reuseIdentifier, for: indexPath)
        if cell.detailTextLabel == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: ExpenseListVC.reuseIdentifier)
        }
        cell.textLabel?.text = dataModel[indexPath.row].type
        cell.detailTextLabel?.text = dataModel[indexPath.row].amount
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = dataModel[indexPath.row]
        navigateToExpenseDetailVC(item, index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            dataModel.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            navigateToAddExpense()
        }
    }
}

extension ExpenseListVC {
    func setupNavigation() {
        navigationController?.navigationBar.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(navigateToAddExpense))
    }
}

extension ExpenseListVC {
    
    func navigateToExpenseDetailVC(_ dataModel: ExpenseModel, index: Int) {
        let vc = ExpenseDetailVC(dataModel: dataModel, index: index)
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func gotoBtnTapped() {
        let rootVC = UIViewController()
        rootVC.view.backgroundColor = .white
        navigationController?.pushViewController(rootVC, animated: true)
    }
    
    @objc func navigateToAddExpense() {
        let vc = ExpenseInputVC()
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ExpenseListVC: ExpenseProtocol {
    func saveExpenseData(expType: String, amount: String) {
        let ele = ExpenseModel(type: expType, amount: amount)
        dataModel.append(ele)
        tableView.reloadData()
    }
}

extension ExpenseListVC: ExpenseDetailProtocol {
    func updateExpense(amount: String, index: Int) {
        var expense = dataModel[index]
        expense.amount = amount
        dataModel[index] = expense
        tableView.reloadData()
    }
}
