//
//  AppDelegateCoreDataManager.m
//  PropertyGuruSG
//
//  Created by Kenneth Chiang Hao Poon on 14/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CoreDataManager.h"



@implementation CoreDataManager{
    @private NSMutableDictionary* coreDataModuleDictionary;
    @private NSMutableDictionary* managedObjectContextDictionary;
    @private NSMutableDictionary* managedObjectModelDictionary;
    @private NSMutableDictionary* persistentStoreCoordinatorDictionary;
}

-(id) init{
    self = [super init];
    coreDataModuleDictionary = [[NSMutableDictionary alloc]init];
    managedObjectContextDictionary = [[NSMutableDictionary alloc]init];
    managedObjectModelDictionary = [[NSMutableDictionary alloc]init];
    persistentStoreCoordinatorDictionary = [[NSMutableDictionary alloc]init];
    
    
    [coreDataModuleDictionary setObject:@"SgBuses" forKey:@"SgBuses"];
    return self;
}

-(void) dealloc{
    if (coreDataModuleDictionary){
        [coreDataModuleDictionary release];
        coreDataModuleDictionary = nil;
    }
    if (managedObjectContextDictionary){
        [managedObjectContextDictionary release];
        managedObjectContextDictionary = nil;
    }
    if (managedObjectModelDictionary){
        [managedObjectModelDictionary release];
        managedObjectModelDictionary = nil;
    }
    if (persistentStoreCoordinatorDictionary){
        [persistentStoreCoordinatorDictionary release];
        persistentStoreCoordinatorDictionary = nil;
    }
    [super dealloc];
}


-(NSString*) getCoreDataModelResourceNameForModule: (NSString*) module{
    return (NSString*)[coreDataModuleDictionary objectForKey:module];
}

#pragma mark - Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark - Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContextForModule: (NSString*) module{

    NSManagedObjectContext* storedManagedObjectContext = [managedObjectContextDictionary objectForKey:module];
    if (storedManagedObjectContext != nil){
        return storedManagedObjectContext;
    }
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinatorForModule:module];
    if (coordinator != nil){
        NSManagedObjectContext*  _managedObjectContext = [[[NSManagedObjectContext alloc] init]autorelease];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
        [managedObjectContextDictionary setObject:_managedObjectContext forKey:module];
        return _managedObjectContext;
    }

    return nil;
}



/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *) managedObjectModelForModule: (NSString*) module{
    NSManagedObjectModel* _mom = (NSManagedObjectModel*) [managedObjectModelDictionary objectForKey:module];
    
    if (_mom != nil){
        return _mom;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:[self getCoreDataModelResourceNameForModule:module] withExtension:@"momd"];
    NSManagedObjectModel* mom = [[[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL]autorelease];
    [managedObjectModelDictionary setObject:mom forKey:module];

    return mom;
}


/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinatorForModule: (NSString*) module{
    
    NSPersistentStoreCoordinator* _coor = (NSPersistentStoreCoordinator*) [persistentStoreCoordinatorDictionary objectForKey:module];
    if (_coor != nil){
        return _coor;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:[NSString stringWithFormat:@"%@.sqlite", [self getCoreDataModelResourceNameForModule:module]]];
    
    NSError *error = nil;
    NSPersistentStoreCoordinator* coor = [[[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModelForModule:module]]autorelease];
    
    if (coor==nil){
        NSLog(@"coor is really nil");
    }
    
    if (![coor addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
    {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    [persistentStoreCoordinatorDictionary setObject:coor forKey:module];
    return coor;
}




- (void)saveContextForModule:(NSString *)module{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext  = (NSManagedObjectContext*) [managedObjectContextDictionary objectForKey:module];
    if (managedObjectContext != nil){
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
