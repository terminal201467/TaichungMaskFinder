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
        label.font = UIFont.systemFont(ofSize: TiteSize.celltitle.Size)
        return label
    }()
    
    private let name:UILabel = {
        let label = UILabel()
        label.textColor = .orange
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: TiteSize.celltitle.Size)
        return label
    }()
    
    private let adress:UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: TiteSize.celltitle.Size)
        return label
    }()
    
    private let phone:UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: TiteSize.celltitle.Size)
        return label
    }()
    
    private let maskAdult:UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: TiteSize.celltitle.Size)
        return label
    }()
    
    private let maskChild:UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: TiteSize.celltitle.Size)
        return label
    }()

    private let town:UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: TiteSize.celltitle.Size)
        return label
    }()
    
    private let note:UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 3
        label.font = UIFont.systemFont(ofSize: TiteSize.celltitle.Size)
        return label
    }()
    
    private lazy var location:UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [county,town])
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.spacing = 3
        return stackView
    }()
    
    private lazy var maskKind:UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [maskAdult,maskChild])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 2
        return stackView
    }()
    
    private lazy var info:UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [phone,adress,note])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 5
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        contentView.addSubview(name)
        contentView.addSubview(location)
        contentView.addSubview(maskKind)
        contentView.addSubview(info)
        autoLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func autoLayout(){
        name.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(40)
            make.centerY.equalToSuperview()
            make.width.equalTo(80)
        }
        
        location.snp.makeConstraints { make in
            make.centerX.equalTo(name.snp.centerX)
            make.bottom.equalTo(name.snp.top).offset(-10)
        }
        
        maskKind.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
//            make.centerY.equalToSuperview().offset(-20)
            make.left.equalTo(location.snp.right).offset(20)
        }
        
        info.snp.makeConstraints { make in
            make.top.equalTo(maskKind.snp.bottom).offset(10)
            make.left.equalTo(maskKind.snp.left)
//            make.centerY.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-20)
        }
    }
    
    func configure(data:MaskData){
        name.text = data.name
        county.text = data.county
        town.text = data.town
        maskAdult.text = "???????????????\(data.mask_adult)"
        maskChild.text = "???????????????\(data.mask_child)"
        phone.text = "?????????" + data.phone!
        adress.text = "?????????" + data.address!
        note.text = "?????????" + data.note!
    }
}
