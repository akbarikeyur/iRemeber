//
//  MemoriesVC.swift
//  iRemeber
//
//  Created by PC on 06/05/19.
//  Copyright © 2019 PC. All rights reserved.
//

import UIKit

class MemoriesVC: UploadImageVC, UITableViewDelegate, UITableViewDataSource, AddMemoriesDelegate {

    @IBOutlet weak var tblView: UITableView!
    
    var tempImg : UIImage? = nil
//    var selectedImageArr : [UIImage] = [UIImage]()
    var selectedIndex : Int = 0
    
    var queDict : MemoryModel = MemoryModel()
    var memorieArr : [MemoryModel] = [MemoryModel]()
    
    var selectedDate : Date!
    
    override func viewDidLoad() {
        super.viewDidLoad()
  //      dataSetup()
        
        tblView.register(UINib(nibName: "MemoriesTVC", bundle: nil), forCellReuseIdentifier: "MemoriesTVC")
        
        if let dict1 : [MemoryModel] = CoreDataUtility.shared.fatchMemories(TableName: "MemoryList"), dict1.count != 0 {
            print(dict1)
            memorieArr = dict1
            tblView.reloadData()
        } else {
            addDict()
        }
        
//        dataSetup()
    }
    
    func addDict() {
        self.view.endEditing(true)
        queDict = MemoryModel.init()
        queDict.id = getCurrentTimeStampValue()
        queDict.image = ""
        queDict.name = ""
        queDict.date = ""
        memorieArr.append(queDict)
//        selectedImageArr.append(UIImage())
        tblView.reloadData()
        print(memorieArr)
    }
    
//    func dataSetup() {
//        for _ in memorieArr {
//            selectedImageArr.append(tempImg)
//        }
//    }
    
    //MARK: - Button Click
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickToAdd(_ sender: Any) {
        self.view.endEditing(true)
        if memorieArr[memorieArr.count - 1].name == "" {
            displayToast("Please enter title.")
        }
        else if memorieArr[memorieArr.count - 1].date == "" {
            displayToast("Please enter date.")
        }
        else {
            addDict()
        }
    }
    
    
    //MARK: - TableView Delgate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memorieArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "MemoriesTVC", for: indexPath) as! MemoriesTVC
        
        let dict : MemoryModel = memorieArr[indexPath.row]
        cell.index = indexPath.row
        cell.delegate = self
        
        cell.titleTxt.text = dict.name
        cell.dateLbl.text = "Date : " + dict.date
        
        cell.imgBtn.tag = indexPath.row
        cell.imgBtn.addTarget(self, action: #selector(self.clickToSelectImg), for: .touchUpInside)
     //   cell.imgBtn.setImage(dict.image != "" ? getImage(imageName: dict.image) : selectedImageArr[indexPath.row], for: .normal)
        
        print(dict.image)
        
        if dict.image != "" {
            //cell.imgBtn.setImage(getImage(imageName: dict.image), for: .normal)
            cell.imgView.image = getImage(imageName: dict.image)
        } else {
            //cell.imgBtn.setImage(dict.selectedImg, for: .normal)
            cell.imgView.image = dict.selectedImg
        }
        
        cell.deleteBtn.tag = indexPath.row
        cell.deleteBtn.addTarget(self, action: #selector(self.clickToDelete), for: .touchUpInside)
        
        cell.dateBtn.tag = indexPath.row
        cell.dateBtn.addTarget(self, action: #selector(self.clickToSelectDate), for: .touchUpInside)
        
        cell.saveBtn.tag = indexPath.row
        cell.saveBtn.addTarget(self, action: #selector(self.clickToSaveData), for: .touchUpInside)
        
        return cell
    }
    
    func updateQueChalangeText(_ text: String, _ index: Int) {
        self.view.endEditing(true)
        memorieArr[(index)].name = text.trimmed
        print(memorieArr)
        tblView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }
    
    @objc func clickToSaveData(sender  :UIButton) {
        self.view.endEditing(true)
        let dict : MemoryModel = memorieArr[sender.tag]
        if dict.date == "" {
            displayToast("Please enter date.")
        }
        else if dict.name == "" {
            displayToast("Please enter title.")
        }
        else {
            if let data : Bool =  CoreDataUtility.shared.selectMemories(item: dict, TableName: "MemoryList") , data == true {
                
                if dict.selectedImg != nil {
                    deleteImage(fromDirectory: dict.image)
                    dict.image = dict.id
                    storeImageInDocumentDirectory(image: dict.selectedImg, imageName: dict.image)
                }
                CoreDataUtility.shared.updateMemories(item: dict, TableName: "MemoryList")
                displayToast("Data updated successfully.")
            }
            else {
                if dict.selectedImg != nil {
                    dict.image = dict.id
                    storeImageInDocumentDirectory(image: dict.selectedImg, imageName: dict.image)
                }
                CoreDataUtility.shared.saveMemories(Model: dict, TableName: "MemoryList")
                displayToast("Data saved successfully.")
            }
        }
    }
    
    @objc func clickToSelectDate(sender  :UIButton) {
        self.view.endEditing(true)
        if selectedDate == nil
        {
            selectedDate = Date()
        }
        let maxDate : Date = Calendar.current.date(byAdding: .year, value: 0, to: Date())!
        DatePickerManager.shared.showPicker(title: "select_dob", selected: selectedDate, min: nil, max: maxDate) { (date, cancel) in
            if !cancel && date != nil {
                self.selectedDate = date!
                self.memorieArr[sender.tag].date = getDateStringFromDate(date: self.selectedDate, format: "dd-MM-yyyy")
                self.tblView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .automatic)
            }
        }
    }
    
    @objc func clickToDelete(sender : UIButton) {
        self.view.endEditing(true)
        showAlertWithOption("Confirmation", message: "Are you sure you want to delete this memorie.", completionConfirm: {
            CoreDataUtility.shared.deleteMemories(order: self.memorieArr[sender.tag], TableName: "MemoryList")
            self.memorieArr.remove(at: sender.tag)
            if self.memorieArr.count == 0 {
                self.addDict()
            }
            self.tblView.reloadData()
        }) {
            
        }
    }
    
    @objc func clickToSelectImg(sender : UIButton)  {
        uploadImage()
        selectedIndex = sender.tag
    }
    override func selectedImage(choosenImage: UIImage) {
        memorieArr[selectedIndex].selectedImg = choosenImage
        memorieArr[selectedIndex].image = ""
        tblView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
