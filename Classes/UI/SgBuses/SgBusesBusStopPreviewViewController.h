//
//  SgBusesBusStopPreviewViewController.h
//  Freestyle
//
//  Created by Kenneth on 8/4/13.
//
//

#import <Foundation/Foundation.h>
#import "BusStopCoreData.h"
#import "SgBusesBusStopShortlistAction.h"

@interface SgBusesBusStopPreviewViewController : UIViewController<SgBusesBusStopShortlistAction>

-(id) initWithBusStopCoreData: (BusStopCoreData*) _busStopCoreData;


@end
