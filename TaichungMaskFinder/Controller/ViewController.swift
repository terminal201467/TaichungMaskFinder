//
//  ViewController.swift
//  TaichungMaskFinder
//
//  Created by Jhen Mu on 2022/4/26.
//

import UIKit

class ViewController: UIViewController {
    
    private let maskView = View()
    
    private let network = NetworkController()
    
    //MARK:-LifeCycle
    override func loadView() {
        super.loadView()
        view = maskView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setNetwork()
        setTable()
        
    }
    
    private func setNavigationBar(){
        title = "找口罩"
        navigationController?.navigationBar.tintColor = .white
    }
    
    private func setNetwork(){
        network.getData()
        network.valueChanged = {
            print("台中:",self.network.taichungData.count)
        }
    }
    
    private func setTable(){
        maskView.table.delegate = self
        maskView.table.dataSource = self
    }
}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        network.taichungData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseIdentifier, for: indexPath)as! TableViewCell
        
        return cell
    }
    
    
    
}

