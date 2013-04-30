//
//  BusNumberCoreData.h
//  Freestyle
//
//  Created by Kenneth on 8/4/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class BusDirectionCoreData;

@interface BusNumberCoreData : NSManagedObject

@property (nonatomic, retain) NSString * busNumber;
@property (nonatomic, retain) NSSet *busDirection;
@end

@interface BusNumberCoreData (CoreDataGeneratedAccessors)

- (void)addBusDirectionObject:(BusDirectionCoreData *)value;
- (void)removeBusDirectionObject:(BusDirectionCoreData *)value;
- (void)addBusDirection:(NSSet *)values;
- (void)removeBusDirection:(NSSet *)values;

@end
