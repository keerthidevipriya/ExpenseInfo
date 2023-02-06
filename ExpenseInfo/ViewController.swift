//
//  ViewController.swift
//  ExpenseInfo
//
//  Created by Keerthi Devipriya(kdp) on 04/02/23.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var btn: UIButton = {
        let button = UIButton()
        button.setTitle("Go to Expense Functionality", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.setTitleColor(.black, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupAutoLayout()
    }
    
    func setupUI() {
        view.backgroundColor = .cyan
        btn.addTarget(self, action: #selector(gotoBtnTapped), for: .touchUpInside)
        view.addSubview(btn)
    }
    
    func setupAutoLayout() {
        NSLayoutConstraint.activate([
            btn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            btn.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            btn.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc func gotoBtnTapped() {
        let rootVC = ExpenseListVC()
        let navVc = UINavigationController(rootViewController: rootVC)
        navVc.modalPresentationStyle = .fullScreen
        present(navVc, animated: true)
    }
}
