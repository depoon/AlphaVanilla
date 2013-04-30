//
//  SgBusesShortListFeedComponent.m
//  Freestyle
//
//  Created by Kenneth on 9/4/13.
//
//

#import "SgBusesShortListBusStopFeedComponent.h"
#import "BusStopCoreData.h"
#import "BusDirectionCoreData.h"
#import "BusNumberCoreData.h"
#import "BusRouteCoreData.h"
#import "SgBusesShortListBusRouteFeedComponent.h"


@implementation SgBusesShortListBusStopFeedComponent{
    @private NSArray* busNumberArray;
    @private ShortListedBusStopCoreData* shortListedBusStop;
}

@synthesize sgTableViewUpdatableActionDelegate;

-(id) initWithShortListedBusStopCoreData: (ShortListedBusStopCoreData*) _shortListedBusStop{
    self = [super init];
    shortListedBusStop = [_shortListedBusStop retain];
    busNumberArray = [[self generateBusNumberArrayFromShortListedBusStop:_shortListedBusStop] retain];
    return self;
}

-(void) dealloc{
    if (sgTableViewUpdatableActionDelegate){
        [sgTableViewUpdatableActionDelegate release];
        sgTableViewUpdatableActionDelegate = nil;
    }
    if (shortListedBusStop){
        [shortListedBusStop release];
        shortListedBusStop = nil;
    }
    if (busNumberArray){
        [busNumberArray release];
        busNumberArray = nil;
    }
    [super dealloc];
}

-(ShortListedBusStopCoreData*) getShortListedBusStop{
    return shortListedBusStop;
}

-(NSArray*) generateBusNumberArrayFromShortListedBusStop: (ShortListedBusStopCoreData*) _shortListedBusStop{
    NSMutableArray* _busNumberArray = [NSMutableArray array];
    
    NSArray* busServicesArray = [_shortListedBusStop.busStop.busRoute allObjects];
    NSSortDescriptor *nameDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"busDirection.busNumber.busNumber" ascending:YES];
    NSArray *sortedBusServicesArray = [busServicesArray sortedArrayUsingDescriptors:[NSArray arrayWithObject:nameDescriptor]];
    for (int i=0; i<[sortedBusServicesArray count]; i++){
        BusRouteCoreData* busroute = (BusRouteCoreData*) [sortedBusServicesArray objectAtIndex:i];
        SgBusesShortListBusRouteFeedComponent* sgBusesUIDomainBusRouteDetails = [[SgBusesShortListBusRouteFeedComponent alloc]initWithBusRouteCoreData:busroute];
        sgBusesUIDomainBusRouteDetails.sgTableViewUpdatableActionDelegate = self;
        [_busNumberArray addObject:sgBusesUIDomainBusRouteDetails];
        [sgBusesUIDomainBusRouteDetails release];
    }
    return _busNumberArray;
}

-(NSArray*) getBusNumberArray{
    return busNumberArray;
}

-(void) updateTiming{
    for (SgBusesShortListBusRouteFeedComponent* feedComponent in busNumberArray){
        [feedComponent updateTiming];
    }
}

-(void) clearTiming{
    for (SgBusesShortListBusRouteFeedComponent* busRouteFeedComponent in busNumberArray){
        [busRouteFeedComponent clearTiming];
    }
}

-(void) updateTable{
    if (sgTableViewUpdatableActionDelegate!=nil){
        [sgTableViewUpdatableActionDelegate updateTable];
    }
}
@end
