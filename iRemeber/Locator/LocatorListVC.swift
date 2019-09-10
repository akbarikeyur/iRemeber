//
//  LocatorListVC.swift
//  iRemeber
//
//  Created by PC on 11/05/19.
//  Copyright © 2019 PC. All rights reserved.
//

import UIKit

class LocatorListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var noDataLbl: UILabel!
    
    
    
    var locatorArr : [LocatorModel] = [LocatorModel]()
    var dict1 : [LocatorModel] = [LocatorModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tblView.register(UINib(nibName: "LocatorListTVC", bundle: nil), forCellReuseIdentifier: "LocatorListTVC")
        noDataLbl.isHidden = true
        
        dict1 = CoreDataUtility.shared.fatchLocatorData(TableName: "LocatorList")
        if dict1.count != 0 {
            for item in dict1 {
                let questionDict : LocatorModel = LocatorModel()
                questionDict.id = item.id
                questionDict.image = item.image
                questionDict.name = item.name
                questionDict.descriptions = item.descriptions
                questionDict.location = item.location
            
                locatorArr.append(questionDict)
            }
            tblView.reloadData()
        }
        else {
            noDataLbl.isHidden = false
        }
    }
    
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    //MARK: - TableView Delgate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locatorArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "LocatorListTVC", for: indexPath) as! LocatorListTVC
        
        let dict : LocatorModel = locatorArr[(indexPath.row)]
        
        cell.nameLbl.text =  dict.name
        cell.descLbl.text = dict.descriptions
        cell.locationLbl.text = dict.location
        cell.imgView.image = getImage(imageName: dict.image)

        cell.deleteBtn.tag = indexPath.row
        cell.deleteBtn.addTarget(self, action: #selector(self.clickToDelete), for: .touchUpInside)
        
        cell.imgBtn.tag = indexPath.row
        cell.imgBtn.addTarget(self, action: #selector(self.clickToImageFullView), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dict : LocatorModel = locatorArr[(indexPath.row)]
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LocatorDisplayVC") as! LocatorDisplayVC
        vc.selectedData = dict
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func clickToImageFullView(sender : UIButton) {
        let dict : LocatorModel = locatorArr[sender.tag]
        if let img = getImage(imageName: dict.image) {
            displayFullImage(img, 0)
        }
    }
    
    @objc func clickToDelete(sender : UIButton) {
        self.view.endEditing(true)
        
        showAlertWithOption("Confirmation", message: "Are you sure you want to delete this Locator.", completionConfirm: {
            CoreDataUtility.shared.deleteLocator(order: self.locatorArr[sender.tag], TableName: "LocatorList")
            self.locatorArr.remove(at: sender.tag)
            self.tblView.reloadData()
            
            if self.locatorArr.count == 0 {
                self.noDataLbl.isHidden = false
            }
            
        }) {
            
        }
    }
}
