//
//  BusRouteCoreData.h
//  Freestyle
//
//  Created by Kenneth on 8/4/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class BusDirectionCoreData, BusStopCoreData;

@interface BusRouteCoreData : NSManagedObject

@property (nonatomic, retain) NSNumber * index;
@property (nonatomic, retain) BusDirectionCoreData *busDirection;
@property (nonatomic, retain) BusStopCoreData *busStop;

@end
