//
//  PracticeVC.swift
//  iRemeber
//
//  Created by PC on 06/05/19.
//  Copyright © 2019 PC. All rights reserved.
//

import UIKit

class PracticeVC: UIViewController, UITableViewDelegate, UITableViewDataSource, AddPracticeTVCDelegate  {

    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var noDataLbl: UILabel!
    
    var dictArr : [QuestionModel] = [QuestionModel]()
    var shuffleDictArr : [QuestionModel] = [QuestionModel]()
    var dict1 : [QuestionModel] = [QuestionModel]()
    
    var flagArr : [Bool] = [Bool]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tblView.register(UINib(nibName: "PracticeTVC", bundle: nil), forCellReuseIdentifier: "PracticeTVC")
        noDataLbl.isHidden = true
        shuffleDictArr = CoreDataUtility.shared.fatchQuestionAnswer(TableName: "ViewQuestion")
        dict1 = shuffleArray(shuffleDictArr)
        if dict1.count != 0 {
            for item in dict1 {
                let questionDict : QuestionModel = QuestionModel()
                questionDict.id = item.id
                questionDict.question = item.question
                dictArr.append(questionDict)
                flagArr.append(false)
            }
            tblView.reloadData()
        }
        else {
            noDataLbl.isHidden = false
        }
    }

    
    //MARK: - Button Click
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - TableView Delgate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dictArr.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tblView.dequeueReusableCell(withIdentifier: "PracticeTVC", for: indexPath) as! PracticeTVC
        let dict : QuestionModel = dictArr[indexPath.row]
        cell.delegate = self
        cell.questionLbl.text = dict.question
        cell.answerTxt.text = dict.answer
        cell.countLbl.text = String(indexPath.row + 1)
        
        let savedDict : QuestionModel = dict1[indexPath.row]
        
        if flagArr[indexPath.row] {
            cell.backView.isHidden = false
            cell.trueAnsLbl.text = savedDict.answer
        }
        else {
            cell.backView.isHidden = true
        }
        
        if dict.answer == "" {
            cell.imgView.isHidden = true
            cell.popUpBtn.isHidden = true
        }
        else if savedDict.answer == dict.answer {
            cell.imgView.isHidden = false
            cell.popUpBtn.isHidden = true
            cell.backView.isHidden = true
        }
        else if savedDict.answer != dict.answer {
            cell.imgView.isHidden = true
            cell.popUpBtn.isHidden = false
            cell.popUpBtn.tag = indexPath.row
            cell.popUpBtn.addTarget(self, action: #selector(self.clickToPopupBtn), for: .touchUpInside)
        }
        
        cell.index = indexPath.row
        return cell
    }
    
    func updateQueChalangeText(_ text: String, _ index: Int) {
        self.view.endEditing(true)
        dictArr[(index)].answer = text.trimmed
        print(dictArr)
        tblView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }
    
    @objc func clickToPopupBtn(sender : UIButton) {
        self.view.endEditing(true)
    //    let savedDict : QuestionModel = dict1[sender.tag]
        flagArr[sender.tag] = flagArr[sender.tag] == true ? false : true
        tblView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .automatic)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
