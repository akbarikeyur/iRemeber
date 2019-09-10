//
//  DailyQuestionVC.swift
//  iRemeber
//
//  Created by PC on 06/05/19.
//  Copyright © 2019 PC. All rights reserved.
//

import UIKit
import EventKit

class DailyQuestionVC: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()

    
    }

    
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clciKToPractice(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PracticeVC") as! PracticeVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func clickToViewQuestion(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewQuestionVC") as! ViewQuestionVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func clickToSelectAlarm(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainAlarmViewController") as! MainAlarmViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
