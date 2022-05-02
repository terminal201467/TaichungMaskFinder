//
//  View.swift
//  TaichungMaskFinder
//
//  Created by Jhen Mu on 2022/4/26.
//

import UIKit
import SnapKit

class View: UIView {
    
    let activityIndicator:UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .large
        activityIndicator.color = .darkGray
        return activityIndicator
    }()
    
    private let pharmacyName:UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = ItemName.pharmacy.text
        label.font = UIFont.systemFont(ofSize: TiteSize.title.Size)
        return label
    }()
    
    private let infoItem:UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = ItemName.info.text
        label.font = UIFont.systemFont(ofSize: TiteSize.title.Size)
        return label
    }()
    
    private lazy var items:UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [pharmacyName,infoItem])
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.spacing = 25
        stackView.backgroundColor = .white
        return stackView
    }()

    let inputCounty:UITextField = {
        let textField = UITextField()
        textField.placeholder = "輸入區域"
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .whileEditing
        return textField
    }()

    let table:UITableView = {
        let tableView = UITableView()
        tableView.register(TableViewCell.self, forCellReuseIdentifier:TableViewCell.reuseIdentifier)
        tableView.separatorStyle = .singleLine
        tableView.rowHeight = 200
        tableView.backgroundColor = .white
        tableView.allowsSelection = false
        return tableView
    }()
    
    let areaSelector:UIPickerView = {
        let pickView = UIPickerView()
        pickView.backgroundColor = .white
        pickView.becomeFirstResponder()
        return pickView
    }()
    
    let everyDaySentece:UIView = {
       let view = UIView()
        view.backgroundColor = .cyan
        view.layer.cornerRadius = 15
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(items)
        addSubview(inputCounty)
        addSubview(table)
        addSubview(everyDaySentece)
        addSubview(activityIndicator)
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func autoLayout(){
        everyDaySentece.snp.makeConstraints { make in
            make.height.equalTo(120)
            make.right.left.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        items.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(100)
            make.centerX.equalToSuperview().offset(-100)
        }
        
        inputCounty.snp.makeConstraints { make in
            make.centerY.equalTo(items.snp.centerY)
            make.right.equalToSuperview().offset(-20)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
        
        table.snp.makeConstraints { make in
            make.top.equalTo(items.snp.bottom)
            make.right.left.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
//        activityIndicator.snp.makeConstraints { make in
//            make.center.equalTo(table.snp.center)
//        }
    }
    
    
    
}
