//
//  CapatureListVC.swift
//  iRemeber
//
//  Created by PC on 09/05/19.
//  Copyright © 2019 PC. All rights reserved.
//

import UIKit

class CapatureListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var nodataLbl: UILabel!
    
    var locatorArr : [LocatorModel] = [LocatorModel]()
    var dict1 : [LocatorModel] = [LocatorModel]()
    
    var selectedFlag : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblView.register(UINib(nibName: "CaptureTVC", bundle: nil), forCellReuseIdentifier: "CaptureTVC")
       
        NotificationCenter.default.addObserver(self, selector: #selector(designSetup), name: NSNotification.Name.init(NOTIFICATION.UPDATE_CAPTURE), object: nil)
        nodataLbl.isHidden = true
        designSetup()
        
    }
    
    @objc func designSetup() {
        dict1 = CoreDataUtility.shared.fatchCaptureData(TableName: "CaptureList")
        locatorArr = [LocatorModel]()
        if dict1.count != 0 {
            for item in dict1 {
                let questionDict : LocatorModel = LocatorModel()
                questionDict.id = item.id
                questionDict.image = item.image
                questionDict.descriptions = item.descriptions
                questionDict.type = item.type
                questionDict.time = item.time
                locatorArr.append(questionDict)
            }
            tblView.reloadData()
        }
        else {
            nodataLbl.isHidden = false
        }
    }
    
    //MARK: - TableView Delgate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locatorArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "CaptureTVC", for: indexPath) as! CaptureTVC
        
        let dict : LocatorModel = locatorArr[indexPath.row]
        
        cell.descLbl.text = dict.descriptions
        cell.timeLbl.text = dict.time//getDateStringFromServerTimeStemp(Double(dict.time) ?? 0.0)
        cell.videoImg.isHidden = true
        
        if dict.type == 1 {
            cell.captureImg.image = getImage(imageName: dict.image)
        }
        else if dict.type == 2 {
            cell.videoImg.isHidden = false
            cell.captureImg.image = getImage(imageName: dict.image)?.rotate(radians: .pi/2)
        }
        
        cell.cancelBtnWidthConstraint.constant = 0
//        cell.deleteBtn.tag = indexPath.row
//        cell.deleteBtn.addTarget(self, action: #selector(self.clickToDelete), for: .touchUpInside)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dict : LocatorModel = locatorArr[indexPath.row]
        if dict.type == 1 {
            if selectedFlag == 1 {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "CaptureSetUpVC") as! CaptureSetUpVC
                vc.selectedData = dict
                vc.selectedFlag = 1
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                NotificationCenter.default.post(name: NSNotification.Name.init(NOTIFICATION.SELECTED_CAPTURE), object: dict)
                self.navigationController?.popViewController(animated: true)
            }
        }
        else {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "VideoDisplayVC") as! VideoDisplayVC
            vc.selectedData = dict
            vc.flag = 1
            self.navigationController?.pushViewController(vc, animated: true)
        }
       
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let dict : LocatorModel = locatorArr[indexPath.row]
            self.view.endEditing(true)
            
            showAlertWithOption("Confirmation", message: "Are you sure you want to delete this capture.", completionConfirm: {
                CoreDataUtility.shared.deleteLocator(order: self.locatorArr[indexPath.row], TableName: "CaptureList")
                if dict.type == 1 {
                    self.locatorArr.remove(at: indexPath.row)
                }
                else {
                    deleteVideo(fromDirectory: dict.image)
                    self.locatorArr.remove(at: indexPath.row)
                }
                self.tblView.reloadData()
                
                if self.locatorArr.count == 0 {
                    self.nodataLbl.isHidden = false
                }
                
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
    
//    @objc func clickToDelete(sender : UIButton) {
//        let dict : LocatorModel = locatorArr[sender.tag]
//        self.view.endEditing(true)
//        
//        showAlertWithOption("Confirmation", message: "Are you sure you want to delete this capture.", completionConfirm: {
//            CoreDataUtility.shared.deleteLocator(order: self.locatorArr[sender.tag], TableName: "CaptureList")
//            if dict.type == 1 {
//                self.locatorArr.remove(at: sender.tag)
//            }
//            else {
//                deleteVideo(fromDirectory: dict.image)
//                self.locatorArr.remove(at: sender.tag)
//            }
//            self.tblView.reloadData()
//            
//            if self.locatorArr.count == 0 {
//                self.nodataLbl.isHidden = false
//            }
//            
//        }) {
//            
//        }
//    }
    
    //MARK: - Button click
    @IBAction func clicKToBack(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
