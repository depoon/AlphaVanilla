//
//  SgBusesCoreDataSetupViewController.h
//  Freestyle
//
//  Created by Kenneth on 9/4/13.
//
//

#import <Foundation/Foundation.h>
#import "SgBusesCoreDataUpdateUIAction.h"

@interface SgBusesCoreDataSetupViewController : UIViewController<SgBusesCoreDataUpdateUIAction>

-(void) setIsLaunchedDuringStartup: (BOOL) _isLaunchedDuringStartUp;
@end
