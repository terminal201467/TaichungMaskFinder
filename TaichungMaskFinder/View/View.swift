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
        textField.backgroundColor = .placeholderText
        textField.tintColor = .black
        textField.borderStyle = .roundedRect
        textField.textColor = .black
        textField.clearButtonMode = .whileEditing
        textField.attributedPlaceholder = NSAttributedString(string:"輸入區域",
                                                             attributes:[NSAttributedString.Key.foregroundColor:UIColor.gray])
        if let clearButton = textField.value(forKey: "_clearButton") as? UIButton {
               let templateImage = clearButton.imageView?.image?.withRenderingMode(.alwaysTemplate)
               clearButton.setImage(templateImage, for: .normal)
               clearButton.tintColor = .darkGray
           }
        return textField
    }()

    let table:UITableView = {
        let tableView = UITableView()
        tableView.register(TableViewCell.self, forCellReuseIdentifier:TableViewCell.reuseIdentifier)
        tableView.separatorStyle = .singleLine
        tableView.rowHeight = 220
//        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .white
        tableView.allowsSelection = false
        return tableView
    }()
    
    let areaSelector:UIPickerView = {
        let pickView = UIPickerView()
        pickView.backgroundColor = .white
        pickView.setValue(UIColor.black, forKeyPath: "textColor")
        pickView.becomeFirstResponder()
        return pickView
    }()
    
    let sentence:UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 3
        label.font = UIFont.systemFont(ofSize: TiteSize.celltitle.Size)
        return label
    }()
    
    let name:UILabel = {
        let label = UILabel()
        label.textColor = .blue
        label.font = UIFont.systemFont(ofSize: TiteSize.celltitle.Size)
        return label
    }()
    
    let view:UIView = {
       let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var  everyDaySentece:UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [sentence,name])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.spacing = 5
        stackView.backgroundColor = .white
        return stackView
    }()
    
    let toTopButton:UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        button.layer.cornerRadius = 15
        button.setTitle("置頂", for:.normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(items)
        addSubview(inputCounty)
        addSubview(table)
        addSubview(view)
        addSubview(everyDaySentece)
        addSubview(activityIndicator)
        addSubview(toTopButton)
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func autoLayout(){
        view.snp.makeConstraints { make in
            make.height.equalTo(150)
            make.right.left.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        everyDaySentece.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(10)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.bottom.equalToSuperview().offset(-10)
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
        
        toTopButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.top).offset(-20)
            make.right.equalToSuperview().offset(-20)
            make.width.equalTo(55)
            make.height.equalTo(30)
        }
    }
    
    func configure(sentence:Sentence){
        self.sentence.text = "「" + "\(sentence.sentence)" + "」"
        self.name.text = "-" + sentence.name
    }
    
}
