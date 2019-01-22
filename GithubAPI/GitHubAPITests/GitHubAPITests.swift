//
//  GitHubAPITests.swift
//  GitHubAPITests
//
//  Created by GILL/Samsung on 17/01/19.
//  Copyright © 2019 Demo. All rights reserved.
//

import XCTest
@testable import GitHubAPI

class GitHubAPITests: XCTestCase {
    var viewController: MainViewController!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        //MainViewController test....
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        viewController = storyboard.instantiateInitialViewController() as? MainViewController
        //2
        UIApplication.shared.keyWindow!.rootViewController = viewController
        //3
        XCTAssertNotNil(viewController.view)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAppsCollectionViewController(){
        let appsCollectionViewController = AppsCollectionViewController()
        XCTAssertNotNil(appsCollectionViewController.viewModel,"viewModel should not be nil")
        appsCollectionViewController.viewModel.apiClient = APIClient()
        appsCollectionViewController.fetchLatestData(with: "")
        XCTAssertNotNil(appsCollectionViewController.viewModel.apiClient,"apiClient should not be nil")
    }
    

}
