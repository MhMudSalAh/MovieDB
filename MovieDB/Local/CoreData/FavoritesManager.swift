//
//  FavoritesManager.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 07/09/2021.
//

import UIKit
import CoreData

class FavoritesManager {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var context: NSManagedObjectContext?
    
    init() {
        let persistentContainer = appDelegate.persistentContainer
        context = persistentContainer.viewContext
    }
    
    // MARK:- STORE
    
    func store(_ model: Movie) -> Favorites? {
        let entity = NSEntityDescription.insertNewObject(forEntityName: "Favorites", into: context!) as! Favorites
        
        entity.setValue(model.id, forKey: "movieId")
        entity.setValue(model.title, forKey: "title")
        if model.image != nil {
            entity.setValue(model.imageURL(), forKey: "image")
        } else if model.coverURL() != nil {
            entity.setValue(model.coverURL(), forKey: "image")
        }
        
        entity.setValue(model.rate, forKey: "rate")

        do {
            try context?.save()
            return entity
        } catch let error {
            print("Could not store \(error.localizedDescription)")
            return nil
        }
    }
    
    // MARK:- RETRIEVE
    
    func retrieve() -> [Movie]? {
        let fetchRequest = NSFetchRequest<Favorites>(entityName: "Favorites")
        do {
            let results = try context?.fetch(fetchRequest)
            guard let data = results, !data.isEmpty else {
                return []
            }
            return mapData(data)
        } catch let error {
            print("Could not retrieve \(error.localizedDescription)")
            return nil
        }
    }
    
    // MARK:- MAPDATA

    func mapData(_ entities: [Favorites]) -> [Movie] {
        var index: Int = 1
        var models: [Movie] = []
        
        for entity in entities {
            
            let model: Movie = Movie()
            model.id = Int(entity.movieId)
            model.image = entity.image
            model.title = entity.title
            model.rate = Double(entity.rate)
            index += 1
                
            models.append(model)
        }
        return models
    }
    
    // MARK:- DELETE
    
    func delete(_ movieId: Int) {
        if let result = try? context?.fetch(Favorites.fetchRequest()) {
            for object in result as! [Favorites] {
                if object.movieId == movieId  {
                    context?.delete(object)
                }
            }
        }
    }
}
