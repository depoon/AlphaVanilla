//
//  CoreDataManagerAction.h
//  Freestyle
//
//  Created by Kenneth on 8/4/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@protocol CoreDataManagerAction <NSObject>

- (NSManagedObjectContext *)managedObjectContextForModule: (NSString*) module;
- (void)saveContextForModule: (NSString*) module;
-(NSString*) getCoreDataModelResourceNameForModule: (NSString*) module;
@end
