//
//  ViewController.swift
//  CovidTable
//
//  Created by Usuario invitado on 17/1/22.
//  Copyright © 2022 Usuario invitado. All rights reserved.
//

import UIKit

class ListVariantController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tvVariants: UITableView!
    var variants : [Variant] = []
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return variants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellVariant") as! CellVariantController
        cell.lblLineage.text = variants[indexPath.row].lineage
        cell.lblDate.text = variants[indexPath.row].earliest_date
        cell.lblDesignated.text = variants[indexPath.row].designated_number
        cell.lblAssigned.text = variants[indexPath.row].assigned_number
        cell.lblName.text = variants[indexPath.row].who_name
        
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        inicializarVariantes()
    }
    
    func inicializarVariantes() {
        let url = URL(string: "http://172.31.197.130:8000/api/variantes")!
        var solicitud = URLRequest(url: url)
        solicitud.httpMethod = "GET"
        solicitud.allHTTPHeaderFields = [
            "Accept" : "application/json"
        ]
        let task = URLSession.shared.dataTask(with: solicitud) {
            data, request, error in
            if let data = data {
                //Tenemos algo en data
                if let variantes_data = try? JSONDecoder().decode([Variant].self, from: data) {
                    DispatchQueue.main.async {
                        self.variants = variantes_data
                        self.tvVariants.reloadData()
                    }
                    
                } else {
                    print("No se pudo interpretar respuesta")
                }
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destino = segue.destination as! DetailsVariantController
        destino.variant = variants[tvVariants.indexPathForSelectedRow!.row]
    }
}

