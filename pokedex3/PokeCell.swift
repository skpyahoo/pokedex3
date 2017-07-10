//
//  PokeCell.swift
//  pokedex3
//
//  Created by Sagar Pahlajani on 10/07/17.
//  Copyright © 2017 Sagar Pahlajani. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet var thumbImg: UIImageView!
    @IBOutlet var nameLbl: UILabel!
    
    var pokemon: Pokemon!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
    }
    
    func configureCell(pokemon: Pokemon)
    {
        self.pokemon = pokemon
        
        nameLbl.text = self.pokemon.name.capitalized
        thumbImg.image = UIImage(named: "\(self.pokemon.pokedoxId)")
    }
}
