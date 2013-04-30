//
//  SideMenuConfigurationSetup.m
//  Freestyle
//
//  Created by Kenneth on 18/3/13.
//
//

#import "SideMenuConfigurationSetup.h"

@implementation SideMenuConfigurationSetup

-(BOOL) isSideMenuEnabled{
    NSString* isSideMenuEnabledString = [configRetriever getConfigValue:configDictionary configKey:CONFIG_KEY_SIDEMENU level2SubKey:CONFIG_KEY_SIDEMENU_ENABLED];
    return [isSideMenuEnabledString isEqualToString:@"YES"];
}

-(NSArray*) getSideMenuItemArray{
    NSArray* sideMenuItemArray = [configRetriever getConfigArray:configDictionary configKey:CONFIG_KEY_SIDEMENU level2SubKey:CONFIG_KEY_SIDEMENU_MENU];
    return sideMenuItemArray;
    
}
@end
