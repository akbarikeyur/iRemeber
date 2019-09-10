//
//  LocatorAddImageVC.swift
//  iRemeber
//
//  Created by PC on 06/05/19.
//  Copyright © 2019 PC. All rights reserved.
//

import UIKit

class LocatorAddImageVC: UploadImageVC {

    @IBOutlet weak var imageBtn: Button!
    @IBOutlet weak var imgView: ImageView!
    
    @IBOutlet weak var nameTxt: TextField!
    @IBOutlet weak var discriptionTxt: TextField!
    @IBOutlet weak var locationTxt: TextField!
    
    var selectedImage : UIImage = UIImage()
    var selectedData : LocatorModel = LocatorModel()
    
    var type :Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSetup()
        
    }
    
    func dataSetup() {
        if type == 1 {
            nameTxt.text = selectedData.name
            discriptionTxt.text = selectedData.descriptions
            locationTxt.text = selectedData.location
          //  imageBtn.setImage(getImage(imageName: selectedData.image), for: .normal)
            imgView.image = getImage(imageName: selectedData.image)
            selectedImage = getImage(imageName: selectedData.image)!
        }
    }
    
    //MARK: - Button Click
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickToDone(_ sender: Any) {
        if selectedImage == nil {
            displayToast("Please select image")
        }
        else if (nameTxt.text?.trimmingCharacters(in: .whitespaces).isEmpty)! {
            displayToast("Please enter name of object")
        }
        else if (discriptionTxt.text?.trimmingCharacters(in: .whitespaces).isEmpty)! {
            displayToast("Please enter description")
        }
        else if (locationTxt.text?.trimmingCharacters(in: .whitespaces).isEmpty)! {
            displayToast("Please enter location")
        }
        else {
            showLoader()
            let data : LocatorModel = LocatorModel.init()
            data.id = getCurrentTimeStampValue()
            data.image = data.id
            data.name = nameTxt.text?.trimmed
            data.descriptions = discriptionTxt.text?.trimmed
            data.location = locationTxt.text?.trimmed
            
            if type == 1 {
                CoreDataUtility.shared.deleteLocator(order: selectedData, TableName: "LocatorList")
            }
            
            storeImageInDocumentDirectory(image: selectedImage, imageName: data.image)
            CoreDataUtility.shared.saveLocatorData(Model: data, TableName: "LocatorList")
            
            delay(0.1) {
                removeLoader()
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "LocatorListVC") as! LocatorListVC
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    @IBAction func clicKToCamera(_ sender: Any) {
        uploadImage()
    }
    
    override func selectedImage(choosenImage: UIImage) {
      //  imageBtn.setImage(choosenImage, for: .normal)
        imgView.image = choosenImage
        selectedImage = choosenImage
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
