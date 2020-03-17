//
//  ArticleListViewController.swift
//  iosTest
//
//  Created by Vivek Gajbe on 3/16/20.
//  Copyright © 2020 Intelegain. All rights reserved.
//

import UIKit
enum screenArticleType
{
    case ViewedArticle
    case EmailedArticle
    case SharedArticle
    case SearchArticle
}
class ArticleListViewController: BaseViewController {
    //MARK: - outlet declaration
    var arrArticleList = [clsArticleEntity]()
    var Screentype:screenArticleType = .ViewedArticle
    @IBOutlet weak var tblArticle: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setControllerPrefrances()
        // Do any additional setup after loading the view.
    }
    //MARK: - user define method
    func setControllerPrefrances()
    {
        navigationItem.title = "Articles"

        tblArticle.dataSource = self;
        tblArticle.delegate = self;
        
        tblArticle.estimatedRowHeight = 60
        tblArticle.rowHeight = UITableView.automaticDimension
        
        switch Screentype
        {
        case .ViewedArticle:
            self.getMostViewedArticleList()
        case .SharedArticle:
            self.getMostSharedArticleList()
        case .EmailedArticle:
            self.getMostEmailedArticleList()
        case .SearchArticle:
           self.tblArticle.reloadData()
        }
    }
    func getScreenData(Screentype:screenArticleType)
    {
        self.Screentype = Screentype
    }
    //MARK: - api call
    //method is used for gettting viewed article list
    func getMostViewedArticleList()
    {
        let objRequest = RequestManager()
        let strUrl = VGConstants.commonUrl + VGConstants.getViewedArticleList
        
        let dictMyContact = [String:Any]()
        
        self.showSpinner(onView: self.view)
        objRequest.requestCommonApiMethodCall_WithParam(strAPIName: strUrl, strMethodType: "GET", strParameterName: dictMyContact)
        { (result, isSuccess, error) in
            self.removeSpinner()
            if isSuccess{
                let ent = clsArticleEntity()
                self.arrArticleList = ent.getParseArticleDetails(info: result as Dictionary<String, AnyObject>)
                if self.arrArticleList.count > 0
                {
                    self.tblArticle.reloadData()
                }
                self.tblArticle.isHidden = self.arrArticleList.count > 0 ? false : true
            }
            else
            {
                self.view.makeToast(message: error)
            }
        }
    }
    //method is used for gettting emailed article list
    func getMostEmailedArticleList()
    {
        let objRequest = RequestManager()
        let strUrl = VGConstants.commonUrl + VGConstants.getEmailedArticleList
        
        let dictMyContact = [String:Any]()
        
        self.showSpinner(onView: self.view)
        objRequest.requestCommonApiMethodCall_WithParam(strAPIName: strUrl, strMethodType: "GET", strParameterName: dictMyContact)
        { (result, isSuccess, error) in
            self.removeSpinner()
            if isSuccess{
                let ent = clsArticleEntity()
                self.arrArticleList = ent.getParseArticleDetails(info: result as Dictionary<String, AnyObject>)
                if self.arrArticleList.count > 0
                {
                    self.tblArticle.reloadData()
                }
                self.tblArticle.isHidden = self.arrArticleList.count > 0 ? false : true
            }
            else
            {
                self.view.makeToast(message: error)
            }
        }
    }
    //method is used for gettting share article list
    func getMostSharedArticleList()
    {
        let objRequest = RequestManager()
        let strUrl = VGConstants.commonUrl + VGConstants.getSharedArticleList
        
        let dictMyContact = [String:Any]()
        
        self.showSpinner(onView: self.view)
        objRequest.requestCommonApiMethodCall_WithParam(strAPIName: strUrl, strMethodType: "GET", strParameterName: dictMyContact)
        { (result, isSuccess, error) in
            self.removeSpinner()
            if isSuccess{
                let ent = clsArticleEntity()
                self.arrArticleList = ent.getParseArticleDetails(info: result as Dictionary<String, AnyObject>)
                if self.arrArticleList.count > 0
                {
                    self.tblArticle.reloadData()
                }
                self.tblArticle.isHidden = self.arrArticleList.count > 0 ? false : true
            }
            else
            {
                self.view.makeToast(message: error)
            }
        }
    }
}
//MARK: - extension for table view methods
extension ArticleListViewController : UITableViewDelegate
{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ent  = arrArticleList[indexPath.row]
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ArticleDetailsViewController") as! ArticleDetailsViewController
        vc.strUrl = ent.strurl 
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
//MARK: - extension for table view methods
extension ArticleListViewController : UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrArticleList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblArticle.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! clsArticleTableViewCell
        let ent = arrArticleList[indexPath.row]
        cell.lblTitle?.text = ent.strTitle
        cell.lblDate?.text = ent.strupdated
        cell.lblSourse?.text = ent.strabstract
        cell.viwBG.layer.cornerRadius = 10
        //cell.selectionStyle = .none
        return cell
    }
}

class clsArticleTableViewCell: UITableViewCell
{
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var viwBG: UIView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblSourse: UILabel!
}
