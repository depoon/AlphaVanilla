//
//  AppConfigurationAction.h
//  Freestyle
//
//  Created by Kenneth on 15/3/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Configuration.h"

@protocol AppConfigurationAction <NSObject>

-(Configuration*) getConfiguration;
@end
