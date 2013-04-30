//
//  BusStopCoreData.h
//  Freestyle
//
//  Created by Kenneth on 8/4/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class BusRouteCoreData, ShortListedBusStopCoreData;

@interface BusStopCoreData : NSManagedObject

@property (nonatomic, retain) NSString * busStopName;
@property (nonatomic, retain) NSString * busStopNumber;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSSet *busRoute;
@property (nonatomic, retain) ShortListedBusStopCoreData *shortListingBusStop;
@end

@interface BusStopCoreData (CoreDataGeneratedAccessors)

- (void)addBusRouteObject:(BusRouteCoreData *)value;
- (void)removeBusRouteObject:(BusRouteCoreData *)value;
- (void)addBusRoute:(NSSet *)values;
- (void)removeBusRoute:(NSSet *)values;
-(NSString*) getBusStopName;

@end
