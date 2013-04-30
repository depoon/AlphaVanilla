//
//  SgBusesShortListFeedComponent.h
//  Freestyle
//
//  Created by Kenneth on 9/4/13.
//
//

#import <Foundation/Foundation.h>
#import "ShortListedBusStopCoreData.h"
#import "SgBusesUpdateTimingAction.h"
#import "SgTableViewUpdatableAction.h"
#import "SgBusesClearTimingAction.h"

@interface SgBusesShortListBusStopFeedComponent : NSObject<SgBusesUpdateTimingAction, SgTableViewUpdatableAction, SgBusesClearTimingAction>

@property (nonatomic, retain) NSObject<SgTableViewUpdatableAction>* sgTableViewUpdatableActionDelegate;

-(id) initWithShortListedBusStopCoreData: (ShortListedBusStopCoreData*) _shortListedBusStop;
-(ShortListedBusStopCoreData*) getShortListedBusStop;
-(NSArray*) getBusNumberArray;


@end
