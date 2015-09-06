//
//  DownloadImageOperation.swift
//  ConcurrencyTutorialSwift
//
//  Created by Said Rehouni on 3/9/15.
//  Copyright (c) 2015 Rehouni. All rights reserved.
//

import UIKit

class DownloadImageOperation: NSOperation {
    
    /* La propiedad executing nos indica si la operacion se esta ejecutando o no. Al ser read-only, tendremos que sobreescribir los metodos get y set para que podamos modificarla manualmente.*/
    override var executing : Bool {
        get { return _executing }
        set {
            /*Los metodos willChangeValueForKey y didChangeValueForKey sirven para indicar al
             key-value observing (KVO) que la propiedad se va a modificar. */
            willChangeValueForKey("isExecuting")
            _executing = newValue
            didChangeValueForKey("isExecuting")
        }
    }
    private var _executing : Bool = false
    
    /* La propiedad finished nos indica si la operacion ha finalizado*/
    override var finished: Bool {
        get { return _finished }
        set {
            willChangeValueForKey("isExecuting")
            _finished = newValue
            didChangeValueForKey("isExecuting")
        }
    }
    private var _finished : Bool = false
    
    /* Con esta propiedad indicamos a la operacion que puede ejecutarse de manera asynchronous. Esto nos es util si no queremos usar NSOperationQueue. El problema de esto es que tendremos que manejar los estados manualmente */
    override var asynchronous : Bool {
        get { return true }
    }
    
    var image : UIImage? = nil
    
    /* Sobreescribimos el metodo main e implementamos el codigo para descargar una imagen sincrona. Una vez finalizada la 
    descarga, almacenamos la imagen y actualizamos el estado*/
    override func main() {
        executing = true
        if let url = NSURL(string: "http://images.apple.com/support/assets/images/products/programs/hero_programs.jpg") {
            if let data = NSData(contentsOfURL: url){
                image = UIImage(data: data)
            }
        }
        executing = false
        finished = true
    }
    
   
}
