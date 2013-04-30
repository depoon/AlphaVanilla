//
//  PoonDemoAppDelegate.h
//  Freestyle
//
//  Created by Kenneth on 15/3/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppConfigurationAction.h"
#import "ApplicationDelegateAction.h"
#import "CoreDataManagerAction.h"

@interface PoonDemoAppDelegate : UIResponder <UIApplicationDelegate, AppConfigurationAction, ApplicationDelegateAction, CoreDataManagerAction>

@property (strong, nonatomic) UIWindow *window;

@end
