//
//  SuccessViewController.swift
//  ArbuzApp
//
//  Created by Дильяра Кдырова on 22.05.2023.
//

import UIKit

class SuccessViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureConstraints()
    }
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "Ваш заказ успешно создан:)"
        label.font = .boldSystemFont(ofSize: 22)
        return label
    }()
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("На главную", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor(hexString: "#2cbc34")
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont(name: "SF Pro Text", size: 17)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17.0)
        button.addTarget(self, action: #selector(goHome), for: .touchUpInside)
        return button
    }()
    
    func configureUI() {
        view.backgroundColor = .white
        button.addTarget(self, action: #selector(goHome), for: .touchUpInside)
        [label, button].forEach {
            view.addSubview($0)
        }
    }
    
    @objc private func goHome() {
        self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
    }
    
    func configureConstraints() {
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            button.heightAnchor.constraint(equalToConstant: 48)
        ])
    }

}
