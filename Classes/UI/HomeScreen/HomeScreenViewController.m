//
//  HomeScreenViewController.m
//  Freestyle
//
//  Created by Kenneth on 15/3/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "HomeScreenViewController.h"
#import "AppConfigurationAction.h"
#import "SideMenuNavigationAction.h"

int const HomeScreenViewController_BackgroundViewTag = 1;

@implementation HomeScreenViewController

-(NSString*) getHomeScreenBackgroundFileName{
    NSObject<AppConfigurationAction>* appDelegate = (NSObject<AppConfigurationAction>*) [[UIApplication sharedApplication] delegate];
    NSString* backgroundFileName = [[[appDelegate getConfiguration] getApplicationConfigurationSetup] getApplicationUIBackgroundFileName];
    return backgroundFileName;
}


-(UIImageView*) generateBackgroundView{
    UIImageView* backgroundView = [[[UIImageView alloc]initWithImage:[UIImage imageNamed:[self getHomeScreenBackgroundFileName]]]autorelease];
    [backgroundView setTag:HomeScreenViewController_BackgroundViewTag];
    return backgroundView;
}

-(void) viewDidLoad{
    [super viewDidLoad];
    UIView* backgroundView = [self generateBackgroundView];
    [self.view addSubview:backgroundView];
    
    
    NSObject<AppConfigurationAction>* appDelegate = (NSObject<AppConfigurationAction>*) [[UIApplication sharedApplication] delegate];
    BOOL isSideMenuEnabled = [[[appDelegate getConfiguration] getSideMenuConfigurationSetup] isSideMenuEnabled];
    

    if (isSideMenuEnabled){
        NSObject<SideMenuNavigationAction>* sideMenuNavigationController = (NSObject<SideMenuNavigationAction>*) self.navigationController;

        UIBarButtonItem* menuBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[sideMenuNavigationController generateMenuImage] style:UIBarButtonItemStylePlain target:sideMenuNavigationController action:@selector(menuButtonPressed:)];
        self.navigationItem.leftBarButtonItem = menuBarButtonItem;
        [menuBarButtonItem release];        
    }
    
    /*
    UIButton* aButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    [aButton setBackgroundColor:[UIColor greenColor]];
    [aButton addTarget:self action:@selector(log) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:aButton];
    [aButton release];
*/
}





-(void) log{
    NSLog(@"log");
   // [self.navigationController pushViewController:[[[HomeScreenViewController alloc]init]autorelease] animated:YES];
}




@end
