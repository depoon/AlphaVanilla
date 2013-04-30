//
//  ConfigRetriever.m
//  Freestyle
//
//  Created by Kenneth on 15/3/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "ConfigRetriever.h"

@implementation ConfigRetriever

- (NSString*) getConfigValue: (NSDictionary*) plistData configKey: (NSString*) configKey{
    NSString* configValue = (NSString*) [plistData objectForKey:configKey];
    return configValue;
}

- (NSString*) getConfigValue: (NSDictionary*) plistData configKey: (NSString*) configKey level2SubKey: (NSString*) level2SubKey{
    NSDictionary* level2Dictionary = (NSDictionary*) [plistData objectForKey:configKey];
    NSString* configValue = (NSString*) [level2Dictionary objectForKey:level2SubKey];
    return configValue;
}

- (NSString*) getConfigValue: (NSDictionary*) plistData configKey: (NSString*) configKey level2SubKey: (NSString*) level2SubKey level3SubKey: (NSString*) level3SubKey{
    NSDictionary* level2Dictionary = (NSDictionary*) [plistData objectForKey:configKey];
    NSDictionary* level3Dictionary = (NSDictionary*) [level2Dictionary objectForKey:level2SubKey];
    NSString* configValue = (NSString*)             [level3Dictionary objectForKey:level3SubKey];
    
    return configValue;
}

- (NSString*) getConfigValue: (NSDictionary*) plistData configKey: (NSString*) configKey level2SubKey: (NSString*) level2SubKey level3SubKey: (NSString*) level3SubKey level4SubKey: (NSString*) level4SubKey{
    NSDictionary* level2Dictionary = (NSDictionary*) [plistData objectForKey:configKey];
    NSDictionary* level3Dictionary = (NSDictionary*) [level2Dictionary objectForKey:level2SubKey];
    NSDictionary* level4Dictionary = (NSDictionary*) [level3Dictionary objectForKey:level3SubKey];
    NSString* configValue = (NSString*)             [level4Dictionary objectForKey:level4SubKey];
    
    return configValue;
}

- (NSString*) getConfigValue: (NSDictionary*) plistData configKey: (NSString*) configKey level2SubKey: (NSString*) level2SubKey level3SubKey: (NSString*) level3SubKey level4SubKey: (NSString*) level4SubKey level5SubKey: (NSString*) level5SubKey{   
    NSDictionary* level2Dictionary = (NSDictionary*) [plistData objectForKey:configKey];
    NSDictionary* level3Dictionary = (NSDictionary*) [level2Dictionary objectForKey:level2SubKey];
    NSDictionary* level4Dictionary = (NSDictionary*) [level3Dictionary objectForKey:level3SubKey];
    NSDictionary* level5Dictionary = (NSDictionary*) [level4Dictionary objectForKey:level4SubKey];
    NSString* configValue = (NSString*)             [level5Dictionary objectForKey:level5SubKey];
    
    return configValue;
}

- (NSString*) getConfigValue: (NSDictionary*) plistData configKey: (NSString*) configKey level2SubKey: (NSString*) level2SubKey level3SubKey: (NSString*) level3SubKey level4SubKey: (NSString*) level4SubKey level5SubKey: (NSString*) level5SubKey level6SubKey: (NSString*) level6SubKey{    
    NSDictionary* level2Dictionary = (NSDictionary*) [plistData objectForKey:configKey];
    NSDictionary* level3Dictionary = (NSDictionary*) [level2Dictionary objectForKey:level2SubKey];
    NSDictionary* level4Dictionary = (NSDictionary*) [level3Dictionary objectForKey:level3SubKey];
    NSDictionary* level5Dictionary = (NSDictionary*) [level4Dictionary objectForKey:level4SubKey];
    NSDictionary* level6Dictionary = (NSDictionary*) [level5Dictionary objectForKey:level5SubKey];
    NSString* configValue = (NSString*)             [level6Dictionary objectForKey:level6SubKey];
    
    return configValue;
}

- (NSArray*) getConfigArray: (NSDictionary*) plistData configKey: (NSString*) configKey{
    NSArray* configArray = (NSArray*) [plistData objectForKey:configKey];
    return configArray;
}

- (NSArray*) getConfigArray: (NSDictionary*) plistData configKey: (NSString*) configKey level2SubKey: (NSString*) level2SubKey{
    NSDictionary* level2Dictionary = (NSDictionary*) [plistData objectForKey:configKey];
    NSArray* configArray = (NSArray*) [level2Dictionary objectForKey:level2SubKey];
    return configArray;
}

- (NSArray*) getConfigArray: (NSDictionary*) plistData configKey: (NSString*) configKey level2SubKey: (NSString*) level2SubKey level3SubKey: (NSString*) level3SubKey{ 
    NSDictionary* level2Dictionary = (NSDictionary*) [plistData objectForKey:configKey];
    NSDictionary* level3Dictionary = (NSDictionary*) [level2Dictionary objectForKey:level2SubKey];
    NSArray* configArray = (NSArray*) [level3Dictionary objectForKey:level3SubKey];
    return configArray;
}


- (NSArray*) getConfigArray: (NSDictionary*) plistData configKey: (NSString*) configKey level2SubKey: (NSString*) level2SubKey level3SubKey: (NSString*) level3SubKey level4SubKey: (NSString*) level4SubKey{  
    NSDictionary* level2Dictionary = (NSDictionary*) [plistData objectForKey:configKey];
    NSDictionary* level3Dictionary = (NSDictionary*) [level2Dictionary objectForKey:level2SubKey];
    NSDictionary* level4Dictionary = (NSDictionary*) [level3Dictionary objectForKey:level3SubKey];
    NSArray* configArray = (NSArray*)            [level4Dictionary objectForKey:level4SubKey];
    return configArray;
}

- (NSArray*) getConfigArray: (NSDictionary*) plistData configKey: (NSString*) configKey level2SubKey: (NSString*) level2SubKey level3SubKey: (NSString*) level3SubKey level4SubKey: (NSString*) level4SubKey level5SubKey: (NSString*) level5SubKey{ 
    NSDictionary* level2Dictionary = (NSDictionary*) [plistData objectForKey:configKey];
    NSDictionary* level3Dictionary = (NSDictionary*) [level2Dictionary objectForKey:level2SubKey];
    NSDictionary* level4Dictionary = (NSDictionary*) [level3Dictionary objectForKey:level3SubKey];
    NSDictionary* level5Dictionary = (NSDictionary*) [level4Dictionary objectForKey:level4SubKey];
    NSArray* configArray = (NSArray*)            [level5Dictionary objectForKey:level5SubKey];
    return configArray;
}



- (NSDictionary*) getConfigDictionary: (NSDictionary*) plistData configKey: (NSString*) configKey level2SubKey: (NSString*) level2SubKey{
    NSDictionary* level2Dictionary = (NSDictionary*) [plistData objectForKey:configKey];
    NSDictionary* configDictionary = (NSDictionary*) [level2Dictionary objectForKey:level2SubKey];
    return configDictionary;
}

- (NSDictionary*) getConfigDictionary: (NSDictionary*) plistData configKey: (NSString*) configKey level2SubKey: (NSString*) level2SubKey level3SubKey: (NSString*) level3SubKey{
    NSDictionary* level2Dictionary = (NSDictionary*) [plistData objectForKey:configKey];
    NSDictionary* level3Dictionary = (NSDictionary*) [level2Dictionary objectForKey:level2SubKey];
    NSDictionary* configDictionary = (NSDictionary*) [level3Dictionary objectForKey:level3SubKey];
    return configDictionary;
}

- (NSDictionary*) getConfigDictionary: (NSDictionary*) plistData configKey: (NSString*) configKey level2SubKey: (NSString*) level2SubKey level3SubKey: (NSString*) level3SubKey level4SubKey: (NSString*) level4SubKey{
    NSDictionary* level2Dictionary = (NSDictionary*) [plistData objectForKey:configKey];
    NSDictionary* level3Dictionary = (NSDictionary*) [level2Dictionary objectForKey:level2SubKey];
    NSDictionary* level4Dictionary = (NSDictionary*) [level3Dictionary objectForKey:level3SubKey];
    NSDictionary* configDictionary = (NSDictionary*) [level4Dictionary objectForKey:level4SubKey];
    return configDictionary;
}

- (NSDictionary*) getConfigDictionary: (NSDictionary*) plistData configKey: (NSString*) configKey level2SubKey: (NSString*) level2SubKey level3SubKey: (NSString*) level3SubKey level4SubKey: (NSString*) level4SubKey level5SubKey: (NSString*) level5SubKey{
    NSDictionary* level2Dictionary = (NSDictionary*) [plistData objectForKey:configKey];
    NSDictionary* level3Dictionary = (NSDictionary*) [level2Dictionary objectForKey:level2SubKey];
    NSDictionary* level4Dictionary = (NSDictionary*) [level3Dictionary objectForKey:level3SubKey];
    NSDictionary* level5Dictionary = (NSDictionary*) [level4Dictionary objectForKey:level4SubKey];
    NSDictionary* configDictionary = (NSDictionary*) [level5Dictionary objectForKey:level5SubKey];
    return configDictionary;
}

- (NSDictionary*) getConfigDictionary: (NSDictionary*) plistData configKey: (NSString*) configKey level2SubKey: (NSString*) level2SubKey level3SubKey: (NSString*) level3SubKey level4SubKey: (NSString*) level4SubKey level5SubKey: (NSString*) level5SubKey level6SubKey: (NSString*) level6SubKey{
    NSDictionary* level2Dictionary = (NSDictionary*) [plistData objectForKey:configKey];
    NSDictionary* level3Dictionary = (NSDictionary*) [level2Dictionary objectForKey:level2SubKey];
    NSDictionary* level4Dictionary = (NSDictionary*) [level3Dictionary objectForKey:level3SubKey];
    NSDictionary* level5Dictionary = (NSDictionary*) [level4Dictionary objectForKey:level4SubKey];
    NSDictionary* level6Dictionary = (NSDictionary*) [level5Dictionary objectForKey:level5SubKey];
    NSDictionary* configDictionary = (NSDictionary*) [level6Dictionary objectForKey:level6SubKey];
    return configDictionary;
}

@end
