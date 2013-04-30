//
//  ViewControllerGenerator.m
//  Freestyle
//
//  Created by Kenneth on 15/3/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "ViewControllerGenerator.h"
#import "HomeScreenViewController.h"

@implementation ViewControllerGenerator

-(UIViewController*) createHomeScreenViewController{
    HomeScreenViewController* homeScreenViewController = [[[HomeScreenViewController alloc]init]autorelease];
    return homeScreenViewController;
}

@end
