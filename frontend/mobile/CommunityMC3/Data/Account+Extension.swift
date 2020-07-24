//
//  Account+Extension.swift
//  CommunityMC3
//
//  Created by Bernardinus on 22/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import Foundation
import CoreData

struct AccountDataStruct
{
    var email:String
    var password:String
    
    var user:UserDataStruct?
}

extension Account {
    
    static func registerAccount(context: NSManagedObjectContext, accountEmail: String, accountPassword: String) -> Account? {
        let account = Account(context: context)
        account.email = accountEmail
        account.password = accountPassword
//        task.subtask = []
//        guard ((try? context.save()) != nil) else {
//            return nil
//        }
//        return task
        do {
            try context.save()
            return account
        } catch {
            return nil
        }
    }
    
    static func loginAccount(context: NSManagedObjectContext, accountEmail: String, accountPassword: String) -> Account? {
        let request: NSFetchRequest<Account> = Account.fetchRequest()
        do {
            let accounts = try context.fetch(request)
            for account in accounts {
                if account.email == accountEmail && account.password == accountPassword {
                    return account
                }
            }
            return nil
        } catch {
            return nil
        }
    }
    
    static func editAccount(context: NSManagedObjectContext, accountEmail: String, accountPassword: String) -> Bool {
//        let request: NSFetchRequest<NSFetchRequestResult> = Account.fetchRequest()
//        let predicate = NSPredicate(format: "taskName BEGINSWITH 'v'")
//        request.predicate = predicate
//        if accountEmail == "" || accountPassword == "" {
//            let deletedRequest = NSBatchDeleteRequest(fetchRequest: request)
//            let result = try? context.execute(deletedRequest)
//            if (result != nil) {
//                let account = Account(context: context)
//                if accountEmail != "" {
//                    account.email = accountEmail
//                }
//                if accountPassword != "" {
//                    account.password = accountPassword
//                }
//                do {
//                   try context.save()
//                   return true
//                } catch {
//                   return false
//                }
//            }
//            return false
//        }else {
        let request: NSFetchRequest<Account> = Account.fetchRequest()
        var response = false
        do {
            let accounts = try context.fetch(request)
            for account in accounts {
                if account.email != "" && account.password == accountPassword {
                    account.setValue(accountEmail, forKey: "email")
                    response = true
                }
                if account.email == accountEmail && account.password != "" {
                    account.setValue(accountPassword, forKey: "password")
                    response = true
                }
            }
            return response
        } catch {
            return false
        }
//        }
    }
    
    
    
}
