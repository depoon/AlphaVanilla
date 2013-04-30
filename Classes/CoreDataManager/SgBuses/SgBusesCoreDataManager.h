//
//  SgBusesCoreDataManager.h
//  Freestyle
//
//  Created by Kenneth on 8/4/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "BusStopCoreData.h"
#import "BusNumberCoreData.h"
#import "BusDirectionCoreData.h"
#import "BusRouteCoreData.h"
#import "ShortListedBusStopCoreData.h"


@interface SgBusesCoreDataManager : NSObject


-(void) saveContext;

-(NSArray*) getAllBusStops;
-(BusStopCoreData*) createBusStop: (NSString*) busStopNumber busStopName: (NSString*) busStopName latitude: (float) latitude longitude: (float) longitude;
-(NSArray*) getFilteredBusStop: (NSString*) filterInput;
-(BusStopCoreData*) getBusStopFor: (NSString*) busStopString;

-(BusNumberCoreData*) createBusNumber: (NSString*) busNumber;
-(NSArray*) getAllBusNumbers;
-(BusNumberCoreData*) getBusNumberFor: (NSString*) busNumberString;

-(BusDirectionCoreData*) createBusDirection: (NSNumber*) directionNumber;

-(BusRouteCoreData*) createBusRoute: (int) index;

-(NSArray*) getAllShortListedBusStopArray;
-(ShortListedBusStopCoreData*) createShortListedBusStop: (BusStopCoreData*) busStop;
-(void) removeAllShortListedBusStop;

-(NSError*) removeShortListedBusStop: (ShortListedBusStopCoreData*) shortListedBusStopCoreData;


@end
