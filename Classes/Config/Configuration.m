//
//  Configuration.m
//  Freestyle
//
//  Created by Kenneth on 15/3/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "Configuration.h"
#import "FileContentsReader.h"

@implementation Configuration{

    
    ApplicationConfigurationSetup* applicationConfigurationSetup;
    SideMenuConfigurationSetup* sideMenuConfigurationSetup;
}


-(id) initWithConfigFilePath: (NSString*) configFilePath{
    self = [super init];
    
    FileContentsReader* fileContentsReader = [[FileContentsReader alloc]init];
    NSDictionary *plistData = [fileContentsReader getDictionaryValueFromFile:configFilePath];
    [fileContentsReader release];

    applicationConfigurationSetup = [[ApplicationConfigurationSetup alloc]initWithConfigDictionary:plistData];
    sideMenuConfigurationSetup = [[SideMenuConfigurationSetup alloc]initWithConfigDictionary:plistData];
    return self;
    
}

-(void) dealloc{
    if (applicationConfigurationSetup){
        [applicationConfigurationSetup release];
        applicationConfigurationSetup = nil;
    }
    [super dealloc];
}

-(void) setConfigDictionary:(NSDictionary*) configDictionary{
    [applicationConfigurationSetup setConfigDictionary:configDictionary];
    [sideMenuConfigurationSetup setConfigDictionary:configDictionary];
}

-(ApplicationConfigurationSetup*) getApplicationConfigurationSetup{
    return applicationConfigurationSetup;
}

-(SideMenuConfigurationSetup*) getSideMenuConfigurationSetup{
    return sideMenuConfigurationSetup;
    
}

@end
