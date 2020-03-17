//
//  clsArticleEntityTests.swift
//  iosTestTests
//
//  Created by Vivek Gajbe on 3/17/20.
//  Copyright © 2020 Intelegain. All rights reserved.
//

import XCTest
@testable import iosTest

class clsArticleEntityTests: XCTestCase {
    
    var entEmailedArticle:clsArticleEntity!
    var entViewedArticle:clsArticleEntity!
    // var sharedArticle:clsArticleEntity!
    
    
    override func setUp() {
        super.setUp()
   
        entEmailedArticle = clsArticleEntity(strTitle: "Corona", strurl: "https://www.nytimes.com/reuters/2020/03/03/business/28reuters-china-health-constellation.html", strabstract: "Corona virus spread by:", strupdated: "2020-03-04")

        entViewedArticle = clsArticleEntity(strTitle: "Sport", strurl: "https://www.nytimes.com/2003/05/23/science/sciencespecial/scientists-find-animal-link-for-sars-virus.html", strabstract: "All registered readers have free access:", strupdated: "2020-03-04")
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        super.tearDown()
        
        entEmailedArticle = nil
        entViewedArticle = nil
        // sharedArticle = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() {
        
        //TODO: - test cases for email article Entity
        
        //1. check for entEmailedArticle empty Title
        XCTAssertTrue(entEmailedArticle.hasTitle)
        XCTAssertFalse(entEmailedArticle.strTitle.isEmpty)
        
        //2. check for entEmailedArticle non empty Url
        XCTAssertFalse(entEmailedArticle.strurl.isEmpty)

        //3. check for entEmailedArticle empty Title
        XCTAssertFalse(entEmailedArticle.strabstract.isEmpty)
        
        //4. check for entEmailedArticle empty Title
        XCTAssertFalse(entEmailedArticle.strupdated.isEmpty)

        //5.check entEmailedArticle strTitle is equal to corono or not
        XCTAssertEqual(entEmailedArticle.strTitle, "Corona")
        
        //6. check entEmailedArticle strTitle character is more than 0
        XCTAssert(entEmailedArticle.strTitle.count > 0)
        XCTAssertTrue(entEmailedArticle.strTitle.count > 0)
        
        //7. check url is valid or not
        XCTAssertTrue((URL(string: entEmailedArticle.strurl) != nil))
 
        //TODO: - test cases for Viewed Article Entity
        
        //1. check for entEmailedArticle empty Title
        XCTAssertTrue(entViewedArticle.hasTitle)
        XCTAssertFalse(entViewedArticle.strTitle.isEmpty)
        
        //2. check for entEmailedArticle non empty Url
        XCTAssertFalse(entViewedArticle.strurl.isEmpty)
        
        //3. check for entEmailedArticle empty Title
        XCTAssertFalse(entViewedArticle.strabstract.isEmpty)
        
        //4. check for entEmailedArticle empty Title
        XCTAssertFalse(entViewedArticle.strupdated.isEmpty)
        
        //5.check entEmailedArticle strTitle is equal to corono or not
        XCTAssertEqual(entViewedArticle.strTitle, "Corona")
        
        //6. check entEmailedArticle strTitle character is more than 0
        XCTAssert(entViewedArticle.strTitle.count > 0)
        XCTAssertTrue(entViewedArticle.strTitle.count > 0)
        
        //7. check url is valid or not
        XCTAssertTrue((URL(string: entViewedArticle.strurl) != nil))
        
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    //test if title text modified

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
