//
//  BusDirectionCoreData.h
//  Freestyle
//
//  Created by Kenneth on 8/4/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class BusNumberCoreData, BusRouteCoreData;

@interface BusDirectionCoreData : NSManagedObject

@property (nonatomic, retain) NSNumber * busDirection;
@property (nonatomic, retain) BusNumberCoreData *busNumber;
@property (nonatomic, retain) NSSet *busRoute;
@end

@interface BusDirectionCoreData (CoreDataGeneratedAccessors)

- (void)addBusRouteObject:(BusRouteCoreData *)value;
- (void)removeBusRouteObject:(BusRouteCoreData *)value;
- (void)addBusRoute:(NSSet *)values;
- (void)removeBusRoute:(NSSet *)values;

@end
