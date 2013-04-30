//
//  ApplicationConfigurationSetup.m
//  Freestyle
//
//  Created by Kenneth on 15/3/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "ApplicationConfigurationSetup.h"

@implementation ApplicationConfigurationSetup

-(NSString*) getApplicationUIBackgroundFileName{
    return [configRetriever getConfigValue:configDictionary configKey:CONFIG_KEY_APPLICATION level2SubKey:CONFIG_KEY_APPLICATION_UI level3SubKey:CONFIG_KEY_APPLICATION_UI_BACKGROUND level4SubKey:CONFIG_KEY_APPLICATION_UI_BACKGROUND_FILE];
}

@end
