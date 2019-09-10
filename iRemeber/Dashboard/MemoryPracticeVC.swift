//
//  MemoryPracticeVC.swift
//  iRemeber
//
//  Created by PC on 06/05/19.
//  Copyright © 2019 PC. All rights reserved.
//

import UIKit

class MemoryPracticeVC: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    //MARK :- Button Click
    @IBAction func clickToDailyQuestion(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DailyQuestionVC") as! DailyQuestionVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func clickToAboutMe(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AboutMeVC") as! AboutMeVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
