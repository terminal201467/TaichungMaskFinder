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
        title = "台中找口罩"
        let chooseMask = UIBarButtonItem.init(title: "篩選區域", style: .plain, target: self, action: #selector(choose))
        navigationController?.navigationBar.tintColor = .blue
        self.navigationItem.rightBarButtonItem = chooseMask

    }
    
    @objc func choose(){
        //PickView
    }
    
    private func setNetwork(){
        network.getData()
        network.valueChanged = {
//            print("台中:",self.network.taichungData.count)
            DispatchQueue.main.async {
                self.maskView.table.reloadData()
            }
            
        }
    }
    
    private func setTable(){
        maskView.table.delegate = self
        maskView.table.dataSource = self
    }
}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        network.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseIdentifier, for: indexPath)as! TableViewCell
        cell.configure(data: network.getData(indexPath))
        return cell
    }
    
    
    
}

