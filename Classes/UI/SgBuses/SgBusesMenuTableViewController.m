//
//  SgBusesMenuTableViewController.m
//  Freestyle
//
//  Created by Kenneth on 8/4/13.
//
//

#import "SgBusesMenuTableViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "SgBusesBusStopTableViewController.h"
#import "AppConfigurationAction.h"
#import "SgBusesCoreDataSetupViewController.h"

@implementation SgBusesMenuTableViewController

-(void) viewDidLoad{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithRed:50.0/255.0 green:50.0/255.0 blue:50.0/255.0 alpha:1]];
    
    UIButton* busStopButton = [self generateBusStopButton: 0];
    UIButton* resetButton = [self generateResetButton: 120];
    [self.view addSubview:busStopButton];
    [self.view addSubview:resetButton];

    NSObject<AppConfigurationAction>* appDelegate = (NSObject<AppConfigurationAction>*) [[UIApplication sharedApplication] delegate];
    NSArray* _sideMenuItemArray = [[[appDelegate getConfiguration] getSideMenuConfigurationSetup] getSideMenuItemArray];
    NSDictionary* sideMenuItemDictionary = [_sideMenuItemArray objectAtIndex:0];
    NSString* menuItemName = [sideMenuItemDictionary objectForKey:CONFIG_KEY_SIDEMENU_MENU_NAME];
    self.title = menuItemName;

    self.navigationItem.backBarButtonItem =
    [[[UIBarButtonItem alloc] initWithTitle:@"Back"
                                      style:UIBarButtonItemStyleBordered
                                     target:nil
                                     action:nil] autorelease];

}

-(UIButton*) generateBusStopButton: (int) yPosition{
    UIImage* sgBusesBusImage = [UIImage imageNamed:@"SgBusesBusStop"];
    UIButton* busStopButton = [[[UIButton alloc]initWithFrame:CGRectMake(0, yPosition, sgBusesBusImage.size.width, sgBusesBusImage.size.height)] autorelease];
    CALayer * layer = [busStopButton layer];
    [layer setMasksToBounds:YES];
    //[layer setCornerRadius:5.0];
    [busStopButton addTarget:self  action:@selector(showBusStopFeature) forControlEvents:UIControlEventTouchUpInside];
    [busStopButton setBackgroundImage:sgBusesBusImage forState:UIControlStateNormal];

    UIView* blackView = [[UIView alloc]initWithFrame:CGRectMake(0, sgBusesBusImage.size.height-30,  sgBusesBusImage.size.width, 30)];
    [blackView setBackgroundColor:[UIColor blackColor]];
    [blackView setAlpha:0.3];
    [busStopButton addSubview:blackView];
    [blackView release];
    
    UILabel* buttonTextLabel = [[UILabel alloc]initWithFrame:blackView.frame];
    [buttonTextLabel setBackgroundColor:[UIColor clearColor]];
    [buttonTextLabel setText:@"Bus Stops Tracker"];
    [buttonTextLabel setTextColor:[UIColor whiteColor]];
    [buttonTextLabel setTextAlignment:NSTextAlignmentCenter];
    [buttonTextLabel setFont:[UIFont boldSystemFontOfSize:18]];
    [busStopButton addSubview:buttonTextLabel];
    [buttonTextLabel release];
    
    return busStopButton;
}

-(UIButton*) generateResetButton: (int) yPosition{
    UIImage* sgBusesBusImage = [UIImage imageNamed:@"SgBusesReset"];
    UIButton* busStopButton = [[[UIButton alloc]initWithFrame:CGRectMake(0, yPosition, sgBusesBusImage.size.width, sgBusesBusImage.size.height)] autorelease];
    CALayer * layer = [busStopButton layer];
    [layer setMasksToBounds:YES];
    //[layer setCornerRadius:5.0];
    [busStopButton addTarget:self  action:@selector(showBusStopResetViewController) forControlEvents:UIControlEventTouchUpInside];
    [busStopButton setBackgroundImage:sgBusesBusImage forState:UIControlStateNormal];
    
    UIView* blackView = [[UIView alloc]initWithFrame:CGRectMake(0, sgBusesBusImage.size.height-30,  sgBusesBusImage.size.width, 30)];
    [blackView setBackgroundColor:[UIColor blackColor]];
    [blackView setAlpha:0.3];
    [busStopButton addSubview:blackView];
    [blackView release];
    
    UILabel* buttonTextLabel = [[UILabel alloc]initWithFrame:blackView.frame];
    [buttonTextLabel setBackgroundColor:[UIColor clearColor]];
    [buttonTextLabel setText:@"Reset Data"];
    [buttonTextLabel setTextColor:[UIColor whiteColor]];
    [buttonTextLabel setTextAlignment:NSTextAlignmentCenter];
    [buttonTextLabel setFont:[UIFont boldSystemFontOfSize:18]];
    [busStopButton addSubview:buttonTextLabel];
    [buttonTextLabel release];
    
    return busStopButton;
}

-(void) showBusStopFeature{
    SgBusesBusStopTableViewController* sgBusesBusStopTableViewController = [[SgBusesBusStopTableViewController alloc]init];
    [self.navigationController pushViewController:sgBusesBusStopTableViewController animated:YES];
    [sgBusesBusStopTableViewController release];
}

-(void) showBusStopResetViewController{
    SgBusesCoreDataSetupViewController* sgBusesCoreDataSetupViewController = [[SgBusesCoreDataSetupViewController alloc]init];
    [self.navigationController pushViewController:sgBusesCoreDataSetupViewController animated:YES];
    [sgBusesCoreDataSetupViewController release];
}

@end
