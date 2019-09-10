//
//  AboutMeVC.swift
//  iRemeber
//
//  Created by PC on 06/05/19.
//  Copyright © 2019 PC. All rights reserved.
//

import UIKit

class AboutMeVC: UIViewController , UITableViewDelegate, UITableViewDataSource , AddQueAnsChalangeTVCDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var testMeBtn: Button!
    
    var queDict : QuestionModel = QuestionModel()
    var dictArr : [QuestionModel] = [QuestionModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tblView.register(UINib(nibName: "CustomQueAnsTVC", bundle: nil), forCellReuseIdentifier: "CustomQueAnsTVC")
        testMeBtn.isUserInteractionEnabled = false
        testMeBtn.alpha = 0.6
        
        let dict1 : [QuestionModel] = CoreDataUtility.shared.fatchQuestionAnswer(TableName: "AboutMeQuestion")
        if dict1.count != 0 {
            print(dict1)
            dictArr = dict1
            tblView.reloadData()
        }else {
            addDict()
        }
        if dictArr.count > 4 {
            testMeBtn.isUserInteractionEnabled = true
            testMeBtn.alpha = 1
        }
        
    }
    
    func addDict()  {
        queDict = QuestionModel.init()
        queDict.id = getCurrentTimeStampValue()
        queDict.question = ""
        queDict.answer = ""
        dictArr.append(queDict)
        
        testMeBtn.isUserInteractionEnabled = dictArr.count < 6 ? false : true
        testMeBtn.alpha = dictArr.count < 6 ? 0.6 : 1
        
        tblView.reloadData()
        
        print(dictArr)
    }
   
    
    //MARK: - Button Click
    @IBAction func clickToBack(_ sender: Any) {
        updateData()
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func clickToAdd(_ sender: Any) {
        self.view.endEditing(true)
        if dictArr[dictArr.count - 1].question == "" {
            displayToast("Please enter question.")
        }
        else if dictArr[dictArr.count - 1].answer == "" {
            displayToast("Please enter answer.")
        }
        else {
            addDict()
        }
    }
    
    @IBAction func clickToTestMe(_ sender: Any) {
        updateData()
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "EditQuestionVC") as! EditQuestionVC
        self.navigationController?.pushViewController(vc, animated: true)
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
        let cell = tblView.dequeueReusableCell(withIdentifier: "CustomQueAnsTVC", for: indexPath) as! CustomQueAnsTVC
        
        cell.queTxt.placeholder = "Title"
        cell.ansTxt.placeholder = "Description"
        
        let dict : QuestionModel = dictArr[(indexPath.row)]
        cell.delegate = self
        
        //cell.queTxt.tag = indexPath.row
        cell.queTxt.text = dict.question
        
        //cell.ansTxt.tag = indexPath.row
        cell.ansTxt.text = dict.answer
        cell.countLbl.text = String(indexPath.row + 1)
        
        cell.deleteBtn.tag = indexPath.row
        cell.deleteBtn.addTarget(self, action: #selector(self.clickToDeleteQueAns), for: .touchUpInside)
        
        cell.index = indexPath.row
        return cell
    }
    
    func updateQueAnsChalangeText(_ text: String, _ index: Int) {
        self.view.endEditing(true)
        dictArr[(index)].question = text
        print(dictArr)
        tblView.reloadData()
      //  tblView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        
    }
    
    func updateAnsChalangeText(_ text: String, _ index: Int) {
        self.view.endEditing(true)
        dictArr[(index)].answer = text
        print(dictArr)
        tblView.reloadData()
     //   tblView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }
    
    @objc func clickToDeleteQueAns(sender : UIButton)  {
        self.view.endEditing(true)
        showAlertWithOption("Confirmation", message: "Are you sure you want to delete this question.", completionConfirm: {
            CoreDataUtility.shared.deleteQuestion(order: self.dictArr[sender.tag], TableName: "AboutMeQuestion")
            self.dictArr.remove(at: sender.tag)
            if self.dictArr.count == 0 {
                self.addDict()
            }
            self.testMeBtn.isUserInteractionEnabled = self.dictArr.count < 6 ? false : true
            self.testMeBtn.alpha = self.dictArr.count < 6 ? 0.6 : 1
            self.tblView.reloadData()
        }) {
            
        }
    }
    
    func updateData()  {
        self.view.endEditing(true)
        for item in dictArr {
            if item.answer != "" && item.question != "" {
                if let data : Bool =  CoreDataUtility.shared.selectQuestionAnswer(item: item, TableName: "AboutMeQuestion") , data == true {
                    CoreDataUtility.shared.updateItem(item: item, TableName: "AboutMeQuestion")
                }
                else {
                    CoreDataUtility.shared.saveQuestionAnswer(Model: item, TableName: "AboutMeQuestion")
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
