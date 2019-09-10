//
//  ViewController.swift
//  iRemeber
//
//  Created by PC on 06/05/19.
//  Copyright © 2019 PC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var popupView: UIView!
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var headerLbl: Label!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let name : String = fatchUserNameData(TableName: "UserName") , name != "" {
            headerLbl.text = "Hello " + name
            popupView.isHidden = true
        }
        else {
            popupView.isHidden = false
        }
        
        
        
//        if getUserName() != nil {
//            popupView.isHidden = true
//            headerLbl.text = "Hello " + getUserName()!
//        }
//        else {
//            popupView.isHidden = false
//        }
        
        displaySubViewtoParentView(self.view, subview: popupView)
        
    }

    //MARK: - Button Click
    
    @IBAction func clickToMemoryPractice(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MemoryPracticeVC") as! MemoryPracticeVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func clickToCapture(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CaptureVC") as! CaptureVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func clickToMemories(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MemoriesVC") as! MemoriesVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func clickToLocator(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LocatorVC") as! LocatorVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func clickToSubmit(_ sender: Any) {
        self.view.endEditing(true)
        
        if (nameTxt.text?.trimmingCharacters(in: .whitespaces).isEmpty)! {
            displayToast("Please enter username.")
        }
        else {
            popupView.isHidden = true
            headerLbl.text = "Hello " + nameTxt.text!
            saveUserNameData(username: nameTxt.text!, TableName: "UserName")
        }
    }
    
    @IBAction func clickToAddUserName(_ sender: Any) {
        popupView.isHidden = false
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

