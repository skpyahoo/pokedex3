//
//  Pokemon.swift
//  pokedex3
//
//  Created by Sagar Pahlajani on 10/07/17.
//  Copyright © 2017 Sagar Pahlajani. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    private var _name: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    private var _defence: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolutionTxt: String!
    private var _nextEvolutionName: String!
    private var _nextEvolutionId: String!
    private var _nextEvoltionLevel: String!
    private var _pokemonURL: String!
    
    var name: String
    {
        return _name
    }
    
    var pokedoxId: Int
    {
        return _pokedexId
    }
    
    var nextEvolutionTxt: String
    {
        if _nextEvolutionTxt == nil
        {
            _nextEvolutionTxt = ""
        }
        return _nextEvolutionTxt
    }
    
    var nextEvolutionName: String
    {
        if _nextEvolutionName == nil
        {
            _nextEvolutionName = ""
        }
        return _nextEvolutionName
    }
    
    var nextEvolutionId: String
    {
        if _nextEvolutionId == nil
        {
            _nextEvolutionId = ""
        }
        return _nextEvolutionId
    }
    
    var nextEvolutionLevel: String
    {
        if _nextEvoltionLevel == nil
        {
            _nextEvoltionLevel = ""
        }
        return _nextEvoltionLevel
    }
    
    var attack: String
    {
        if _attack == nil
        {
            _attack = ""
        }
        return _attack
    }
    
    var weight: String
    {
        if _weight == nil
        {
            _weight = ""
        }
        return _weight
    }
    
    var height: String
    {
        if _height == nil
        {
            _height = ""
        }
        return _height
    }
    
    var defence: String
    {
        if _defence == nil
        {
            _defence = ""
        }
        return _defence
    }
    
    var type: String
    {
        if _type == nil
        {
            _type = ""
        }
        return _type
    }
    
    var description: String
    {
        if _description == nil
        {
            _description = ""
        }
        return _description
    }
    
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
        
        self._pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(self.pokedoxId)/"
    }
    
    func downloadPokemonDetail(completed: @escaping DownloadComplete)
    {
        Alamofire.request(_pokemonURL).responseJSON { (response) in
            
            if let dict = response.result.value as? Dictionary<String, AnyObject>
            {
                if let weight = dict["weight"] as? String
                {
                    self._weight = weight
                }
                
                if let height = dict["height"] as? String
                {
                    self._height = height
                }
                
                if let attack = dict["attack"] as? Int
                {
                    self._attack = "\(attack)"
                }
                
                if let defense = dict["defense"] as? Int
                {
                    self._defence = "\(defense)"
                }
                
                print(self._weight, self._height, self._attack, self._defence)
                
                if let types = dict["types"] as? [Dictionary<String, AnyObject>] , types.count > 0
                {
                    if let name = types[0]["name"] as? String
                    {
                        self._type = name.capitalized
                    }
                    
                    if types.count > 1
                    {
                        for x in 1..<types.count
                        {
                            if let name = types[x]["name"] as? String
                            {
                                self._type! += "/\(name.capitalized)"
                            }
                        }
                    }
                    
                }
                else
                {
                    self._type = ""
                }
                
                if let descArr = dict["descriptions"] as? [Dictionary<String, AnyObject>] , descArr.count > 0
                {
                    if let url = descArr[0]["resource_uri"] as? String
                    {
                        let desURL = "\(URL_BASE)\(url)"
                        //print(desURL)
                        Alamofire.request(desURL).responseJSON(completionHandler: { (response) in
                            
                            if let descDict = response.result.value  as? Dictionary<String, AnyObject>
                            {
                                if let description = descDict["description"] as? String
                                {
                                    //print(description)
                                    let newDescription = description.replacingOccurrences(of: "POKEMON", with: "Pokemon")
                                    
                                    self._description = newDescription
                                }
                            }
                            
                            completed()

                        })
                }
            }
             else
                {
                    self._description = ""
                }
                
                if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>] , evolutions.count > 0
                {
                    if let nextEvo = evolutions[0]["to"] as? String
                    {
                        if nextEvo.range(of: "mega") == nil
                        {
                            self._nextEvolutionName = nextEvo.capitalized
                            
                            if let uri = evolutions[0]["resource_uri"] as? String
                            {
                                let newStr = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                let nextEvoId = newStr.replacingOccurrences(of: "/", with: "")
                                
                                self._nextEvolutionId = nextEvoId
                                
                                if let lvlExist = evolutions[0]["level"]
                                {
                                    if let lvl = lvlExist as? Int
                                    {
                                        self._nextEvoltionLevel = "\(lvl)"
                                    }
                                }
                                else
                                {
                                    self._nextEvoltionLevel = ""
                                }
                            }
                        }
                    }
                }
        }
            
        completed()
        
        }
    }
    
}
