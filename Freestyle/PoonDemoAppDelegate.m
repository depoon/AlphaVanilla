//
//  PoonDemoAppDelegate.m
//  Freestyle
//
//  Created by Kenneth on 15/3/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "PoonDemoAppDelegate.h"
#import "ViewControllerGenerator.h"
#import "SideMenuNavigationController.h"
#import "CoreDataManager.h"
#import "SgBusesCoreDataSetup.h"
#import "SgBusesCoreDataSetupViewController.h"

NSString* const CONFIG_FILE           = @"Config.plist";

@implementation PoonDemoAppDelegate{
    @private ViewControllerGenerator* viewControllerGenerator;
    @private Configuration* configuration;
    @private CoreDataManager* coreDataManager;
}

@synthesize window = _window;

- (void)dealloc{
    if (coreDataManager){
        [coreDataManager release];
        coreDataManager = nil;
    }
    if (viewControllerGenerator){
        [viewControllerGenerator release];
        viewControllerGenerator = nil;
    }
    if (configuration){
        [configuration release];
        configuration = nil;
    }
    [_window release];
    [super dealloc];
}

-(void) setViewControllerGenerator: (ViewControllerGenerator*) _viewControllerGenerator{
    if (viewControllerGenerator){
        [viewControllerGenerator release];
        viewControllerGenerator = nil;
    }
    viewControllerGenerator = [_viewControllerGenerator retain];
}   

-(void) setConfiguration: (Configuration*) _configuration{
    if (configuration){
        [configuration release];
        configuration = nil;
    }
    configuration = [_configuration retain];
    
}

-(Configuration*) getConfiguration{
    return configuration;
}

-(SgBusesCoreDataSetup*) generateSgBusesCoreDataSetup{
    SgBusesCoreDataSetup* sgBusesCoreDataSetup = [[[SgBusesCoreDataSetup alloc]init]autorelease];
    return sgBusesCoreDataSetup;
}

-(void) beginApp{
    SideMenuNavigationController* sideMenuNavigationController = [[SideMenuNavigationController alloc]initWithRootViewController:[viewControllerGenerator createHomeScreenViewController]];
    [[sideMenuNavigationController navigationBar] setTintColor:[UIColor colorWithRed:10.0/255.0 green:10/255.0 blue:10/255.0 alpha:1]];
    
    UIView* sideMenu = [sideMenuNavigationController generateSideMenuView];
    [self.window addSubview:sideMenu];
    [self.window setRootViewController:sideMenuNavigationController];
    [sideMenuNavigationController release];
    
    [self.window sendSubviewToBack:sideMenu];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];

    Configuration* _configuration = [[Configuration alloc]initWithConfigFilePath:CONFIG_FILE];
    [self setConfiguration:_configuration];
    [_configuration release];
    
    ViewControllerGenerator* _viewControllerGenerator = [[ViewControllerGenerator alloc]init];
    [self setViewControllerGenerator:_viewControllerGenerator];
    [_viewControllerGenerator release];

    [self.window makeKeyAndVisible];
    
    coreDataManager = [[CoreDataManager alloc]init];
    SgBusesCoreDataSetup* sgBusesCoreDataSetup = [self generateSgBusesCoreDataSetup];
    BOOL shouldResetupCoreData = [sgBusesCoreDataSetup shouldResetupCoreData];
    if (shouldResetupCoreData){
        SgBusesCoreDataSetupViewController* sgBusesCoreDataSetupViewController = [[SgBusesCoreDataSetupViewController alloc]init];
        [sgBusesCoreDataSetupViewController setIsLaunchedDuringStartup:YES];
        [self.window setRootViewController:sgBusesCoreDataSetupViewController];
        sgBusesCoreDataSetup.sgBusesCoreDataUpdateUIActionDelegate = sgBusesCoreDataSetupViewController;
        [sgBusesCoreDataSetupViewController release];
        
    }else{
        [self beginApp];        
    }



    
    
    


    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

-(UIWindow*) getApplicationWindow{
    return self.window;
}

- (NSManagedObjectContext *)managedObjectContextForModule:(NSString *)module{
    return [coreDataManager managedObjectContextForModule:module];
}
- (void)saveContextForModule:(NSString *)module{
    return [coreDataManager saveContextForModule:module];
}
-(NSString*) getCoreDataModelResourceNameForModule:(NSString *)module{
    return [coreDataManager getCoreDataModelResourceNameForModule:module];
}
@end
