//
//  PokeAnnotation.swift
//  PokeFinder
//
//  Created by Alexander Kaplan on 7/28/16.
//  Copyright © 2016 develop. All rights reserved.
//

import Foundation
import MapKit

class PokeAnnotation: NSObject, MKAnnotation {
    var coordinate = CLLocationCoordinate2D()
    var pokemonNumber: Int
    var pokemonName: String
    var title: String?
    var ds = DataService.instance
    
    init(coordinate: CLLocationCoordinate2D, pokemonNumber: Int) {
        self.coordinate = coordinate
        self.pokemonNumber = pokemonNumber
        self.pokemonName = ds.pokemon[pokemonNumber - 1].capitalized
        self.title = self.pokemonName
    }
}
