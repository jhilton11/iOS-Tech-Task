//
//  LoginViewController.swift
//  MoneyBox
//
//  Created by Zeynep Kara on 16.01.2022.
//

import UIKit
import SnapKit
import Networking

class LoginViewController: UIViewController {
    // Design Login
    
    lazy var viewModel: LoginViewModel = {
        let provider = DataProvider()
        let viewModel = LoginViewModel(provider: provider)
        viewModel.delegate = self
        return viewModel
    }()
    
    lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Login"
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    lazy var emailTf: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = .white
        tf.textColor = .black
        tf.addBorder()
        tf.addLeftPadding(padding: 15)
        tf.placeholder = "Email"
        return tf
    }()
    
    lazy var passwordTf: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = .white
        tf.textColor = .black
        tf.isSecureTextEntry = true
        tf.addBorder()
        tf.addLeftPadding(padding: 15)
        tf.placeholder = "Password"
        return tf
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.center = view.center
        return indicator
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Colours.DeepGreyColour
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.addBorder()
        button.addTarget(self, action: #selector(login), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        navigationItem.title = "Login"
        view.backgroundColor = Colours.GreyColour
        setConstraints()
        viewModel.delegate = self
    }
    
    @objc private func login() {
//        guard !emailTf.text!.isEmpty else {
//            Utilities.createAlert(vc: self, title: "", message: "Email field is empty")
//            return
//        }
//        
//        guard !passwordTf.text!.isEmpty else {
//            Utilities.createAlert(vc: self, title: "", message: "Password field is empty")
//            return
//        }
//        
//        let email = emailTf.text!
//        let password = passwordTf.text!
//        activityIndicator.startAnimating()
//        viewModel.login(email: email, password: password)
        viewModel.login()
    }
    
    private func setConstraints() {
        let tfHeight = 44.0
        
        view.addSubview(loginLabel)
        view.addSubview(emailTf)
        view.addSubview(passwordTf)
        view.addSubview(loginButton)
        
        loginLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview().offset(40)
        }
        
        emailTf.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(100)
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().offset(-40)
            make.height.equalTo(tfHeight)
        }
        
        passwordTf.snp.makeConstraints { make in
            make.top.equalTo(emailTf.snp.bottom).offset(30)
            make.leading.equalTo(emailTf.snp.leading)
            make.trailing.equalTo(emailTf.snp.trailing)
            make.height.equalTo(tfHeight)
        }
        
        loginButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(80)
            make.width.equalTo(200)
            make.height.equalTo(tfHeight)
        }
    }
    
}

extension LoginViewController: LoginViewModelDelegate {
    
    func loginDidSucceed(response: Networking.LoginResponse) {
        activityIndicator.stopAnimating()
        let name = "\(response.user.firstName ?? "") \(response.user.lastName ?? "")"
        let vc = AccountUserViewController(name: name)
        let navC = UINavigationController(rootViewController: vc)
        navC.modalPresentationStyle = .fullScreen
        present(navC, animated: true)
    }
    
    func loginDidFail(errorMessage: String) {
        activityIndicator.stopAnimating()
        Utilities.createAlert(vc: self, title: "Login Error", message: errorMessage)
    }
    
}
