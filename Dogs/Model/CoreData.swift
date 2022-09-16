//    //
//    //  CoreData.swift
//    //  Dogs
//    //
//    //  Created by Прохоренко Георгий Денисович on 08.09.2022.
//    //
//
//    import Foundation
//    import UIKit
//    import CoreData
//
//    @objc(CoreData)
//    class CoreData:  {
//
//        @nonobjc public class override func fetchRequest() -> NSFetchRequest<NSFetchRequestResult> {
//            return NSFetchRequest<CoreData>(entityName: "DogsPhoto")
//        }
//
//        let appDelegate = UIApplication.shared.delegate as? AppDelegate
//        let context: NSManagedObjectContext = appDelegate!.persistentContainer.viewContext
//        let entityDiscription = NSEntityDescription.entity(forEntityName: "DogsPhoto", in: context)
//        let managedObject = NSManagedObject(entity: entityDiscription!, insertInto: context)
//
//        func writeInCoreData(image: UIImageView) {
//            managedObject.
//        }
//    }
