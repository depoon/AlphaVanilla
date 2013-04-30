//
//  SideMenuNavigationController.h
//  Freestyle
//
//  Created by Kenneth on 18/3/13.
//
//

#import <Foundation/Foundation.h>
#import "SideMenuNavigationAction.h"
#import "PGKeyboardInputAccessoryAction.h"

@interface SideMenuNavigationController : UINavigationController<SideMenuNavigationAction, PGKeyboardInputAccessoryAction, UINavigationControllerDelegate, UIGestureRecognizerDelegate>

-(void) closeMenu;
@end
