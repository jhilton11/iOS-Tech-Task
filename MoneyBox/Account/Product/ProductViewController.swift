//
//  ProductViewController.swift
//  MoneyBox
//
//  Created by Yinka on 2024-03-24.
//

import UIKit
import Networking

class ProductViewController: UIViewController {
    
    private var product: ProductResponse?
    private var moneyBox = 0.0
    
    lazy var viewModel: ProductViewModel = {
        let provider = DataProvider()
        let viewModel = ProductViewModel(provider: provider)
        viewModel.delegate = self
        return viewModel
    }()
    
    lazy var accountTypeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = product?.product?.name ?? ""
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    lazy var planValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Plan Value: \(product?.planValue?.formatToCurrency() ?? "")"
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    lazy var moneyBoxLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Moneybox: \(moneyBox.formatToCurrency())"
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let formattedAmount = 10.formatToCurrency()
        button.setTitle("Add \(formattedAmount)", for: .normal)
        button.backgroundColor = Colours.DeepGreyColour
        button.setTitleColor(.label, for: .normal)
        button.addBorder()
        button.addTarget(self, action: #selector(addMoney), for: .touchUpInside)
        button.accessibilityHint = "Add 10 pounds button"
        return button
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        return indicator
    }()
    
    init(product: ProductResponse) {
        super.init(nibName: nil, bundle: nil)
        self.product = product
        
        if let moneybox = product.moneybox {
            self.moneyBox = moneybox
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = "Individual Account"
        view.backgroundColor = Colours.GreyColour
        setConstraints()
    }
    
    @objc private func addMoney() {
        if let id = product?.id {
            activityIndicator.startAnimating()
            let request = OneOffPaymentRequest(amount: 10, investorProductID: id)
            viewModel.addPayment(request: request)
        }
    }
    
    private func setConstraints() {
        let tfHeight = 44.0
        
        view.addSubview(accountTypeLabel)
        view.addSubview(planValueLabel)
        view.addSubview(moneyBoxLabel)
        view.addSubview(addButton)
        view.addSubview(activityIndicator)
        
        accountTypeLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        planValueLabel.snp.makeConstraints { make in
            make.top.equalTo(accountTypeLabel.snp.bottom).offset(20)
            make.leading.equalTo(accountTypeLabel)
        }
        
        moneyBoxLabel.snp.makeConstraints { make in
            make.top.equalTo(planValueLabel.snp.bottom).offset(20)
            make.leading.equalTo(accountTypeLabel)
        }
        
        addButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(50)
            make.width.equalTo(200)
            make.height.equalTo(tfHeight)
        }
        
        activityIndicator.center = view.center
    }

}

extension ProductViewController: ProductViewModelDelegate {
    func didReceiveResponse() {
        print("Payment accepted")
        moneyBox += 10.0
        moneyBoxLabel.text = "MoneyBox: \(moneyBox.formatToCurrency())"
        activityIndicator.stopAnimating()
    }
    
    func loginDidFail(errorMessage: String) {
        activityIndicator.stopAnimating()
        Utilities.createAlert(vc: self, title: "", message: errorMessage)
    }
}
