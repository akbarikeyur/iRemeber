//
//  LocatorDisplayVC.swift
//  iRemeber
//
//  Created by PC on 06/05/19.
//  Copyright © 2019 PC. All rights reserved.
//

import UIKit

class LocatorDisplayVC: UploadImageVC {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    
    var selectedData : LocatorModel = LocatorModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSetup()
    }
    
    func dataSetup() {
        nameLbl.text = selectedData.name
        descriptionLbl.text = selectedData.descriptions
        locationLbl.text = selectedData.location
        imgView.image = getImage(imageName: selectedData.image)
    }
    
    //MARK: - Button Click
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickToDisplayFullImage(_ sender: Any) {
        if let img = getImage(imageName: selectedData.image) {
            displayFullImage(img, 0)
        }
    }
    
    @IBAction func clicKToEdit(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LocatorAddImageVC") as! LocatorAddImageVC
        vc.type = 1
        vc.selectedData = self.selectedData
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    override func selectedImage(choosenImage: UIImage) {
        imgView.image = choosenImage
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



}
