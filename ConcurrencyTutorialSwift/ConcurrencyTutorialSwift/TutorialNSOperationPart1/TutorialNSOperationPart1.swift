//
//  TutorialNSOperationPart1.swift
//  ConcurrencyTutorialSwift
//
//  Created by Said Rehouni on 2/9/15.
//  Copyright (c) 2015 Rehouni. All rights reserved.
//

import UIKit

class TutorialNSOperationPart1: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Creamos un objeto NSBlockOperation con un bloque que muestra por pantalla los numeros del 0-9999
        let operation = NSBlockOperation(
            block: { () -> Void in
                for var i = 0; i < 9999; i++ {
                    print("\n\(i)")
                }
        })
        
        //Creamos otro objeto NSBlockOperation que muestre el caracter '*'
        let operation2 = NSBlockOperation(
            block: { () -> Void in
                for var i = 0; i < 9999; i++ {
                    print("\n*")
                }
        })
        
        /* Y ejecutamos el metodo addDependency introduciendo como parametro el primer operation que creamos anteriormente */
        operation2.addDependency(operation)
        
        //Creamos una NSOperationQueue y le añadimos nuestro objeto operation
        let myQueue = NSOperationQueue.mainQueue()
        myQueue.addOperations([operation, operation2], waitUntilFinished: false)
        
        //Se ejecuta en el hilo principal
        for var i = 0; i < 9999; i++ {
            print("a")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}