//
//  SGBusesMapAnnotation.m
//  Freestyle
//
//  Created by Kenneth on 7/4/13.
//
//

#import "SGBusesMapAnnotation.h"


@implementation SGBusesMapAnnotation{

}

@synthesize coordinate;

-(id) initWithLatitude: (float) _latitude longitude: (float) _longitude busStopNumber: (NSString*) _bustStopNumber busStopName: (NSString*) _busStopName{
    self = [super init];

    CLLocationCoordinate2D generatedCoordinate = CLLocationCoordinate2DMake(_latitude, _longitude);
    [self setCoordinate:generatedCoordinate];

    

    return self;
}
@end
