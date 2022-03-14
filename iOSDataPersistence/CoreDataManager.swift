//
//  DataPersistence.swift
//  iOSDataPersistence
//
//  Created by Christian Rojas on 18/02/22.
//

import Foundation
import CoreData
//import iOSBusinessDomain
//import iOSSecurity

public class CoreDataManager {
    
    public static let shared = CoreDataManager()
    
    let model: String       = "CoreDataModel"
    let entitieName: String     = "Movie"
    
    private lazy var persistentContainer: NSPersistentContainer? = {
        
        let modelURL = Bundle(for: CoreDataManager.self).url(forResource: self.model, withExtension: "momd")

        var container: NSPersistentContainer
        
        guard let model = modelURL.self.flatMap(NSManagedObjectModel.init) else {
          print("Fail to load the trigger model!")
          return nil
        }
        
        container = NSPersistentContainer(name: self.model, managedObjectModel: model)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
          if let error = error as NSError? {
            print("Unresolved error \(error), \(error.userInfo)")
          }
        })
        
        return container
    }()
    
    private var managedObjectContext: NSManagedObjectContext?
      
      public init?() {
        managedObjectContext = persistentContainer?.viewContext
        
        guard managedObjectContext != nil else {
          print("Cann't get right managed object context.")
          return nil
        }
      }
    
    public func addMovie(with id: Int, with data: String) {
        let movie = NSEntityDescription.insertNewObject(forEntityName: self.entitieName, into: persistentContainer!.viewContext)
        
        //let secureData = SecurityManager.base64Encrypt(key: BusinessDomainManager.keyCipher, text: data)
        
        movie.setValue(id, forKey: "id")
        movie.setValue(data, forKey: "data")
        
        try? persistentContainer!.viewContext.save()
    }
    
    public func fetchMovie(with idSection: Int) -> Movie? {
        let fetchRequest: NSFetchRequest<Movie> = Movie.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "%K == %@", argumentArray: ["id",idSection])
        return try? persistentContainer!.viewContext.fetch(fetchRequest).first
    }
    
    public func fetchMovieCount() -> Int? {
        let fetchRequest: NSFetchRequest<Movie> = Movie.fetchRequest()
        return try? persistentContainer!.viewContext.fetch(fetchRequest).count
    }
    
    public func removeMovie(with idSection: Int) {
        let fetchRequest: NSFetchRequest<Movie> = Movie.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "%K == %@", argumentArray: ["id",idSection])
        
        do {
            guard let movie = try persistentContainer!.viewContext.fetch(fetchRequest).first else {
                return
            }
            
            persistentContainer!.viewContext.delete(movie)
            try? persistentContainer!.viewContext.save()
        } catch let error {
            print("Failed to delete move \(error)")
        }
    }
    
    public func removeAllRecords() {
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: self.entitieName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do
        {
            try persistentContainer!.viewContext.execute(deleteRequest)
            try persistentContainer!.viewContext.save()
        }
        catch
        {
            print ("There was an error")
        }
        
    }
     
}
