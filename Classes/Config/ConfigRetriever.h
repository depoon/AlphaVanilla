//
//  ConfigRetriever.h
//  Freestyle
//
//  Created by Kenneth on 15/3/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConfigRetriever : NSObject

- (NSString*) getConfigValue: (NSDictionary*) plistData configKey: (NSString*) configKey;

- (NSString*) getConfigValue: (NSDictionary*) plistData configKey: (NSString*) configKey level2SubKey: (NSString*) level2SubKey;

- (NSString*) getConfigValue: (NSDictionary*) plistData configKey: (NSString*) configKey level2SubKey: (NSString*) level2SubKey level3SubKey: (NSString*) level3SubKey;

- (NSString*) getConfigValue: (NSDictionary*) plistData configKey: (NSString*) configKey level2SubKey: (NSString*) level2SubKey level3SubKey: (NSString*) level3SubKey level4SubKey: (NSString*) level4SubKey;

- (NSString*) getConfigValue: (NSDictionary*) plistData configKey: (NSString*) configKey level2SubKey: (NSString*) level2SubKey level3SubKey: (NSString*) level3SubKey level4SubKey: (NSString*) level4SubKey level5SubKey: (NSString*) level5SubKey;

- (NSString*) getConfigValue: (NSDictionary*) plistData configKey: (NSString*) configKey level2SubKey: (NSString*) level2SubKey level3SubKey: (NSString*) level3SubKey level4SubKey: (NSString*) level4SubKey level5SubKey: (NSString*) level5SubKey level6SubKey: (NSString*) level6SubKey;

- (NSArray*) getConfigArray: (NSDictionary*) plistData configKey: (NSString*) configKey;

- (NSArray*) getConfigArray: (NSDictionary*) plistData configKey: (NSString*) configKey level2SubKey: (NSString*) level2SubKey;

- (NSArray*) getConfigArray: (NSDictionary*) plistData configKey: (NSString*) configKey level2SubKey: (NSString*) level2SubKey level3SubKey: (NSString*) level3SubKey;


- (NSArray*) getConfigArray: (NSDictionary*) plistData configKey: (NSString*) configKey level2SubKey: (NSString*) level2SubKey level3SubKey: (NSString*) level3SubKey level4SubKey: (NSString*) level4SubKey;

- (NSArray*) getConfigArray: (NSDictionary*) plistData configKey: (NSString*) configKey level2SubKey: (NSString*) level2SubKey level3SubKey: (NSString*) level3SubKey level4SubKey: (NSString*) level4SubKey level5SubKey: (NSString*) level5SubKey;



- (NSDictionary*) getConfigDictionary: (NSDictionary*) plistData configKey: (NSString*) configKey level2SubKey: (NSString*) level2SubKey;

- (NSDictionary*) getConfigDictionary: (NSDictionary*) plistData configKey: (NSString*) configKey level2SubKey: (NSString*) level2SubKey level3SubKey: (NSString*) level3SubKey;

- (NSDictionary*) getConfigDictionary: (NSDictionary*) plistData configKey: (NSString*) configKey level2SubKey: (NSString*) level2SubKey level3SubKey: (NSString*) level3SubKey level4SubKey: (NSString*) level4SubKey;

- (NSDictionary*) getConfigDictionary: (NSDictionary*) plistData configKey: (NSString*) configKey level2SubKey: (NSString*) level2SubKey level3SubKey: (NSString*) level3SubKey level4SubKey: (NSString*) level4SubKey level5SubKey: (NSString*) level5SubKey;

- (NSDictionary*) getConfigDictionary: (NSDictionary*) plistData configKey: (NSString*) configKey level2SubKey: (NSString*) level2SubKey level3SubKey: (NSString*) level3SubKey level4SubKey: (NSString*) level4SubKey level5SubKey: (NSString*) level5SubKey level6SubKey: (NSString*) level6SubKey;

@end
