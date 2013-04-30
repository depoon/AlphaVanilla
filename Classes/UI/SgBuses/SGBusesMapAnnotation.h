//
//  SGBusesMapAnnotation.h
//  Freestyle
//
//  Created by Kenneth on 7/4/13.
//
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface SGBusesMapAnnotation : NSObject<MKAnnotation>

-(id) initWithLatitude: (float) _latitude longitude: (float) _longitude busStopNumber: (NSString*) _bustStopNumber busStopName: (NSString*) _busStopName;

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@end
