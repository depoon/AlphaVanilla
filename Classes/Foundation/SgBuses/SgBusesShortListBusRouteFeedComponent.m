//
//  SgBusesShortListBusFeedComponent.m
//  Freestyle
//
//  Created by Kenneth on 9/4/13.
//
//

#import "SgBusesShortListBusRouteFeedComponent.h"
#import "ASIFormDataRequest.h"

@implementation SgBusesShortListBusRouteFeedComponent{
    @private SgBusesUIDomainBusRouteDetails* sgBusesUIDomainBusRouteDetails;
    @private ASIFormDataRequest* request;
}
@synthesize sgTableViewUpdatableActionDelegate;

-(id) initWithBusRouteCoreData: (BusRouteCoreData*) _busRoute{
    self = [super init];
    sgBusesUIDomainBusRouteDetails = [[SgBusesUIDomainBusRouteDetails alloc]initWithBusRouteCoreData:_busRoute];
    return self;
}

-(void) dealloc{
    if (sgTableViewUpdatableActionDelegate){
        [sgTableViewUpdatableActionDelegate release];
        sgTableViewUpdatableActionDelegate = nil;
    }
    if (request){
        [request cancel];
        [request release];
        request = nil;
    }
    if (sgBusesUIDomainBusRouteDetails){
        [sgBusesUIDomainBusRouteDetails release];
        sgBusesUIDomainBusRouteDetails = nil;
    }
    [super dealloc];
}

-(SgBusesUIDomainBusRouteDetails*) getBusRouteDetails{
    return sgBusesUIDomainBusRouteDetails;
}

-(void) setRequest: (ASIFormDataRequest*) _request{
    if (request){
        [request cancel];
        [request release];
        request = nil;
    }
    request = [_request retain];
}

-(NSString*) generateUrlString{
    NSString* urlString = [NSString stringWithFormat:@"http://sg.orados.net/bus/app_mata_13.aspx?bustype=stop&busstop=%@&busno=%@", [sgBusesUIDomainBusRouteDetails getBusStop], [sgBusesUIDomainBusRouteDetails getBusNumber]];
    return urlString;
}

-(ASIFormDataRequest*) generateRequest{

    ASIFormDataRequest* _request = [[[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:[self generateUrlString]]]autorelease];
    return _request;
}

-(void) updateTiming{
    if ([request inProgress]){
        [request cancel];
    }
    ASIFormDataRequest* _request = [self generateRequest];
    [_request setResponseEncoding:NSASCIIStringEncoding];
    [_request setDelegate:self];
    [self setRequest:_request];
    [request startAsynchronous];
}

-(void) clearTiming{
    [sgBusesUIDomainBusRouteDetails setNextArrivalMessage:@""];
}

-(NSString*) generateNextArrivalMessageStringFromResponse: (NSString*) responseString{
    if ([responseString hasPrefix:@"<!"]){
        return @"Error";
    }
    NSArray *coordiantesArray = [responseString componentsSeparatedByString:@"<br/>"];
    NSString* firstString = [coordiantesArray objectAtIndex:1];
    if ([firstString hasPrefix:@"No info available"]){
        return @"N/A";
    }
    
    if ([firstString hasPrefix:@"Bus Arriving"]){
        return @"Now";
    }
    
    NSRange textRange =[firstString rangeOfString:@"-"];
    if(textRange.location != NSNotFound){
        return @"N/A";
    }
    
    
    NSRange range = [firstString rangeOfString:@"@"];
    if (range.location == NSNotFound){
        return @"N/A";
    }
    NSString *substring = [[firstString substringFromIndex:NSMaxRange(range)] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSArray *minArray = [substring componentsSeparatedByString:@"min"];
    NSString* nextArrivalMessage = [NSString stringWithFormat:@"%@ mins", [minArray objectAtIndex:0]];
    return nextArrivalMessage;
}

- (void)requestFinished:(ASIHTTPRequest *)_request{
    NSString* responseString = _request.responseString;
    NSLog(@"responseString: %@: %@", [self generateUrlString], responseString);
    NSString* nextArrivalMessage = [self generateNextArrivalMessageStringFromResponse: responseString];
    [sgBusesUIDomainBusRouteDetails setNextArrivalMessage:nextArrivalMessage];

    if (sgTableViewUpdatableActionDelegate!=nil){
        [sgTableViewUpdatableActionDelegate updateTable];
    }
    
}
- (void)requestFailed:(ASIHTTPRequest *)request{
    
}



@end