//
//  TableViewCell.swift
//  TaichungMaskFinder
//
//  Created by Jhen Mu on 2022/4/29.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    static let reuseIdentifier:String = "Cell"
    
    let name:UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    let adress:UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    let phone:UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    let maskAdult:UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    let maskChild:UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    let county:UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    let town:UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        autoLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func autoLayout(){
        
    }
    
    private func configure(){
        
    }

}
