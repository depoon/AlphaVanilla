//
//  FileContentsReader.m
//  Freestyle
//
//  Created by Kenneth on 7/4/13.
//
//

#import "FileContentsReader.h"
#import "JSONKit.h"

@implementation FileContentsReader

-(NSDictionary*) getDictionaryValueFromFile: (NSString*) fileName{
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSString *finalPath = [path stringByAppendingPathComponent:fileName];
    return [NSDictionary dictionaryWithContentsOfFile:finalPath];
}

-(NSString*) getStringValueFromFile: (NSString*) fileName{
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSString *finalPath = [path stringByAppendingPathComponent:fileName];
    return [NSString stringWithContentsOfFile :finalPath
                                      encoding:NSUTF8StringEncoding
                                         error:nil];
}

-(NSDictionary*) getJsonDictionaryValueFromFile: (NSString*) fileName{
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSString *finalPath = [path stringByAppendingPathComponent:fileName];
    NSString* stringValue = [NSString stringWithContentsOfFile :finalPath
                                                       encoding:NSUTF8StringEncoding
                                                          error:nil];
    return (NSDictionary*) [stringValue objectFromJSONString];
}
@end
