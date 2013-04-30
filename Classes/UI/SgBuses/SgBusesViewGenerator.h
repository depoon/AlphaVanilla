//
//  SgBusesViewGenerator.h
//  Freestyle
//
//  Created by Kenneth on 8/4/13.
//
//

#import <Foundation/Foundation.h>
#import "BusStopCoreData.h"
#import "ShortListedBusStopCoreData.h"
#import "SgBusesBusStopShortlistAction.h"

@interface SgBusesViewGenerator : NSObject

-(UIView*) generateSgBusesBusStopSelectionCellViewFor: (BusStopCoreData*) busStop rectSize: (CGRect) rectSize;
-(UIView*) generateSgBusesBusStopPreviewViewFor: (BusStopCoreData*) busStop rectSize: (CGRect) rectSize;
-(int) calculateShortListCellViewHeightFor: (ShortListedBusStopCoreData*) shortListedBusStop;

@property (nonatomic, retain) NSObject<SgBusesBusStopShortlistAction>* sgBusesBustStopShortlistActionDelegate;
@end
