//
//  PokedexVC.swift
//  PokeFinder
//
//  Created by Alexander Kaplan on 7/28/16.
//  Copyright © 2016 develop. All rights reserved.
//

import UIKit

class PokedexVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var allPokemon = [Pokemon]()
    var inSearchMode = false
    var filteredPokemon = [Pokemon]()
    var ds = DataService.instance
    var pokeNames: [String]!
    var count = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokeNames = ds.pokemon
        print(pokeNames)
        for pokeName in pokeNames{
            let poke = Pokemon(name: pokeNames[self.count-1], id: self.count)
            allPokemon.append(poke)
            self.count += 1
        }
        
        for poke in allPokemon{
            print(poke.name)
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let poke: Pokemon!
        
        if !inSearchMode{
            poke = allPokemon[indexPath.row]
        }else{
            poke = filteredPokemon[indexPath.row]
        }
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell{
            cell.configureCell(pokemon: poke)
            return cell
        }else{
            let cell = PokeCell()
            cell.configureCell(pokemon: poke)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentPoke: Pokemon!
        
        if inSearchMode{
            currentPoke = filteredPokemon[indexPath.row]
        }else{
            currentPoke = allPokemon[indexPath.row]
        }
        
        ds.choosenPokemon = currentPoke
        NotificationCenter.default.post(name: "postPokemonLocation" as NSNotification.Name, object: nil)
        dismiss(animated: true) { 
            
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSearchMode{
            return filteredPokemon.count
        }
        return allPokemon.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == ""{
            inSearchMode = false
            collectionView.reloadData()
            view.endEditing(true)
        }else{
            inSearchMode = true
            let lower = searchBar.text!.lowercased()
            filteredPokemon = allPokemon.filter({$0.name.range(of: lower) != nil})
            collectionView.reloadData()
        }
    }
    
    @IBAction func cancelEntry(sender: UIButton){
        dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
