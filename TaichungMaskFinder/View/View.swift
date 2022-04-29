//
//  View.swift
//  TaichungMaskFinder
//
//  Created by Jhen Mu on 2022/4/26.
//

import UIKit
import SnapKit

class View: UIView {
    
    let selectView:UIView = {
       let view = UIView()
        view.backgroundColor = .green
        return view
    }()
    
    let table:UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .insetGrouped)
        tableView.register(TableViewCell.self, forCellReuseIdentifier:TableViewCell.reuseIdentifier)
        tableView.separatorStyle = .singleLine
        tableView.rowHeight = 100
        tableView.backgroundColor = .white
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(selectView)
        addSubview(table)
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func autoLayout(){
        selectView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(150)
            make.right.left.equalToSuperview()
        }
        
        table.snp.makeConstraints { make in
            make.top.equalTo(selectView.snp.bottom)
            make.right.left.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    
    
}
