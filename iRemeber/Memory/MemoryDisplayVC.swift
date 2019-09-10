//
//  MemoryDisplayVC.swift
//  iRemeber
//
//  Created by PC on 18/05/19.
//  Copyright © 2019 PC. All rights reserved.
//

import UIKit

class MemoryDisplayVC: UploadImageVC {

    @IBOutlet weak var titleTxt: UITextField!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var descriptionTxtView: TextView!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var selectImgBtn: UIButton!
    
    
    var selectedDate : Date!
    var selectedImg : UIImage = UIImage()
    var memoryDict : MemoryModel = MemoryModel()
    
    var flag : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSetUp()
        
    }
    
    func dataSetUp()  {
        if flag == 1 {
            titleTxt.text = memoryDict.title
            descriptionTxtView.text = memoryDict.name
            dateLbl.text = memoryDict.date
            imgView.image = getImage(imageName: memoryDict.image)
            selectedImg = getImage(imageName: memoryDict.image)!
            selectImgBtn.setTitle("", for: .normal)
        }
    }
    
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func clickToSelectImage(_ sender: Any) {
        if flag == 1 {
            displayFullImage(selectedImg, 0)
        }else {
            uploadImage()
        }
    }
    override func selectedImage(choosenImage: UIImage) {
        imgView.image = choosenImage
        selectedImg = choosenImage
    }
    
    @IBAction func clickToDate(_ sender: Any) {
        self.view.endEditing(true)
        if selectedDate == nil
        {
            selectedDate = Date()
        }
        let maxDate : Date = Calendar.current.date(byAdding: .year, value: 0, to: Date())!
        DatePickerManager.shared.showPicker(title: "select_dob", selected: selectedDate, min: nil, max: maxDate) { (date, cancel) in
            if !cancel && date != nil {
                self.selectedDate = date!
                self.dateLbl.text = getDateStringFromDate(date: self.selectedDate, format: "dd-MM-yyyy")
            }
        }
    }
    
    @IBAction func clickToDone(_ sender: Any) {
        self.view.endEditing(true)
        if (titleTxt.text?.trimmingCharacters(in: .whitespaces).isEmpty)! {
            displayToast("Please select title")
        }
        else if selectedImg == nil {
            displayToast("Please select image")
        }
        else if (descriptionTxtView.text?.trimmingCharacters(in: .whitespaces).isEmpty)! {
            displayToast("Please enter description.")
        }
        else if (dateLbl.text?.trimmingCharacters(in: .whitespaces).isEmpty)! {
            displayToast("Please select date")
        }
        else {
//            memoryDict = MemoryModel.init()
            memoryDict.id = flag == 1 ? memoryDict.id : getCurrentTimeStampValue()
            memoryDict.title = titleTxt.text?.trimmed
            memoryDict.image = memoryDict.id
            memoryDict.name = descriptionTxtView.text.trimmed
            memoryDict.date = dateLbl.text?.trimmed
            
            if flag == 1 {
                CoreDataUtility.shared.updateMemories(item: memoryDict, TableName: "MemoryList")
            }
            else {
                storeImageInDocumentDirectory(image: selectedImg, imageName: memoryDict.image)
                CoreDataUtility.shared.saveMemories(Model: memoryDict, TableName: "MemoryList")
            }

            delay(0.1) {
                removeLoader()
                self.view.endEditing(true)
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}
