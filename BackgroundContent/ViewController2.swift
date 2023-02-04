//
//  ViewController2.swift
//  BackgroundContent
//
//  Created by Ángel González on 04/02/23.
//

import UIKit

class ViewController2: UIViewController {
    
    let imgContainer = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgContainer.backgroundColor = .red
        self.view.addSubview(imgContainer)
    }
    
    override func viewWillLayoutSubviews() {
        let sa = view.safeAreaLayoutGuide
        imgContainer.translatesAutoresizingMaskIntoConstraints = false
        imgContainer.topAnchor.constraint(equalTo: sa.topAnchor, constant: 10).isActive = true
        imgContainer.bottomAnchor.constraint(equalTo: sa.bottomAnchor, constant: -10).isActive = true
        imgContainer.leftAnchor.constraint(equalTo: sa.leftAnchor, constant: 10).isActive = true
        imgContainer.rightAnchor.constraint(equalTo: sa.rightAnchor, constant: -10).isActive = true
    }

    override func viewWillAppear(_ animated: Bool) {
        if InternetMonitor.instance.internetStatus {
            if let laURL = URL(string:"https://apod.nasa.gov/apod/image/2210/LDN673.jpg") {
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
                        DispatchQueue.main.async {
                            self.imgContainer.image = UIImage(data: data)
                        }
                    }
                }
                // iniciamos la tarea
                task.resume()
                /* NO HAGAN ESTO EN SU CASA
                do {
                    let bytes = try Data(contentsOf: laURL)
                    imgContainer.image = UIImage(data: bytes)
                }
                catch {
                    print ("Error, no se pudo descargar la imagen: " + String(describing: error))
                }*/
            }
        }
    }

}
