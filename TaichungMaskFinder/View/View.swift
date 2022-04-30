//
//  View.swift
//  TaichungMaskFinder
//
//  Created by Jhen Mu on 2022/4/26.
//

import UIKit
import SnapKit

class View: UIView {
    
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
    
    let table:UITableView = {
        let tableView = UITableView()
        tableView.register(TableViewCell.self, forCellReuseIdentifier:TableViewCell.reuseIdentifier)
        tableView.separatorStyle = .singleLine
        tableView.rowHeight = 150
        tableView.backgroundColor = .white
        return tableView
    }()
    
    let areaSelector:UIPickerView = {
        let pickView = UIPickerView()
        pickView.backgroundColor = .white
        return pickView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(items)
        addSubview(table)
//        addSubview(areaSelector)
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func autoLayout(){
        items.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(100)
            make.centerX.equalToSuperview().offset(-100)
        }
        
        table.snp.makeConstraints { make in
            make.top.equalTo(items.snp.bottom)
            make.right.left.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    
    
}
