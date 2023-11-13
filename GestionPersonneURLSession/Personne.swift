//
//  Personne.swift
//  GestionPersonneURLSession
//
//  Created by Abdelaziz Mezri on 13/11/2023.
//

import Foundation

struct Personne: Decodable, Encodable {
    let id: Int
    let nom: String
    let prenom: String
}
