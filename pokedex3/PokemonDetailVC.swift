//
//  PokemonDetailVC.swift
//  pokedex3
//
//  Created by Sagar Pahlajani on 10/07/17.
//  Copyright © 2017 Sagar Pahlajani. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    var pokemon: Pokemon!

    @IBOutlet var nameLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nameLbl.text = pokemon.name
    }

   
}
