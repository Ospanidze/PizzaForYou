//
//  StorageManager.swift
//  PizzaYahoo
//
//  Created by Айдар Оспанов on 29.08.2023.
//

import CoreData

class StorageManager {
    
    static let shared = StorageManager()
    
    private let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DishModel")
        
        container.loadPersistentStores { _, error in
            if let error = error as? NSError {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        
        return container
    }()
    
    private let viewContent: NSManagedObjectContext
    
    private init() {
        viewContent = persistentContainer.viewContext
    }
    
    //MARK: -CRUD create read update delete
    func create(_ dish: Dish) {
        let dishItem = DishItem(context: viewContent)
        dishItem.name = dish.name
        dishItem.id =   Int64(dish.id)
        dishItem.price = Int64(dish.price)
        dishItem.weight = Int64(dish.weight)
        dishItem.imageURL = dish.imageURL
        saveContext()
    }
    
    func fetchData(completion: @escaping(Result<[DishItem], Error>) -> Void) {
        let fetchRequest = DishItem.fetchRequest()
        
        do {
            let dishItems = try viewContent.fetch(fetchRequest)
            completion(.success(dishItems))
        } catch let error {
            completion(.failure(error))
        }
    }
    
//    func update(_ dishItem: DishItem, _ dish: Dish) {
//
//    }
    
    func delete(_ dishItem: DishItem) {
        viewContent.delete(dishItem)
        saveContext()
    }
    
    //MARK: Core Data Saving support
    
    func saveContext() {
        if viewContent.hasChanges {
            do {
                try viewContent.save()
            } catch let error {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
