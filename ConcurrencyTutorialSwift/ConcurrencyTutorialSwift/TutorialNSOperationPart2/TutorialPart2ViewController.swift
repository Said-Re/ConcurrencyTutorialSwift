//
//  TutorialPart2ViewController.swift
//  ConcurrencyTutorialSwift
//
//  Created by Said Rehouni on 3/9/15.
//  Copyright (c) 2015 Rehouni. All rights reserved.
//

import UIKit

class TutorialPart2ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        /* Creamos un UIImageView y lo añadimos al view controlelr*/
        let imageView = UIImageView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height * 0.5))
        
        self.view.addSubview(imageView)
        
        /* Creamos un objeto de nuestra clase personalizada*/
        let operation = DownloadImageOperation()
        /* La propiedad completionBlock nos permite añadir un bloque de codigo que se ejecutara
        cuando nuestra operacion finalice (callback)*/
        operation.completionBlock = {
            () -> Void in
            /* Una vez que la imagen se descargue, sera mostrada su referencia por consola*/
            print(operation.image)
            /* Asignamos la imagen que descargamos a nuestra imageView. Todo los cambios relacionados
            con la interfaz de usuario DEBEN REALIZARSE EN EL HILO PRINCIPAL. Esto lo haremos con 
            GCD.*/
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                imageView.image = operation.image
            })
        }
        // Y finalmente ejecutamos la operacion
        operation.start()
        
        /* Para comprobar que la imagen se descarga de forma asincrona, vamos a ejecutar un
        for en el hilo principal*/
        
        for var i = 0; i < 99999 ; i++ {
            print("\n \(i)")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
