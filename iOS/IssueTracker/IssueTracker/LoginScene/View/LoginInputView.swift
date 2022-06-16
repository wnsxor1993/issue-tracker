//
//  LoginInputView.swift
//  IssueTracker
//
//  Created by juntaek.oh on 2022/06/14.
//

import UIKit

class LoginInputView: UIView {

    private let textFieldBackView: UIView = {
        let backView = UIView()
        backView.backgroundColor = .white
        backView.translatesAutoresizingMaskIntoConstraints = false

        return backView
    }()

    private let textFieldDividedLine: UIView = {
        let dividedLine = UIView()
        dividedLine.backgroundColor = .dividedLine
        dividedLine.translatesAutoresizingMaskIntoConstraints = false

        return dividedLine
    }()

    private let idLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.text = "아이디"
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let idTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 17, weight: .regular)
        textField.placeholder = "아이디를 입력해주세요"
        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }()

    private let pswLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.text = "비밀번호"
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let pswTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 17, weight: .regular)
        textField.placeholder = "비밀번호를 입력해주세요"
        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }()

    private lazy var loginButton: UIButton = {
        let button = getButtonAttributes()
        button.setTitle("로그인", for: .normal)

        return button
    }()

    private lazy var signupButton: UIButton = {
        let button = getButtonAttributes()
        button.setTitle("회원가입", for: .normal)

        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setViewConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
}

private extension LoginInputView {

    func getButtonAttributes() -> UIButton {
        let button = UIButton()
        button.setTitleColor(UIColor.logSignInButton, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.titleLabel?.textAlignment = .center
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }

    func setViewConstraints() {
        addSubViews(textFieldBackView, loginButton, signupButton)

        NSLayoutConstraint.activate([
            textFieldBackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            textFieldBackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            textFieldBackView.topAnchor.constraint(equalTo: self.topAnchor),
            textFieldBackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.6),

            loginButton.topAnchor.constraint(equalTo: textFieldBackView.bottomAnchor, constant: 32),
            loginButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            loginButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 96),
            loginButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 45),

            signupButton.topAnchor.constraint(equalTo: textFieldBackView.bottomAnchor, constant: 32),
            signupButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            signupButton.leadingAnchor.constraint(greaterThanOrEqualTo: loginButton.trailingAnchor, constant: 50),
            signupButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -96),
            signupButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 45)
        ])

        setBackViewConstraint()
    }

    func setBackViewConstraint() {
        self.textFieldBackView.addSubViews(idLabel, idTextField, textFieldDividedLine, pswLabel, pswTextField)

        NSLayoutConstraint.activate([
            textFieldDividedLine.centerYAnchor.constraint(equalTo: textFieldBackView.centerYAnchor),
            textFieldDividedLine.leadingAnchor.constraint(equalTo: textFieldBackView.leadingAnchor, constant: 20),
            textFieldDividedLine.trailingAnchor.constraint(equalTo: textFieldBackView.trailingAnchor),
            textFieldDividedLine.heightAnchor.constraint(equalToConstant: 1),

            idLabel.leadingAnchor.constraint(equalTo: textFieldBackView.leadingAnchor, constant: 20),
            idLabel.topAnchor.constraint(equalTo: textFieldBackView.topAnchor, constant: 11),
            idLabel.bottomAnchor.constraint(equalTo: textFieldDividedLine.topAnchor, constant: -10.5),
            idLabel.widthAnchor.constraint(equalToConstant: 60),

            idTextField.leadingAnchor.constraint(equalTo: idLabel.trailingAnchor, constant: 20),
            idTextField.trailingAnchor.constraint(equalTo: textFieldBackView.trailingAnchor),
            idTextField.topAnchor.constraint(equalTo: textFieldBackView.topAnchor, constant: 11),
            idTextField.bottomAnchor.constraint(equalTo: textFieldDividedLine.topAnchor, constant: -10.5),

            pswLabel.leadingAnchor.constraint(equalTo: textFieldBackView.leadingAnchor, constant: 20),
            pswLabel.topAnchor.constraint(equalTo: textFieldDividedLine.bottomAnchor, constant: 10.5),
            pswLabel.bottomAnchor.constraint(equalTo: textFieldBackView.bottomAnchor, constant: -10),
            pswLabel.widthAnchor.constraint(equalToConstant: 60),

            pswTextField.leadingAnchor.constraint(equalTo: pswLabel.trailingAnchor, constant: 20),
            pswTextField.trailingAnchor.constraint(equalTo: textFieldBackView.trailingAnchor),
            pswTextField.topAnchor.constraint(equalTo: textFieldDividedLine.bottomAnchor, constant: 10.5),
            pswTextField.bottomAnchor.constraint(equalTo: textFieldBackView.bottomAnchor, constant: -10)
        ])
    }
}
