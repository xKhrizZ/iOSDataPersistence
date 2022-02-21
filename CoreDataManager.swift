//
//  DataPersistence.swift
//  iOSDataPersistence
//
//  Created by Christian Rojas on 18/02/22.
//

import Foundation
import CoreData

public class CoreDataManager {
    
    public static let shared = CoreDataManager()
    
    let identifier: String  = "gonet.iOSDataPersistence"
    let model: String       = "CoreDataModel"
    let entitieName: String     = "Movie"
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let bundle = Bundle(identifier: self.identifier)
        let momURL = bundle!.url(forResource: self.model, withExtension: "momd")!
        let managedObjectModel = NSManagedObjectModel(contentsOf: momURL)!
        let container = NSPersistentContainer(name: self.model, managedObjectModel: managedObjectModel)
        container.loadPersistentStores { storeDescription, error in
            if let err = error {
                fatalError("Loading of store failed:\(err)")
            }
        }
        return container
    }()
    
    func addMovie(with id: Int, with data: String) {
        let movie = NSEntityDescription.insertNewObject(forEntityName: entitieName, into: persistentContainer.viewContext)
        
        movie.setValue(id, forKey: "id")
        movie.setValue(data, forKey: "data")
        
        try? persistentContainer.viewContext.save()
    }
    
    func fetchMovie(with idSection: Int) -> Movie? {
        let fetchRequest: NSFetchRequest<Movie> = Movie.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "%K == %@", argumentArray: ["id",idSection])
        return try? persistentContainer.viewContext.fetch(fetchRequest).first
    }
    
    func fetchMovieCount() -> Int? {
        let fetchRequest: NSFetchRequest<Movie> = Movie.fetchRequest()
        return try? persistentContainer.viewContext.fetch(fetchRequest).count
    }
    
    func removeMovie(with idSection: Int) {
        let fetchRequest: NSFetchRequest<Movie> = Movie.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "%K == %@", argumentArray: ["id",idSection])
        
        do {
            guard let movie = try persistentContainer.viewContext.fetch(fetchRequest).first else {
                return
            }
            
            persistentContainer.viewContext.delete(movie)
            try? persistentContainer.viewContext.save()
        } catch let error {
            print("Failed to delete move \(error)")
        }
    }
    
    func removeAllRecords() {
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entitieName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do
        {
            try persistentContainer.viewContext.execute(deleteRequest)
            try persistentContainer.viewContext.save()
        }
        catch
        {
            print ("There was an error")
        }
        
    }
    
}
