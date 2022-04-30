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
        stackView.spacing = 5
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
            make.centerY.equalToSuperview().offset(-40)
            make.left.equalTo(location.snp.right).offset(20)
        }
        
        info.snp.makeConstraints { make in
            make.left.equalTo(maskKind.snp.left)
            make.centerY.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-20)
        }
    }
    
    func configure(data:MaskGeoData.Feature){
        name.text = data.properties.name
        county.text = data.properties.county
        town.text = data.properties.town
        maskAdult.text = "成人口罩數量：\(data.properties.mask_adult)"
        maskChild.text = "孩童口罩數量：\(data.properties.mask_child)"
        phone.text = "電話：" + data.properties.phone
        adress.text = "地址：" + data.properties.address
        note.text = "時間：" + data.properties.note
    }

}
