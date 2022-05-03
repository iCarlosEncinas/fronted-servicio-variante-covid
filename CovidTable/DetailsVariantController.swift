//
//  DetailsVariantController.swift
//  CovidTable
//
//  Created by Usuario invitado on 17/1/22.
//  Copyright © 2022 Usuario invitado. All rights reserved.
//

import Foundation
import UIKit

class DetailsVariantController : UIViewController {
    var variant : Variant?
    
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var imgEvidence: UIImageView!
    
    override func viewDidLoad() {
        if variant?.description == nil {
            let url = URL(string: "http://172.31.197.130:8000/api/variantes/\(variant!.id!)")!
                       var solicitud = URLRequest(url: url)
                       solicitud.httpMethod = "GET"
                       solicitud.allHTTPHeaderFields = [
                           "Accept" : "application/json"
                       ]
                       let task = URLSession.shared.dataTask(with: solicitud) {
                           data, request, error in
                           if let data = data {
                               //Tenemos algo en data
                            if let detalles_variante = try? JSONDecoder().decode(Variant.self, from: data) {
                                self.variant?.description = detalles_variante.description
                                self.variant?.evidence = detalles_variante.evidence
                                   DispatchQueue.main.async {
                                    self.lblDescription.text = self.variant!.description
                                    
                                   }
                                if self.variant?.evidence != nil{
                                self.cargarImagen()
                                }
                               } else {
                                   print("No se pudo interpretar respuesta")
                               }
                           } else if let error = error {
                               print(error.localizedDescription)
                           }
                       }
                       task.resume()
                
            } else {
            lblDescription.text = variant!.description!
            if variant?.evidence != nil{
                cargarImagen()
            }
                    
        }
        }
    func cargarImagen() {
    let url = URL(string: "http://172.31.197.130:8000/storage/evidences/\(variant!.evidence!)")!
    var solicitud = URLRequest(url: url)
    solicitud.httpMethod = "GET"
    
    let task = URLSession.shared.dataTask(with: solicitud) {
        data, request, error in
        if let data = data {
            //Tenemos algo en data
            DispatchQueue.main.async {
                self.imgEvidence.image = UIImage(data: data)
         
            }
            
        } else if let error = error {
            print(error.localizedDescription)
        }
    }
    task.resume()
        }
    }
