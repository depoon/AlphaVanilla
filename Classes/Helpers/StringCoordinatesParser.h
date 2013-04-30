//
//  StringCoordinatesParser.h
//  Freestyle
//
//  Created by Kenneth on 8/4/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface StringCoordinatesParser : NSObject

-(CLLocationCoordinate2D) generateCoordinateFromString: (NSString*) stringRepresentation;
@end
