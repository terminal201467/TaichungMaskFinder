//
//  TableViewCell.swift
//  TaichungMaskFinder
//
//  Created by Jhen Mu on 2022/4/29.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    static let reuseIdentifier:String = "Cell"
    
    private let county:UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    private let name:UILabel = {
        let label = UILabel()
        label.textColor = .green
        label.numberOfLines = 2
        return label
    }()
    
    private let adress:UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()
    
    private let phone:UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    private let maskAdult:UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    private let maskChild:UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()

    
    private let town:UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    private let note:UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    
    lazy var location:UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [county,town])
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.spacing = 3
        return stackView
    }()
    
    lazy var maskKind:UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [maskAdult,maskChild])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 5
        return stackView
    }()
    
    lazy var info:UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [phone,adress,note])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 3
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(location)
        addSubview(maskKind)
        addSubview(info)
        autoLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func autoLayout(){
        name.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        }
        
        maskKind.snp.makeConstraints { make in
            make.left.equalTo(name.snp.right)
            make.centerY.equalToSuperview()
        }
        
        info.snp.makeConstraints { make in
            make.left.equalTo(maskKind.snp.left)
            make.centerY.equalToSuperview()
        }
    }
    
    private func configure(data:MaskGeoData.Feature){
        name.text = data.properties.name
        county.text = data.properties.county
        town.text = data.properties.town
        maskAdult.text = "\(data.properties.mask_adult)"
        maskChild.text = "\(data.properties.mask_child)"
        phone.text = data.properties.phone
        adress.text = data.properties.address
        note.text = data.properties.note
    }

}
