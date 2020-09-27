//
//  DetailViewController.swift
//  Project16
//
//  Created by Stomach Diego on 9/27/20.
//  Copyright © 2020 Mansur Nasybullin. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    var progressView: UIProgressView!
    
    var webView:WKWebView!
    var infoURL: String?
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let infoURL = infoURL else { return }
        
        webView.load(URLRequest(url: URL(string: infoURL)!))
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        toolbarItems = [progressButton]
        navigationController?.isToolbarHidden = false
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
            if progressView.progress == 1.0 {
                navigationController?.isToolbarHidden = true
            }
        }
    }

    

}
