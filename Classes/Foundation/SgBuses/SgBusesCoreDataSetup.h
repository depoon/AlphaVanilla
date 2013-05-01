//
//  SgBusesCoreDataSetup.h
//  Freestyle
//
//  Created by Kenneth on 8/4/13.
//
//

#import <Foundation/Foundation.h>
#import "SgBusesCoreDataUpdateUIAction.h"

@interface SgBusesCoreDataSetup : NSObject

-(void) setupCoreData;
-(BOOL) shouldResetupCoreData;
-(void) deleteAllBusData;

@property (nonatomic, retain) NSObject<SgBusesCoreDataUpdateUIAction>* sgBusesCoreDataUpdateUIActionDelegate;

@end
