//
//  CaptureSetUpVC.swift
//  iRemeber
//
//  Created by PC on 09/05/19.
//  Copyright © 2019 PC. All rights reserved.
//

import UIKit

class CaptureSetUpVC: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var captionTxtView: TextView!
    
    var img : UIImage = UIImage()
    var selectedData : LocatorModel = LocatorModel()
    
    var flag : Int = 0
    var selectedFlag : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(updateUserDetail), name: NSNotification.Name.init(NOTIFICATION.SELECTED_CAPTURE), object: nil)
        
        designSetup()
       
    }
    
    // handle notification
    @objc func updateUserDetail(notification: NSNotification) {
        let dict = notification.object as! LocatorModel
        selectedData = dict
        print(selectedData)
        flag = 1

        selectedData.type = 1
        imgView.image = getImage(imageName: selectedData.image)
        captionTxtView.text = selectedData.descriptions
    
    }
    
    func designSetup()  {
        if selectedFlag == 1 {
            selectedData.type = 1
            imgView.image = getImage(imageName: selectedData.image)
            captionTxtView.text = selectedData.descriptions
            flag = 1
        } else {
            imgView.image = img
        }
    }
    
    @IBAction func clicKToBack(_ sender: Any) {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickToshowImage(_ sender: Any) {
        if selectedFlag == 1 {
            if let img1 = getImage(imageName: selectedData.image) {
                displayFullImage(img1, 0)
            }
        }
        else {
            displayFullImage(img, 0)
        }
    }
    
    
    @IBAction func clickToDone(_ sender: Any) {
        self.view.endEditing(true)
        if img == nil {
            displayToast("Please select image.")
        }
        else {
            showLoader()
            selectedData.id = flag == 1 ? selectedData.id : getCurrentTimeStampValue()
            selectedData.type = 1
            selectedData.image = selectedData.id
            selectedData.descriptions = captionTxtView.text.trimmed
            selectedData.time = getDateStringFromDate(date: Date())
            
            if flag == 1 {
                CoreDataUtility.shared.updateCapture(item: selectedData, TableName: "CaptureList")
            }
            else {
                storeImageInDocumentDirectory(image: img, imageName: selectedData.image)
                CoreDataUtility.shared.saveCaptureData(Model: selectedData, TableName: "CaptureList")
            }
            
            delay(0.1) {
                removeLoader()
                self.view.endEditing(true)
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "CapatureListVC") as! CapatureListVC
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}
