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
    
    private let sentenceEveryDay = SentenceEveryDayController()
    
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
        setPickView()
        setTextField()
        sentenceEveryDay.loadData()
    }
    
    private func setNavigationBar(){
        title = "找找口罩"
        let chooseMask = UIBarButtonItem.init(title: "篩選區域", style: .plain, target: self, action: #selector(choose))
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .blue
        self.navigationItem.rightBarButtonItem = chooseMask
    }
    
    @objc func choose(){
        print("篩選")
        network.filterTown(town: network.selectArea)
        maskView.table.reloadData()
    }
    
    private func setNetwork(){
        network.loadLocalObject()
        if network.localData.isEmpty{
            network.loadData()
        }
        network.valueChanged = {
            DispatchQueue.main.async {
                self.maskView.activityIndicator.startAnimating()
                self.maskView.table.reloadData()
                self.maskView.activityIndicator.stopAnimating()
            }
        }
    }
    
    private func setTable(){
        maskView.table.delegate = self
        maskView.table.dataSource = self
    }
    
    private func setPickView(){
        let doneButton = UIBarButtonItem(title: "確認", style: .plain, target: self, action: #selector(correct))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(cancel))
        let toolBar:UIToolbar = {
           let toolBar = UIToolbar()
            toolBar.barStyle = UIBarStyle.default
            toolBar.isTranslucent = true
            toolBar.tintColor = .systemBlue
            toolBar.sizeToFit()
            toolBar.isUserInteractionEnabled = true
            toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
            return toolBar
        }()
        maskView.areaSelector.delegate = self
        maskView.areaSelector.dataSource = self
        maskView.inputCounty.inputView = maskView.areaSelector
        maskView.inputCounty.inputAccessoryView = toolBar
    }
    
    @objc func correct(){
        maskView.inputCounty.text = network.selectArea
        maskView.inputCounty.resignFirstResponder()
    }
    
    @objc func cancel(){
        maskView.inputCounty.text = ""
        maskView.inputCounty.resignFirstResponder()
        network.removeTaichungData()
        network.loadLocalObject()
    }
    
    private func setTextField(){
        maskView.inputCounty.delegate = self
    }
    
}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        network.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseIdentifier, for: indexPath)as! TableViewCell
        cell.configure(data: network.getCellData(indexPath))
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            network.deleteRow(indexPath)
            maskView.table.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

extension ViewController:UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return network.numberOfRowsInComponent(component)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return network.titleForRow(row)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        network.selectArea = network.titleForRow(row)
    }
}

extension ViewController:UITextFieldDelegate{
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        print("clear")
        self.cancel()
        network.loadLocalObject()
        return true
    }
}

