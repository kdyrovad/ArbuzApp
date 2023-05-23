//
//  PurchaseDetailViewController.swift
//  ArbuzApp
//
//  Created by Дильяра Кдырова on 20.05.2023.
//

import UIKit

struct Screen {
    static let screenHeight = UIScreen.main.bounds.height
    static let screenWidth = UIScreen.main.bounds.width
}

class PurchaseDetailViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: - UI Components
    
    private var selectedButton: UIButton?
    
    lazy var adressLabel: UILabel = {
        let label = UILabel()
        label.text = "Адрес доставки"
        label.font = .boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var dataLabel: UILabel = {
        let label = UILabel()
        label.text = "Дата доставки"
        label.font = .boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var dueLabel: UILabel = {
        let label = UILabel()
        label.text = "Срок подписки"
        label.font = .boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private let dueScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isUserInteractionEnabled = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let dueStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    lazy var userLabel: UILabel = {
        let label = UILabel()
        label.text = "Контактная информация"
        label.font = .boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isUserInteractionEnabled = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Подтвердить заказ", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor(hexString: "#2cbc34")
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont(name: "SF Pro Text", size: 17)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17.0)
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var addressTextField = BasicTextField(placeholder: "Название улицы")
    lazy var homeTextField = BasicTextField(placeholder: "Номер дома")
    lazy var flatNumberTextField = BasicTextField(placeholder: "№ квартиры")
    lazy var homeNumTextField = BasicTextField(placeholder: "Подъезд")
    lazy var clientNameTextField = BasicTextField(placeholder: "Ваше имя")
    lazy var phoneTextField = BasicTextField(placeholder: "Введите номер телефона")
    let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    
    //MARK: - Init

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
        configureConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = .white
        navigationItem.title = "Оформление заказа"
    }
    
    //MARK: - Methods
    
    private func configureUI() {
        setUpDatePicker()
        view.backgroundColor = .white
        phoneTextField.delegate = self
        
        scrollView.addSubview(stackView)
        [addressTextField, adressLabel, homeTextField, flatNumberTextField, homeNumTextField, scrollView, clientNameTextField, phoneTextField, dataLabel, nextButton, userLabel, dueLabel, datePicker].forEach {
            $0.isUserInteractionEnabled = true
            view.addSubview($0)
        }
        createButtonsForUpcomingWeek()
        scrollView.contentSize = view.bounds.size
    }
    
    private func setUpDatePicker() {
        datePicker.locale = Locale(identifier: "ru")
        datePicker.backgroundColor = UIColor(hexString: "#eef9f1")
        
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .compact
        datePicker.tintColor = UIColor(hexString: "#6eb76e")
        datePicker.setValue(UIColor.green, forKeyPath: "textColor")
    }
    
    @objc func nextButtonTapped() {
        if isValid() {
            let vc = SuccessViewController()
            present(vc, animated: true)
        }
    }
    
    private func createButtonsForUpcomingWeek() {
        let calendar = Calendar.current
        var currentDate = calendar.startOfDay(for: Date())
        
        for _ in 1...5 {
            let button = UIButton(type: .custom)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle(formatDate(currentDate), for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.setTitleColor(UIColor(hexString: "#6eb76e"), for: .selected)
            button.backgroundColor = UIColor(hexString: "#eef9f1")
            button.titleLabel?.adjustsFontSizeToFitWidth = true
            button.titleLabel?.minimumScaleFactor = 0.5
            button.titleLabel?.lineBreakMode = .byTruncatingTail
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            button.layer.cornerRadius = 10
            button.isUserInteractionEnabled = true
            button.isEnabled = true
            
            stackView.addArrangedSubview(button)
            NSLayoutConstraint.activate([
                button.widthAnchor.constraint(equalToConstant: 100),
                button.heightAnchor.constraint(equalToConstant: 40)
            ])
            
            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
        }
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        stackView.arrangedSubviews.forEach { button in
            button.backgroundColor = UIColor(hexString: "#fcfcfc")
        }
        
        if sender != selectedButton {
            selectedButton?.isSelected = false
            sender.backgroundColor = UIColor(hexString: "#eef9f3")
            selectedButton = sender
            selectedButton?.isSelected = true
            sender.isHighlighted = false
            
            if let title = sender.title(for: .normal) {
                print("Button tapped: \(title)")
            }
        }
    }
    
    private func isValid() -> Bool {
        var valid = true
        [addressTextField.text, homeTextField.text, clientNameTextField.text, phoneTextField.text].forEach {
            if ($0 ?? "").isEmpty {
                showAlert(with: "Введите все поля")
                valid = false
            }
        }
        if !valid { return false }
        if !validateField(string: addressTextField.text ?? "") {
            showAlert(with: "Поле улицы должно содержать только буквы.")
            return false
        }
        if !validateField(string: clientNameTextField.text ?? "") {
            showAlert(with: "Имя должно содержать только буквы.")
            return false
        }
        
        guard let homeNumText = homeNumTextField.text, let _ = Int(homeNumText.trimmingCharacters(in: .whitespacesAndNewlines)) else {
            showAlert(with: "Номер дома должен содержать только цифры.")
            return false
        }
        
        guard let homeNumText = homeTextField.text, let _ = Int(homeNumText.trimmingCharacters(in: .whitespacesAndNewlines)) else {
            showAlert(with: "Поле подъезда должен содержать только цифры.")
            return false
        }
        
        guard let homeNumText = flatNumberTextField.text, let _ = Int(homeNumText.trimmingCharacters(in: .whitespacesAndNewlines)) else {
            showAlert(with: "Поле номера квартиры должен содержать только цифры.")
            return false
        }
        
        return true
    }
    
    private func validateField(string: String) -> Bool {
        let validationFormat = "[а-яА-Я\\s]+"
        let fieldPredicate = NSPredicate(format:"SELF MATCHES %@", validationFormat)
        return fieldPredicate.evaluate(with: string)
    }
    
    private func validateFieldNumber(num: Int) -> Bool {
        let validationFormat = "[0-9]"
        let fieldPredicate = NSPredicate(format:"SELF MATCHES %@", validationFormat)
        return fieldPredicate.evaluate(with: num)
    }
    
    private func setPhoneNumberMask(textField: UITextField, mask: String, string: String, range: NSRange) -> String {
        let text = textField.text ?? ""
        
        let phone = (text as NSString).replacingCharacters(in: range, with: string)
        let number = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = number.startIndex
        
        for character in mask where index < number.endIndex {
            if character == "X" {
                result.append(number[index])
                index = number.index(after: index)
            } else {
                result.append(character)
            }
        }
        
        return result
    }
    
    // MARK: - Helper Method
    
    private func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM"
        return dateFormatter.string(from: date)
    }
    
    //MARK: - Constraints
    
    private func configureConstraints() {
        let layout = view.safeAreaLayoutGuide
        adressLabel.translatesAutoresizingMaskIntoConstraints = false
        adressLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        adressLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
            
        addressTextField.translatesAutoresizingMaskIntoConstraints = false
        addressTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        addressTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
        addressTextField.topAnchor.constraint(equalTo: adressLabel.bottomAnchor, constant: 20).isActive = true
        addressTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true

        homeTextField.translatesAutoresizingMaskIntoConstraints = false
        homeTextField.widthAnchor.constraint(equalToConstant: 100).isActive = true
        homeTextField.heightAnchor.constraint(equalToConstant: 48).isActive = true
        homeTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        homeTextField.topAnchor.constraint(equalTo: addressTextField.bottomAnchor, constant: 20).isActive = true

        homeNumTextField.translatesAutoresizingMaskIntoConstraints = false
        homeNumTextField.widthAnchor.constraint(equalToConstant: Screen.screenWidth / 3.3).isActive = true
        homeNumTextField.heightAnchor.constraint(equalToConstant: 48).isActive = true
        homeNumTextField.leftAnchor.constraint(equalTo: homeTextField.rightAnchor, constant: 8).isActive = true
        homeNumTextField.topAnchor.constraint(equalTo: addressTextField.bottomAnchor, constant: 20).isActive = true

        flatNumberTextField.translatesAutoresizingMaskIntoConstraints = false
        flatNumberTextField.topAnchor.constraint(equalTo: addressTextField.bottomAnchor, constant: 20).isActive = true
        flatNumberTextField.heightAnchor.constraint(equalToConstant: 48).isActive = true
        flatNumberTextField.leftAnchor.constraint(equalTo: homeNumTextField.rightAnchor, constant: 8).isActive = true
        flatNumberTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true

        dataLabel.translatesAutoresizingMaskIntoConstraints = false
        dataLabel.topAnchor.constraint(equalTo: flatNumberTextField.bottomAnchor, constant: 20).isActive = true
        dataLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true


        scrollView.topAnchor.constraint(equalTo: dataLabel.bottomAnchor, constant: 20).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true

        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
        
        dueLabel.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 20).isActive = true
        dueLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.topAnchor.constraint(equalTo: dueLabel.bottomAnchor, constant: 20).isActive = true
        datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        
        userLabel.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 20).isActive = true
        userLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true

        clientNameTextField.translatesAutoresizingMaskIntoConstraints = false
        clientNameTextField.heightAnchor.constraint(equalToConstant: 48).isActive = true
        clientNameTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        clientNameTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
        clientNameTextField.topAnchor.constraint(equalTo: userLabel.bottomAnchor, constant: 20).isActive = true

        phoneTextField.translatesAutoresizingMaskIntoConstraints = false
        phoneTextField.heightAnchor.constraint(equalToConstant: 48).isActive = true
        phoneTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        phoneTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
        phoneTextField.topAnchor.constraint(equalTo: clientNameTextField.bottomAnchor, constant: 20).isActive = true

        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        nextButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
        nextButton.bottomAnchor.constraint(equalTo: layout.bottomAnchor, constant: -40).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
}

//MARK: - UITextFieldDelegate

extension PurchaseDetailViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField {
        case phoneTextField:
            phoneTextField.text = setPhoneNumberMask(textField: phoneTextField, mask: "+X (XXX) XXX-XX-XX", string: string, range: range)
        default:
            break
        }
        return false
    }
}

//MARK: - UIViewController extension

extension UIViewController {
    func showAlert(with text: String, message: String = "") {
        let alert = UIAlertController(title: text, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Хорошо", style: .default, handler: nil)
        action.setValue(UIColor(hexString: "#2cbc34"), forKey: "titleTextColor")
        
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
    }
}

