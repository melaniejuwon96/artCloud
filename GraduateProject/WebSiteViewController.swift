//
//  WebSiteViewController.swift
//  GraduateProject
//
//  Created by 유주원 on 07/11/2018.
//  Copyright © 2018 유주원. All rights reserved.
//

import UIKit
import WebKit

class WebSiteViewController: UIViewController, WKUIDelegate {
    
    var webView: WKWebView!
    
    override func loadView(){
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        // navigation title
        self.navigationItem.title = "ArtCloud"
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem

        // webView
        guard let url = URL(string: "https://www.google.co.kr/imghp?hl=ko") else {return}
        UIApplication.shared.open(url)
//        let url = URL(string: "https://www.google.co.kr/imghp?hl=ko")
//        let myRequest = URLRequest(url: url!)
//        webView.load(myRequest)
    }

}
