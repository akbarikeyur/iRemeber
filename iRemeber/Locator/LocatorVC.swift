//
//  LocatorVC.swift
//  iRemeber
//
//  Created by PC on 06/05/19.
//  Copyright © 2019 PC. All rights reserved.
//

import UIKit

class LocatorVC: UploadImageVC {

    
    @IBOutlet weak var cameraBtn: Button!
    @IBOutlet weak var messageBtn: Button!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    //MARK: - Button Click
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clicKToCamera(_ sender: Any) {
        //uploadImage()
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LocatorAddImageVC") as! LocatorAddImageVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
//    override func selectedImage(choosenImage: UIImage) {
//        cameraBtn.setImage(choosenImage, for: .normal)
//    }
    
    @IBAction func clickToMessage(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LocatorListVC") as! LocatorListVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
