//
//  clsArticleEntity.swift
//  iosTest
//
//  Created by Vivek Gajbe on 3/16/20.
//  Copyright © 2020 Intelegain. All rights reserved.
//

import Foundation

class clsArticleEntity 
{
    var strTitle : String = ""
    var strurl : String = ""
    var strabstract: String = ""
    var strupdated : String = ""
    
    //check title in testcase
    var hasTitle: Bool {
        return !strTitle.isEmpty
    }
    
    //check url in testcase
    var hasurl: Bool {
        return !strurl.isEmpty
    }

    //set empty init
    init() {
    }

    //this init is used in article testcase
    init(strTitle:String,strurl:String,strabstract:String,strupdated:String) {
        self.strTitle = strTitle
        self.strurl = strTitle
        self.strabstract = strabstract
        self.strupdated = strupdated
    }
    
    /// parsing Method for article list api
    func getParseArticleDetails(info : Dictionary<String,AnyObject>)->[clsArticleEntity]{
        var arrData = [clsArticleEntity]()
    
        if let data = info["results"] as? [[String:AnyObject]]
        {
            for item in data
            {
                let ent = clsArticleEntity()
                ent.strTitle = item["title"] as? String ?? ""
                ent.strurl = item["url"] as? String ?? ""
                ent.strabstract = item["abstract"] as? String ?? ""
                ent.strupdated = item["published_date"] as? String ?? ""
                arrData.append(ent)
            }
        }
        return arrData
    }
    /// parsing Method for Search article list api  
    func getParseSearchArticleDetails(info : Dictionary<String,AnyObject>)->[clsArticleEntity]{
        var arrData = [clsArticleEntity]()
        if let res = info["response"] as? [String:AnyObject]
        {
            if let data = res["docs"] as? [[String:AnyObject]]
            {
                for item in data
                {
                    let ent = clsArticleEntity()
                    ent.strTitle = item["headline"]?["print_headline"] as? String ?? ""
                    ent.strurl = item["web_url"] as? String ?? ""
                    ent.strabstract = item["abstract"] as? String ?? ""
                    ent.strupdated = item["pub_date"] as? String ?? ""
                    arrData.append(ent)
                }
            }
        }
        return arrData
    }
}


