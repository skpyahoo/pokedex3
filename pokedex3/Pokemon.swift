//
//  Pokemon.swift
//  pokedex3
//
//  Created by Sagar Pahlajani on 10/07/17.
//  Copyright © 2017 Sagar Pahlajani. All rights reserved.
//

import Foundation

class Pokemon {
    
    private var _name: String!
    private var _pokedexId: Int!
    
    var name: String
    {
        return _name
    }
    
    var pokedoxId: Int
    {
        return _pokedexId
    }
    
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
    }
    
}
