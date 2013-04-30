//
//  SgBusesAddTableViewController.h
//  Freestyle
//
//  Created by Kenneth on 7/4/13.
//
//

#import <Foundation/Foundation.h>
#import "SgBusesBusStopSelectionAction.h"

@interface SgBusesBusStopAddTableViewController : UITableViewController

-(void) searchBusStopsFor: (NSString*) input;

@property (nonatomic, retain) NSObject<SgBusesBusStopSelectionAction>* sgBusesBusStopSelectionActionDelegate;
@end
