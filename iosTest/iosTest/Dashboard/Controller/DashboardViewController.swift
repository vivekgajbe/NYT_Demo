//
//  DashboardViewController.swift
//  iosTest
//
//  Created by Vivek Gajbe on 3/16/20.
//  Copyright © 2020 Intelegain. All rights reserved.
//

import UIKit


class DashboardViewController: BaseViewController {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setControllerPrefrances()
        // Do any additional setup after loading the view.
    }
    //MARK: - user define method
    func setControllerPrefrances()
    {
        navigationItem.title = "NYT"
    }
    @IBAction func btnMostViewClicked(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ArticleListViewController") as! ArticleListViewController
        vc.getScreenData(Screentype: .ViewedArticle)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnMostSharedClicked(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ArticleListViewController") as! ArticleListViewController
        vc.getScreenData(Screentype: .SharedArticle)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnMostEmailedClicked(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ArticleListViewController") as! ArticleListViewController
         vc.getScreenData(Screentype: .EmailedArticle)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
