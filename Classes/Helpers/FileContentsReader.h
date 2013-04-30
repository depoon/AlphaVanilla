//
//  FileContentsReader.h
//  Freestyle
//
//  Created by Kenneth on 7/4/13.
//
//

#import <Foundation/Foundation.h>

@interface FileContentsReader : NSObject

-(NSDictionary*) getDictionaryValueFromFile: (NSString*) fileName;
-(NSString*) getStringValueFromFile: (NSString*) fileName;
-(NSDictionary*) getJsonDictionaryValueFromFile: (NSString*) fileName;
@end
