//
//  SgBusesShortListBusFeedComponent.h
//  Freestyle
//
//  Created by Kenneth on 9/4/13.
//
//

#import <Foundation/Foundation.h>
#import "BusRouteCoreData.h"
#import "ASIHTTPRequestDelegate.h"
#import "SgBusesUpdateTimingAction.h"
#import "SgTableViewUpdatableAction.h"
#import "SgBusesUIDomainBusRouteDetails.h"
#import "SgBusesClearTimingAction.h"

@interface SgBusesShortListBusRouteFeedComponent : NSObject<ASIHTTPRequestDelegate, SgBusesUpdateTimingAction, SgBusesClearTimingAction>

-(id) initWithBusRouteCoreData: (BusRouteCoreData*) _busRoute;
-(SgBusesUIDomainBusRouteDetails*) getBusRouteDetails;

@property (nonatomic, retain) NSObject<SgTableViewUpdatableAction>* sgTableViewUpdatableActionDelegate;
@end
