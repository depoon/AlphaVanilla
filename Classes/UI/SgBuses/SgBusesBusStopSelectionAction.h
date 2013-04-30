//
//  SgBusesBusStopSelectionAction.h
//  Freestyle
//
//  Created by Kenneth on 8/4/13.
//
//

#import <Foundation/Foundation.h>
#import "BusStopCoreData.h"

@protocol SgBusesBusStopSelectionAction <NSObject>

-(void) busStopSelected: (BusStopCoreData*) busStop;
@end
