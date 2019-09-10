//
//  CaptureVC.swift
//  iRemeber
//
//  Created by PC on 06/05/19.
//  Copyright © 2019 PC. All rights reserved.
//

import UIKit

class CaptureVC: UploadImageVC {

    @IBOutlet weak var cameraBtn: Button!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    
    //MARK: - Button Click
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickToCamera(_ sender: Any) {
        uploadImage()
    }
    
    override func selectedImage(choosenImage: UIImage) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CaptureSetUpVC") as! CaptureSetUpVC
        vc.img = choosenImage
        self.navigationController?.pushViewController(vc, animated: true)
        //cameraBtn.setImage(choosenImage, for: .normal)
    }
    
    @IBAction func clickToVideo(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CaptureStoryVC") as! CaptureStoryVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func clickToVideoPicture(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CapatureListVC") as! CapatureListVC
        vc.selectedFlag = 1
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
