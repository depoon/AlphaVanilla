//
//  SideMenuNavigationAction.h
//  Freestyle
//
//  Created by Kenneth on 18/3/13.
//
//

#import <Foundation/Foundation.h>

@protocol SideMenuNavigationAction <NSObject>

-(UIImage *)generateMenuImage ;
- (void)menuButtonPressed:(id)sender;
-(UIView*) generateSideMenuView;
@end
