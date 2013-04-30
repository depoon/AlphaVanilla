//
//  ConfigurationSetup.h
//  Freestyle
//
//  Created by Kenneth on 15/3/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConfigRetriever.h"
#import "ConfigConstants.h"


@interface ConfigurationSetup : NSObject{
    @protected NSDictionary* configDictionary;
    @protected ConfigRetriever* configRetriever;
}

-(id)init __attribute__((unavailable("init not available")));

-(id) initWithConfigDictionary: (NSDictionary*) _configDictionary;
-(void) setConfigDictionary:(NSDictionary*) _configDictionary;
@end
