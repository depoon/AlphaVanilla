//
//  SideMenuConfigurationSetup.h
//  Freestyle
//
//  Created by Kenneth on 18/3/13.
//
//

#import <Foundation/Foundation.h>
#import "ConfigurationSetup.h"

@interface SideMenuConfigurationSetup : ConfigurationSetup

-(BOOL) isSideMenuEnabled;
-(NSArray*) getSideMenuItemArray;
@end
