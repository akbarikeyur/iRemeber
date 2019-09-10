//
//  MemoriesVC.swift
//  iRemeber
//
//  Created by PC on 06/05/19.
//  Copyright © 2019 PC. All rights reserved.
//

import UIKit

class MemoriesVC: UploadImageVC, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var noDataLbl: UILabel!
    
    var memorieArr : [MemoryModel] = [MemoryModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblView.register(UINib(nibName: "CaptureTVC", bundle: nil), forCellReuseIdentifier: "CaptureTVC")
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        noDataLbl.isHidden = true
        if let dict1 : [MemoryModel] = CoreDataUtility.shared.fatchMemories(TableName: "MemoryList"), dict1.count != 0 {
            print(dict1)
            memorieArr = dict1
            tblView.reloadData()
        }
        else {
            noDataLbl.isHidden = false
        }
    }
    
    //MARK: - Button Click
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickToAdd(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MemoryDisplayVC") as! MemoryDisplayVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    //MARK: - TableView Delgate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memorieArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "CaptureTVC", for: indexPath) as! CaptureTVC
        let dict : MemoryModel = memorieArr[indexPath.row]
        
        cell.descLbl.text = "Title : " + dict.title
        cell.timeLbl.text = "Date : " + dict.date
        cell.videoImg.isHidden = true
        cell.captureImg.image = getImage(imageName: dict.image)
        
        cell.cancelBtnWidthConstraint.constant = 0
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dict : MemoryModel = memorieArr[indexPath.row]
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MemoryDisplayVC") as! MemoryDisplayVC
        vc.flag = 1
        vc.memoryDict = dict
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            showAlertWithOption("Confirmation", message: "Are you sure you want to delete this memorie.", completionConfirm: {
                CoreDataUtility.shared.deleteMemories(order: self.memorieArr[indexPath.row], TableName: "MemoryList")
                self.memorieArr.remove(at: indexPath.row)
                if self.memorieArr.count == 0 {
                    self.noDataLbl.isHidden = false
                }
                self.tblView.reloadData()
            }) {
                
            }
        }
    }
    
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//        let deleteButton = UITableViewRowAction(style: .default, title: "Delete") { (action, indexPath) in
//            self.tblView.dataSource?.tableView!(self.tblView, commit: .delete, forRowAt: indexPath)
//            return
//        }
//        deleteButton.backgroundColor = OrangeColor
//        return [deleteButton]
//    }
    
    @objc func clickToDelete(sender : UIButton) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
