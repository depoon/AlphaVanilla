//
//  SgBusesCoreDataManager.m
//  Freestyle
//
//  Created by Kenneth on 8/4/13.
//
//

#import "SgBusesCoreDataManager.h"
#import "CoreDataManagerAction.h"


@implementation SgBusesCoreDataManager{
    @private NSManagedObjectContext* managedObjectContext;
}

-(id) init{
    self = [super init];
    NSObject<CoreDataManagerAction>* appDelegate = (NSObject<CoreDataManagerAction>*) [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* _managedObjectContext = [appDelegate managedObjectContextForModule:@"SgBuses"];
    [self setManagedObjectContext:_managedObjectContext];

    return self;
}

-(void) dealloc{
    if (managedObjectContext){
        [managedObjectContext release];
        managedObjectContext = nil;
    }
    [super dealloc];
}


-(void) setManagedObjectContext: (NSManagedObjectContext*) _managedObjectContext{
    if (managedObjectContext){
        [managedObjectContext release];
        managedObjectContext = nil;
    }
    managedObjectContext = [_managedObjectContext retain];
}


-(void) saveContext{
	NSError *error = nil;
    [managedObjectContext save:&error];
    if (error){
        NSLog(@"Error Saving Core Data of SgBuses: %@", [error description]);
    }else{
        NSLog(@"No error in saving CoreData of SgBuses");
    }
    
}

-(NSArray*) getAllBusStops{
	NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
	
	[request setEntity:[NSEntityDescription entityForName:@"BusStopCoreData"
								   inManagedObjectContext:managedObjectContext]];
    NSSortDescriptor *sortbyDateDescriptor =
    [NSSortDescriptor sortDescriptorWithKey:@"busStopNumber"
                                  ascending:NO];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortbyDateDescriptor, nil];
    [request setSortDescriptors:sortDescriptors];


    
	NSError *error = nil;
	return [managedObjectContext executeFetchRequest:request error:&error];
}

-(NSArray*) getFilteredBusStop: (NSString*) filterInput{
	NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
	
	[request setEntity:[NSEntityDescription entityForName:@"BusStopCoreData"
								   inManagedObjectContext:managedObjectContext]];
    NSSortDescriptor *sortbyDateDescriptor =
    [NSSortDescriptor sortDescriptorWithKey:@"busStopNumber"
                                  ascending:YES];
    
    
    
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortbyDateDescriptor, nil];
    [request setSortDescriptors:sortDescriptors];
    
    NSPredicate * filterPredicate = [NSPredicate predicateWithFormat:@"busStopNumber BEGINSWITH %@", filterInput];
    [request setPredicate:filterPredicate];
    
	NSError *error = nil;
    NSArray* filteredArray = [managedObjectContext executeFetchRequest:request error:&error];
    if (error){
        NSLog(@"Error Fetching Core Data of SgBuses: %@", [error description]);
    }else{
        NSLog(@"No error in Fetching CoreData of SgBuses");
    }
    return filteredArray;
}

-(BusStopCoreData*) createBusStop: (NSString*) busStopNumber busStopName: (NSString*) busStopName latitude: (float) latitude longitude: (float) longitude{
    BusStopCoreData *dataObj = (BusStopCoreData *)[NSEntityDescription
                                                         insertNewObjectForEntityForName:@"BusStopCoreData"
                                                         inManagedObjectContext:managedObjectContext];
    dataObj.busStopNumber = busStopNumber;
    dataObj.busStopName = busStopName;
    dataObj.latitude = [NSNumber numberWithFloat:latitude];
    dataObj.longitude = [NSNumber numberWithFloat:longitude];
    return dataObj;

}

-(BusStopCoreData*) getBusStopFor: (NSString*) busStopString{
	NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
	
	[request setEntity:[NSEntityDescription entityForName:@"BusStopCoreData"
								   inManagedObjectContext:managedObjectContext]];
    NSPredicate * filterPredicate = [NSPredicate predicateWithFormat:@"busStopNumber == '%@'", busStopString];
    [request setPredicate:filterPredicate];
    
    
    
	NSError *error = nil;
    
    NSArray* fetchedArray = [managedObjectContext executeFetchRequest:request error:&error];
    if ([fetchedArray count]>0){
        BusStopCoreData* fetchedObject = [fetchedArray objectAtIndex:0];
        return fetchedObject;
    }
	return nil;
}

-(BusNumberCoreData*) getBusNumberFor: (NSString*) busNumberString{
	NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
	
	[request setEntity:[NSEntityDescription entityForName:@"BusNumberCoreData"
								   inManagedObjectContext:managedObjectContext]];
    NSPredicate * filterPredicate = [NSPredicate predicateWithFormat:@"busNumber == '%@'", busNumberString];
    [request setPredicate:filterPredicate];
    
    
    
	NSError *error = nil;
    
    NSArray* fetchedArray = [managedObjectContext executeFetchRequest:request error:&error];
    if ([fetchedArray count]>0){
        BusNumberCoreData* fetchedObject = [fetchedArray objectAtIndex:0];
        return fetchedObject;
    }
	return nil;
}

-(BusNumberCoreData*) createBusNumber: (NSString*) busNumber{
    
    BusNumberCoreData *dataObj = (BusNumberCoreData *)[NSEntityDescription
                                                   insertNewObjectForEntityForName:@"BusNumberCoreData"
                                                   inManagedObjectContext:managedObjectContext];
    dataObj.busNumber = busNumber;
    return dataObj;
    
}





-(NSArray*) getAllBusNumbers{
	NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
	
	[request setEntity:[NSEntityDescription entityForName:@"BusNumberCoreData"
								   inManagedObjectContext:managedObjectContext]];
    NSSortDescriptor *sortbyDateDescriptor =
    [NSSortDescriptor sortDescriptorWithKey:@"busNumber"
                                  ascending:NO];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortbyDateDescriptor, nil];
    [request setSortDescriptors:sortDescriptors];
    
    
    
	NSError *error = nil;
	return [managedObjectContext executeFetchRequest:request error:&error];
}


-(BusDirectionCoreData*) createBusDirection: (NSNumber*) directionNumber{
    
    BusDirectionCoreData *dataObj = (BusDirectionCoreData *)[NSEntityDescription
                                                       insertNewObjectForEntityForName:@"BusDirectionCoreData"
                                                       inManagedObjectContext:managedObjectContext];
    dataObj.busDirection = directionNumber;
    return dataObj;
    
}

-(BusRouteCoreData*) createBusRoute: (int) index{
    
    BusRouteCoreData *dataObj = (BusRouteCoreData *)[NSEntityDescription
                                                             insertNewObjectForEntityForName:@"BusRouteCoreData"
                                                             inManagedObjectContext:managedObjectContext];
    dataObj.index = [NSNumber numberWithInt:index];
    return dataObj;
    
}


-(NSArray*) getAllShortListedBusStopArray{
	NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
	
	[request setEntity:[NSEntityDescription entityForName:@"ShortListedBusStopCoreData"
								   inManagedObjectContext:managedObjectContext]];
    NSSortDescriptor *sortbyDateDescriptor =
    [NSSortDescriptor sortDescriptorWithKey:@"rank"
                                  ascending:NO];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortbyDateDescriptor, nil];
    [request setSortDescriptors:sortDescriptors];
    
    
    
	NSError *error = nil;
	return [managedObjectContext executeFetchRequest:request error:&error];
}

-(NSDictionary*) getAllShortListedBusStopDictionary{
    NSMutableDictionary* shortListedBusStopDictionary = [NSMutableDictionary dictionary];
    
    NSArray* shortListedBusStopArray = [self getAllShortListedBusStopArray];
    for (ShortListedBusStopCoreData* shortListedBusStop in shortListedBusStopArray){
        [shortListedBusStopDictionary setObject:shortListedBusStop forKey:shortListedBusStop.busStop.busStopNumber];
    }
    return shortListedBusStopDictionary;
}

-(ShortListedBusStopCoreData*) createShortListedBusStop: (BusStopCoreData*) busStop{
    
    ShortListedBusStopCoreData* existingShortListedBusStop = [self getShortListedBusStopFor:busStop];
    if (existingShortListedBusStop!=nil){
        [NSException raise:@"ShortListedBusStopExistException" format:@"Bus Stop: %@ already shortlisted", busStop.busStopNumber];
    }else{
        NSLog(@"shortListedbusstop is nil");
    }
    
    NSArray* allShortListedBusStopArray = [self getAllShortListedBusStopArray];
    
    ShortListedBusStopCoreData *dataObj = (ShortListedBusStopCoreData *)[NSEntityDescription
                                                     insertNewObjectForEntityForName:@"ShortListedBusStopCoreData"
                                                     inManagedObjectContext:managedObjectContext];
    dataObj.busStop = busStop;
    dataObj.rank = [NSNumber numberWithInt:[allShortListedBusStopArray count]];
    return dataObj;
}

-(ShortListedBusStopCoreData*) getShortListedBusStopFor: (BusStopCoreData*) busStop{
	NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
	
	[request setEntity:[NSEntityDescription entityForName:@"ShortListedBusStopCoreData"
								   inManagedObjectContext:managedObjectContext]];
    NSPredicate * filterPredicate = [NSPredicate predicateWithFormat:@"busStop.busStopNumber == %@", busStop.busStopNumber];
    [request setPredicate:filterPredicate];
    
    
    
	NSError *error = nil;
    
    NSArray* fetchedArray = [managedObjectContext executeFetchRequest:request error:&error];
    for (int i=0; i<[fetchedArray count]; i++){
        ShortListedBusStopCoreData* obj = (ShortListedBusStopCoreData*) [fetchedArray objectAtIndex:i];
        NSLog(@"obj BusStopNumber: %@", obj.busStop.busStopNumber);
        NSLog(@"obj rank: %d", [obj.rank intValue]);
    }

    if ([fetchedArray count]>0){
        
        ShortListedBusStopCoreData* fetchedObject = [fetchedArray objectAtIndex:0];
        return fetchedObject;
    }
	return nil;
}

-(void) removeAllShortListedBusStop{
    NSArray* allShortListedBusStop = [self getAllShortListedBusStopArray];
    for (ShortListedBusStopCoreData* shortListedBusStop in allShortListedBusStop){
        [managedObjectContext deleteObject:shortListedBusStop];
    }
}

-(NSError*) removeShortListedBusStop: (ShortListedBusStopCoreData*) shortListedBusStopCoreData{
    
    NSError* error = nil;
    
    [managedObjectContext deleteObject:shortListedBusStopCoreData];
    [managedObjectContext save:&error];
    
    return error;
}

-(void) deleteAllDataViaCascade{
    NSArray* busNumbersArray = [self getAllBusNumbers];
    for (NSManagedObject* managedObject in busNumbersArray){
        [managedObjectContext deleteObject:managedObject];
    }
    NSError* error = nil;
    [managedObjectContext save:&error];
}

@end
