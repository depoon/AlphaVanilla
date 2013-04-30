//
//  SideMenuController.m
//  Freestyle
//
//  Created by Kenneth on 1/4/13.
//
//

#import "SideMenuController.h"
#import "SgBusesMenuTableViewController.h"

@implementation SideMenuController
@synthesize sideMenuNavigationController;

-(void) dealloc{
    if (sideMenuNavigationController){
        [sideMenuNavigationController release];
        sideMenuNavigationController = nil;
    }
    [super dealloc];
}

-(void) showSgBuses{
    [sideMenuNavigationController popToRootViewControllerAnimated:NO];
    [sideMenuNavigationController closeMenu];

    SgBusesMenuTableViewController* sgBusesMenuTableViewController = [[SgBusesMenuTableViewController alloc]init];
    [sideMenuNavigationController pushViewController:sgBusesMenuTableViewController animated:YES];
    [sgBusesMenuTableViewController release];
     
}
@end
