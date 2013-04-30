//
//  ApplicationDelegateAction.h
//  Freestyle
//
//  Created by Kenneth on 18/3/13.
//
//

#import <Foundation/Foundation.h>

@protocol ApplicationDelegateAction <NSObject>

-(UIWindow*) getApplicationWindow;
-(void) beginApp;
@end
