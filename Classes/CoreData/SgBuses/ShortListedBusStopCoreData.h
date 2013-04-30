//
//  ShortListedBusStopCoreData.h
//  Freestyle
//
//  Created by Kenneth on 8/4/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class BusStopCoreData;

@interface ShortListedBusStopCoreData : NSManagedObject

@property (nonatomic, retain) NSNumber * rank;
@property (nonatomic, retain) BusStopCoreData *busStop;

@end
