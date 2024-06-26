//
//  ProductCell.swift
//  MoneyBox
//
//  Created by Yinka on 2024-03-23.
//

import UIKit
import Networking

class ProductCell: UITableViewCell {
    
    static let identifier = "prooduct-cell"
    
    lazy var viewPanel: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colours.DeepGreyColour
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    lazy var accountNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Account name"
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    lazy var planValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Plan name"
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    lazy var moneyBoxLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Moneybox label"
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    lazy var disclosureImg: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.image = UIImage(systemName: "chevron.right")
        imgView.contentMode = .scaleAspectFit
        imgView.tintColor = .black
        return imgView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with product: ProductResponse) {
        accountNameLabel.text = product.product?.name
        
        if let formattedPlanValue = product.planValue?.formatToCurrency() {
            planValueLabel.text = "Plan Value: \(formattedPlanValue)"
        }
        
        if let formattedMoneyBox = product.moneybox?.formatToCurrency() {
            moneyBoxLabel.text = "MoneyBox: \(formattedMoneyBox)"
        }
    }
    
    private func setConstraints() {
        contentView.addSubview(viewPanel)
        viewPanel.addSubview(accountNameLabel)
        viewPanel.addSubview(planValueLabel)
        viewPanel.addSubview(moneyBoxLabel)
        viewPanel.addSubview(disclosureImg)
        
        viewPanel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
        }
        
        accountNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        planValueLabel.snp.makeConstraints { make in
            make.leading.equalTo(accountNameLabel)
            make.centerY.equalToSuperview()
        }
        
        moneyBoxLabel.snp.makeConstraints { make in
            make.leading.equalTo(accountNameLabel)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        disclosureImg.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(30)
        }
    }
    
}

class ProductCellHeader: UIView {
    
    lazy var nameLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Name Label"
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    lazy var totalPlanValueLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Plan Label"
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        self.addSubview(nameLbl)
        self.addSubview(totalPlanValueLbl)
        
        nameLbl.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(0)
            make.leading.trailing.equalToSuperview()
        }
        
        totalPlanValueLbl.snp.makeConstraints { make in
            make.top.equalTo(nameLbl.snp.bottom).offset(20)
            make.leading.trailing.equalTo(nameLbl)
        }
    }
    
}
