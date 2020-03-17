//
//  SearchViewController.swift
//  iosTest
//
//  Created by Vivek Gajbe on 3/16/20.
//  Copyright © 2020 Intelegain. All rights reserved.
//

import UIKit

class SearchViewController: BaseViewController,UITextFieldDelegate {

    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var btnSearch: UIButton!
    var arrArticleList = [clsArticleEntity]()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Search"
        btnSearch.layer.cornerRadius = btnSearch.frame.height / 2
        // Do any additional setup after loading the view.
    }
    func validateData() -> Bool
    {
        if txtSearch.text == ""
        {
            self.view.makeToast(message: "Please enter valid data")
        }
        return true
    }
    @IBAction func btnSearchClicked(_ sender: Any) {
        if validateData()
        {
            let objRequest = RequestManager()
            let strUrl = VGConstants.commonUrl + VGConstants.getSearchArticleList + "\(txtSearch.text!)&api-key=\(VGConstants.apiKey)"
            
            let dictMyContact = [String:Any]()
            
            self.showSpinner(onView: self.view)
            objRequest.requestCommonApiMethodCall_WithParam(strAPIName: strUrl, strMethodType: "GET", strParameterName: dictMyContact)
            { (result, isSuccess, error) in
                self.removeSpinner()
                if isSuccess{
                    //print(result)
                    let ent = clsArticleEntity()
                    self.arrArticleList = ent.getParseSearchArticleDetails(info: result as Dictionary<String, AnyObject>)
                    if self.arrArticleList.count > 0
                    {
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ArticleListViewController") as! ArticleListViewController
                        vc.arrArticleList = self.arrArticleList
                        vc.getScreenData(Screentype: .SearchArticle)
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                    else
                    {
                        self.view.makeToast(message: "No record found")
                    }
                }
                else
                {
                    self.view.makeToast(message: error)
                }
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
