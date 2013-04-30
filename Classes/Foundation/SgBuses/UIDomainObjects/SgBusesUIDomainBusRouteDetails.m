//
//  SgBusesUIDomainBusRouteDetails.m
//  Freestyle
//
//  Created by Kenneth on 29/4/13.
//
//

#import "SgBusesUIDomainBusRouteDetails.h"
#import "BusStopCoreData.h"
#import "BusDirectionCoreData.h"
#import "BusNumberCoreData.h"

@implementation SgBusesUIDomainBusRouteDetails{
    @private BusRouteCoreData* busRouteCoreData;
    @private NSString* nextArrivalMessage;
    @private NSString* followingArrivalMessage;
    @private NSDate* lateUpdatedDate;
}

-(id) initWithBusRouteCoreData: (BusRouteCoreData*) _busRouteCoreData{
    self = [super init];
    busRouteCoreData = [_busRouteCoreData retain];
    return self;
}

-(void) dealloc{
    if (nextArrivalMessage){
        [nextArrivalMessage release];
        nextArrivalMessage = nil;
    }
    if (followingArrivalMessage){
        [followingArrivalMessage release];
        followingArrivalMessage = nil;
    }
    if (lateUpdatedDate){
        [lateUpdatedDate release];
        lateUpdatedDate = nil;
    }
    if (busRouteCoreData){
        [busRouteCoreData release];
        busRouteCoreData = nil;
    }
    [super dealloc];
}

-(void) setNextArrivalMessage: (NSString*) _nextArrivalMessage{
    if (nextArrivalMessage){
        [nextArrivalMessage release];
        nextArrivalMessage = nil;
    }
    nextArrivalMessage = [_nextArrivalMessage retain];
}

-(void) setFollowingArrivalMessage: (NSString*) _followingArrivalMessage{
    if (followingArrivalMessage){
        [followingArrivalMessage release];
        followingArrivalMessage = nil;
    }
    followingArrivalMessage = [_followingArrivalMessage retain];
}

-(void) setLateUpdatedDate: (NSDate*) _lateUpdatedDate{
    if (lateUpdatedDate){
        [lateUpdatedDate release];
        lateUpdatedDate = nil;
    }
    lateUpdatedDate = [_lateUpdatedDate retain];
}

-(NSString*) getNextArrivalMessage{
    return nextArrivalMessage;
}

-(NSString*) getBusStop{
    return busRouteCoreData.busStop.busStopNumber;
}

-(NSString*) getBusNumber{
    return busRouteCoreData.busDirection.busNumber.busNumber;
}
@end
