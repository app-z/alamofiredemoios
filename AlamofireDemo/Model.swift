//
//  Model.swift
//  AlamofireDemo
//
//  Created by Dmitry on 10/25/18.
//  Copyright © 2018 Dmitry. All rights reserved.
//

import Foundation



struct Movie : Codable {
    let id: String
    let poster: String
}

struct MovieDetails : Codable {
    let title: String
    let poster: String?
    let summary: String?
    let cast: String?
    let director: String?
    let year: String?
    let trailer: String?
}



