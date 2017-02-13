//
//  MembershipWidgetVC.swift
//  MemebershipCoupon
//
//  Created by Joosung Kim on 13/02/2017.
//  Copyright © 2017 mino. All rights reserved.
//

import UIKit
import CoreData

class MembershipWidgetVC: UIViewController, NSFetchedResultsControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var favoriteController: NSFetchedResultsController<Favorite>!
    var favorites: [Favorite]!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var barcodeView: UIView!
    @IBOutlet weak var barcodeImg: UIImageView!
    @IBAction func barcodeTouch(_ sender: UIButton) {
        barcodeView.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attemptFetch()
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {        
        if let objs = favoriteController.fetchedObjects, objs.count > 0 {
            let item = objs[indexPath.row]
            barcodeView.isHidden = false
            barcodeImg.image = generateBarcodeFromString(string: item.toMembership?.barcode)
        }
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let sections = favoriteController.sections {
            let sectionInfo = sections[section]
            
            return sectionInfo.numberOfObjects
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MembershipWidgetCell", for: indexPath) as! MembershipWidgetCell
        configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
        
        return cell
    }
    
    func configureCell(cell: MembershipWidgetCell, indexPath: NSIndexPath) {
        
        //update cell
        
        let item = favoriteController.object(at: indexPath as IndexPath)
        cell.configureCell(item: item)
        
    }
    

    func attemptFetch()  {
        let fetchRequest: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        let dateSort = NSSortDescriptor(key: "created", ascending: false)
        let indexSort = NSSortDescriptor(key: "index", ascending: true)
        
        fetchRequest.sortDescriptors = [indexSort, dateSort]
        
        let isPredicate = NSPredicate(format: "%K == NO", "isCoupon")
        fetchRequest.predicate = isPredicate
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataService.shared.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        
        
        //save시 tableview update를 위한 델리게이트 전달
        
        controller.delegate = self
        
        self.favoriteController = controller
        
        do {
            try self.favoriteController.performFetch()
        } catch {
            let error = error as NSError
            print("\(error)")
        }
    }
    

}
