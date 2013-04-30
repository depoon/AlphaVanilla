//
//  StringCoordinatesParser.m
//  Freestyle
//
//  Created by Kenneth on 8/4/13.
//
//

#import "StringCoordinatesParser.h"

@implementation StringCoordinatesParser

-(CLLocationCoordinate2D) generateCoordinateFromString: (NSString*) stringRepresentation{
    NSArray *coordiantesArray = [stringRepresentation componentsSeparatedByString:@","];
    NSString* longitudeString = (NSString*) [coordiantesArray objectAtIndex:0];
    NSString* latitudeString = (NSString*) [coordiantesArray objectAtIndex:1];
    
    
    
    float longitude = [longitudeString floatValue];
    float latitude = [latitudeString floatValue];
    
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    return coordinate;
}
@end
