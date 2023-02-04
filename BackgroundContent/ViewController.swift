//
//  ViewController.swift
//  BackgroundContent
//
//  Created by Ángel González on 04/02/23.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    lazy var urlLocal: URL? = {
        var tmp = URL(string: "")
        if let documentsURL = FileManager.default.urls(for:.documentDirectory, in: .userDomainMask).first {
            tmp = documentsURL.appendingPathComponent("Articles.pdf")
        }
        return tmp
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Validamos si el archivo existe localmente
        if FileManager.default.fileExists(atPath:urlLocal?.path ?? "") {
            // Mostrar el archivo
            let webView = WKWebView(frame:self.view.bounds)
            let elReq = URLRequest(url: urlLocal!)
            webView.load(elReq)
            self.view.addSubview(webView)
        }
        else {
            // El archivo no existe, descargarlo y guardarlo
            if InternetMonitor.instance.internetStatus {
                // si hay conexion a Internet
                guard let laURL = URL(string: "http://janzelaznog.com/DDAM/iOS/vim/Articles.pdf") else { return }
                // Implementación de descarga en background con URLSession
                //1. Establecemos la configuracion para la sesión o usamos la basica
                let configuration = URLSessionConfiguration.ephemeral
                //2.Creamos la sesión de descarga, con la configuración elegida
                let session = URLSession(configuration: configuration)
                //3. Creamos el request para especificar lo que queremos obtener
                let elReq = URLRequest (url: laURL)
                //4. Creamos la tarea especifica de descarga
                let task = session.dataTask(with: elReq) { bytes, response, error in
                    // Que queremos que pase al recibir el response:
                    if error == nil {
                        guard let data = bytes else { return }
                        do {
                            try data.write(to:self.urlLocal!)
                        }
                        catch {
                            print ("Error al guardar el archivo " + String(describing: error))
                        }
                    }
                }
                // iniciamos la tarea
                task.resume()
            }
        }
    }
}

