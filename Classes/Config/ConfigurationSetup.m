//
//  ConfigurationSetup.m
//  Freestyle
//
//  Created by Kenneth on 15/3/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "ConfigurationSetup.h"


@implementation ConfigurationSetup{

}


-(id) initWithConfigDictionary: (NSDictionary*) _configDictionary{
    self = [super init];
    [self setConfigDictionary:_configDictionary];
    configRetriever = [[ConfigRetriever alloc]init];
    return self;

}

-(void) dealloc{
    if (configRetriever){
        [configRetriever release];
        configRetriever = nil;
    }
    if (configDictionary){
        [configDictionary release];
        configDictionary = nil;
    }

    [super dealloc];
}

-(void) setConfigDictionary:(NSDictionary*) _configDictionary{
    if (configDictionary){
        [configDictionary release];
        configDictionary = nil;
    }
    configDictionary = [_configDictionary retain];
}

@end
