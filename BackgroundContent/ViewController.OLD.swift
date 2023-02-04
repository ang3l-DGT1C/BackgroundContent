//
//  ViewController.swift
//  BackgroundContent
//
//  Created by Ángel González on 04/02/23.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if InternetMonitor.instance.internetStatus {
            // si hay conexion a Internet
            guard let laURL = URL(string: "http://janzelaznog.com/DDAM/iOS/vim/Articles.pdf") else { return }
            let ac = UIAlertController(title: "hola", message:"Quiere abrir el documento aqui? o en el browser?", preferredStyle: .alert)
            let action = UIAlertAction(title: "en el browser", style: .default) {
                alertaction in
                // Este codigo se ejecutará cuando el usuario toque el botón
                // siempre hay que comprobar si una URL se puede "abrir" en el dispositivo
                if UIApplication.shared.canOpenURL(laURL) {
                    // si el s.o. comprueba que se puede abrir la URL, entonces la lanzamos
                    UIApplication.shared.open(laURL, options:[:])
                }
            }
            ac.addAction(action)
            let action2 = UIAlertAction(title: "aqui", style: .default) {
                alertaction in
                // Este codigo se ejecutará cuando el usuario toque el botón
                let webView = WKWebView(frame:self.view.bounds)
                let elReq = URLRequest(url: laURL)
                webView.load(elReq)
                self.view.addSubview(webView)
            }
            ac.addAction(action2)
            self.present(ac, animated: true)
        }
        
    }


}

