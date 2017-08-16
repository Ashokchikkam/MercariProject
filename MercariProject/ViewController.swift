//
//  ViewController.swift
//  MercariProject
//
//  Created by Ashok on 8/16/17.
//  Copyright © 2017 Ashok. All rights reserved.
//

import UIKit
import CoreData
import Alamofire

class ViewController: UIViewController, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var collectionView: UICollectionView!

    var controller: NSFetchedResultsController<Item>!

    override func viewDidLoad() {
        super.viewDidLoad()

        attemptFetch()
        loadData()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    private func attemptFetch() {
        
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        let dateSort = NSSortDescriptor(key: #keyPath(Item.date), ascending: true)
        //let idSort = NSSortDescriptor(key: "id", ascending: true)
        
        fetchRequest.sortDescriptors = [dateSort]
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        controller.delegate = self
        
        self.controller = controller
        
        do {
            try controller.performFetch()
        } catch {
            let error = error as NSError
            print("\(error)")
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        DispatchQueue.main.async {
            print("saving the object to core data")
            ad.saveContext()
        }
    }
}



extension ViewController{
    
    
    func loadData() {
        
        if BASE_URL != nil{
            loadDataFromURL()
        }
        else{
            print("If you want to load data from a URL, Please provide a valid BASE_URL in the Constants.swift file. NO DATA FOUND!!!!!!!!!!!!!!!!!!!!!!!!!!!")
            loadDataFromFile()
            
        }
        print("reloading inside load Data")
        //self.collection.reloadData()
    }
    
    func loadDataFromFile() {
        
        let path = Bundle.main.path(forResource: "all", ofType: "json")
        
        do{
            
            if let jsonData = NSData(contentsOfFile: path!){
                
                if let jsonResult: Dictionary<String, AnyObject> =  try JSONSerialization.jsonObject(with: jsonData as Data, options: .mutableContainers) as? Dictionary<String, AnyObject>{
                    savingDataToDB(info: jsonResult)
                    //print("JsonResult:\(jsonResult)")
                    print("saving Data to DB from the local JSON file.")
                    
                }
                else{
                    print("unable to unwrap")
                }
            }
        }
        catch{
            let error = error as NSError
            print("\(error)")
        }
        
    }
    func loadDataFromURL() {
        Alamofire.request(BASE_URL!).responseJSON{ response in
            //Getting data from the URL.
            if let dict = response.result.value as? Dictionary<String, AnyObject>{
                self.savingDataToDB(info: dict)
                
            }
        }
    }
    
    func savingDataToDB(info: Dictionary<String, AnyObject>) {
        
        
        if let data = info["data"] as? [Dictionary<String, AnyObject>]{
            
            //Checking if the data has already been fetched and there is no new data.
            if let objs = self.controller.fetchedObjects {
                if (objs.count) < data.count{
                    for row in data{
                        //Code to add any new items. If we want to update the existing item, we need to add some code here.
                        let newItem = Item(context: context)
                        
                        newItem.date = Date() as NSDate
                        
                        if let tempId = row["id"] as? String{
                            newItem.id = tempId
                        }
                        if let tempTitle = row["name"] as? String{
                            newItem.title = tempTitle
                        }
                        if let tempSoldState = row["status"] as? String{
                            if tempSoldState == "sold_out"{
                                newItem.soldState = true
                            }else{
                                newItem.soldState = false
                            }
                        }
                        if let tempAmount = row["price"] as? int_least16_t{
                            newItem.amount = tempAmount
                        }
                        
                        if let tempImageUrl = row["photo"] as? String{
                            newItem.imageUrl = tempImageUrl
                        }
                        print("row count")
                        ad.saveContext() //-- No need to do the ad.saveContext() here Because any change in the controllers objects data calls the controllerDidChangeContent method which has the ad.saveContext() method.
                    }
                    //Reload the CollectionView's data if any new data is added.
                    print("reloading inside Saviing data to db")
                    //self.collection.reloadData()
                }
                else{
                    print("No New data is available, nothing is saved to disk")
                }
                print("object count: \(objs.count)")
                
            }
            
        }
        
    }
}


