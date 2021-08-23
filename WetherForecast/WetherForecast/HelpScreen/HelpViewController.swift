//
//  HelpViewController.swift
//  WetherForecast
//
//  Created by Nitin Soni on 21/08/21.
//

import UIKit
import WebKit

class HelpViewController: UIViewController {

    @IBOutlet weak var webview: WKWebView!
    lazy var viewmodel = {
        HelpViewModel()
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.view.backgroundColor = UIColor.clear
        webview.navigationDelegate = self
        webview.isOpaque = false
        webview.backgroundColor = UIColor.clear
        webview.scrollView.backgroundColor = UIColor.clear
        loadRequest()
    }
    
    func loadRequest() {
//        guard let filePath = Bundle.main.path(forResource: "HelpScreen1", ofType: "html") else {return}
//        let urlRequest = URLRequest(url: URL(fileURLWithPath: filePath))
        viewmodel.getHelpScreenRequestToLoad { urlRequest in
            if let request = urlRequest {
            webview.configuration.userContentController.add(self, name: "buttonClicked")
            webview.load(request)
            }
        }
    }
}

extension HelpViewController: WKNavigationDelegate ,WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "buttonClicked" {
            self.view.removeFromSuperview()
            self.removeFromParent()
            self.didMove(toParent: nil)
        }
    }
}
