//
//  Configuration.h
//  Freestyle
//
//  Created by Kenneth on 15/3/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ApplicationConfigurationSetup.h"
#import "SideMenuConfigurationSetup.h"

@interface Configuration : NSObject

-(id) initWithConfigFilePath: (NSString*) configFilePath;
-(void) setConfigDictionary:(NSDictionary*) _configDictionary;

-(ApplicationConfigurationSetup*) getApplicationConfigurationSetup;
-(SideMenuConfigurationSetup*) getSideMenuConfigurationSetup;
@end
