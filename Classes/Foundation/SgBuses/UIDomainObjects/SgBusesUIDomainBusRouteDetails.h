//
//  SgBusesUIDomainBusRouteDetails.h
//  Freestyle
//
//  Created by Kenneth on 29/4/13.
//
//

#import <Foundation/Foundation.h>
#import "BusRouteCoreData.h"

@interface SgBusesUIDomainBusRouteDetails : NSObject


-(id) initWithBusRouteCoreData: (BusRouteCoreData*) _busRouteCoreData;
-(void) setNextArrivalMessage: (NSString*) _nextArrivalMessage;
-(void) setFollowingArrivalMessage: (NSString*) _followingArrivalMessage;
-(void) setLateUpdatedDate: (NSDate*) _lateUpdatedDate;

-(NSString*) getNextArrivalMessage;
-(NSString*) getBusStop;
-(NSString*) getBusNumber;
@end
