//
//  AccountUserViewController.swift
//  MoneyBox
//
//  Created by Yinka on 2024-03-22.
//

import UIKit
import Networking

class AccountUserViewController: UIViewController {
    
    lazy var viewModel: AccountUserViewModel = {
        let provider = DataProvider()
        let viewModel = AccountUserViewModel(provider: provider)
        viewModel.delegate = self
        return viewModel
    }()
    
    var name = ""
    
    lazy var refreshControl: UIRefreshControl = {
        lazy var refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(didStartRefreshing), for: .valueChanged)
        return refreshControl
    }()
    
    lazy var productTable: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(ProductCell.self, forCellReuseIdentifier: ProductCell.identifier)
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none
        table.backgroundColor = .clear
        table.refreshControl = refreshControl
        return table
    }()
    
    init(name: String) {
        super.init(nibName: nil, bundle: nil)
        self.name = name
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = "User Accounts"
        view.backgroundColor = .white.withAlphaComponent(0.75)
        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.getProducts()
    }
    
    @objc private func didStartRefreshing() {
        viewModel.getProducts()
    }
    
    private func setConstraints() {
        view.addSubview(productTable)
        
        productTable.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview()
        }
    }

}

extension AccountUserViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.products.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = ProductCellHeader()
        headerView.nameLbl.text = "Hello \(name)!"
        let formattedAmount = viewModel.totalPlanValue.formatted(.currency(code: "GBP"))
        headerView.totalPlanValueLbl.text = "Total Plan Value: \(formattedAmount)"
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.identifier, for: indexPath) as! ProductCell
        let product = viewModel.products[indexPath.row]
        cell.configure(with: product)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = viewModel.products[indexPath.row]
        let vc = ProductViewController(product: product)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

extension AccountUserViewController: AccountUserViewModelDelegate {
    func didReceiveResponse() {
        productTable.reloadData()
        refreshControl.endRefreshing()
    }
    
    func loginDidFail(errorMessage: String) {
        refreshControl.endRefreshing()
    }
}
