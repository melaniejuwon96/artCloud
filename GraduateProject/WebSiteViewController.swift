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
        let url = URL(string: "https://www.google.com")
        let myRequest = URLRequest(url: url!)
        webView.load(myRequest)
        
        //API
//        let apiKey = "AIzaSyBARMfqG8nNwFTLnzPF9yl_rIhYp-WpyUI"
//        let bundleId = "$(PRODUCT_BUNDLE_IDENTIFIER)"
//        let searchEngineId = "008928181688018915079:gtnmo_fks9u"
//        let serverAddress = String(format: "https://www.googleapis.com/customsearch/v1?q=%@&cx=%@&key=%@","Your query here" ,searchEngineId, apiKey)
//
//
//        let Myurl = serverAddress.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
//        let finalUrl = URL(string: Myurl!)
//        let request = NSMutableURLRequest(url: finalUrl!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
//        request.httpMethod = "GET"
//        request.setValue(bundleId, forHTTPHeaderField: "X-Ios-Bundle-Identifier")
//
//        let session = URLSession.shared
//
//        let datatask = session.dataTask(with: request as URLRequest) { (data, response, error) in
//            do{
//                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary{
//                    print("asyncResult\(jsonResult)")
//                }
//
//            }
//            catch let error as NSError{
//                print(error.localizedDescription)
//            }
//        }
//        datatask.resume()
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
