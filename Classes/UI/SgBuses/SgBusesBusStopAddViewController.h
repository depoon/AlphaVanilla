//
//  SgBusesAddViewController.h
//  Freestyle
//
//  Created by Kenneth on 7/4/13.
//
//

#import <Foundation/Foundation.h>
#import "PGKeyboardInputAccessoryAction.h"
#import "SgBusesBusStopSelectionAction.h"

@interface SgBusesBusStopAddViewController : UIViewController<PGKeyboardInputAccessoryAction, UISearchBarDelegate,SgBusesBusStopSelectionAction>

@end
