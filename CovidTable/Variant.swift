//
//  Variant.swift
//  CovidTable
//
//  Created by Usuario invitado on 17/1/22.
//  Copyright © 2022 Usuario invitado. All rights reserved.
//

import Foundation

class Variant : Decodable {
    var id : Int?
    var description : String?
    var lineage : String?
    var earliest_date : String?
    var designated_number : String?
    var assigned_number : String?
    var who_name : String?
    var common_countries : String?
    var evidence : String?
    
    /*init(_ description: String, _ lineage: String, _ date: String, _ designated: String, _ assigned: String, _ name: String) {
        self.description = description
        self.lineage = lineage
        self.date = date
        self.designated = designated
        self.assigned = assigned
        self.name = name
    }*/
}
