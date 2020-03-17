//
//  VGConstants.swift
//  iosTest
//
//  Created by Vivek Gajbe on 3/16/20.
//  Copyright © 2020 Intelegain. All rights reserved.
//

import UIKit

class VGConstants: NSObject {

    static let uiScreen: UIScreen = UIScreen.main
    static let APP_DEL : AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //API : method name constants
    static let apiKey = "ekoBUDM27PqmmdkfGcko8YnAv7GaWTIg"
    static let commonUrl = "https://api.nytimes.com/svc/"
    
    static let getEmailedArticleList = "mostpopular/v2/emailed/7.json?api-key=\(apiKey)"
    static let getSharedArticleList = "mostpopular/v2/shared/1/facebook.json?api-key=\(apiKey)"
    static let getViewedArticleList = "mostpopular/v2/viewed/1.json?api-key=\(apiKey)"
    
    static let getSearchArticleList = "search/v2/articlesearch.json?q="
    
//    https://api.nytimes.com/svc/mostpopular/v2/emailed/7.json?api-key=ekoBUDM27PqmmdkfGcko8YnAv7GaWTIg
//    https://api.nytimes.com/svc/mostpopular/v2/shared/1/facebook.json?api-key=ekoBUDM27PqmmdkfGcko8YnAv7GaWTIg
//    https://api.nytimes.com/svc/mostpopular/v2/viewed/1.json?api-key=ekoBUDM27PqmmdkfGcko8YnAv7GaWTIg
//
//    https://api.nytimes.com/svc/search/v2/articlesearch.json?q=election&api-key=ekoBUDM27PqmmdkfGcko8YnAv7GaWTIg
    
//    App key : 75f252e2-6e68-44a1-a87a-b7f468767d82
//
//    Api key : ekoBUDM27PqmmdkfGcko8YnAv7GaWTIg 
//    secret key: 9fQ0BmGe58A5fHeW

}
