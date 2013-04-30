//
//  SgBusesBusStopPreviewViewController.m
//  Freestyle
//
//  Created by Kenneth on 8/4/13.
//
//

#import "SgBusesBusStopPreviewViewController.h"
#import "SgBusesViewGenerator.h"
#import "SgBusesBusStopTableViewController.h"
#import "SgBusesCoreDataManager.h"

@implementation SgBusesBusStopPreviewViewController{
    @private BusStopCoreData* busStop;
    @private SgBusesViewGenerator* sgBusesViewGenerator;
}


-(id) initWithBusStopCoreData: (BusStopCoreData*) _busStop{
    self = [super init];
    busStop = _busStop;
    sgBusesViewGenerator = [[SgBusesViewGenerator alloc]init];
/*
    SgBusesCoreDataManager* sgBusesCoreDataManager = [[SgBusesCoreDataManager alloc]init];
    [sgBusesCoreDataManager removeAllShortListedBusStop];
    [sgBusesCoreDataManager saveContext];
    [sgBusesCoreDataManager release];
*/
    
    return self;
}

-(void) dealloc{
    if (sgBusesViewGenerator){
        [sgBusesViewGenerator release];
        sgBusesViewGenerator = nil;
    }
    [super dealloc];
}

-(void) viewDidLoad{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithRed:50.0/255.0 green:50.0/255.0 blue:50.0/255.0 alpha:1]];
    


    UIView* contentView = [sgBusesViewGenerator generateSgBusesBusStopPreviewViewFor:busStop rectSize:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:contentView];

}

-(SgBusesCoreDataManager*) generateSgBusesCoreDataManager{
    SgBusesCoreDataManager* sgBusesCoreDataManager = [[[SgBusesCoreDataManager alloc]init]autorelease];
    return sgBusesCoreDataManager;
}

-(void) shortlistBusStop{
    SgBusesCoreDataManager* sgBusesCoreDataManager = [self generateSgBusesCoreDataManager];

    @try {
        [sgBusesCoreDataManager createShortListedBusStop:busStop];
        [sgBusesCoreDataManager saveContext];
    } @catch (NSException *exception) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Shortlist Error"
                                                        message:[exception description]
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        return;

    }

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Shortlist Success"
                                                    message:[NSString stringWithFormat:@"Bus Stop %@ successfully shortlisted", busStop.busStopNumber]
                                                   delegate:self
                                          cancelButtonTitle:@"Ok"
                                          otherButtonTitles:nil, nil];
    [alert show];
    [alert release];



    
    NSArray* viewControllerArray = [self.navigationController viewControllers];
    for (UIViewController* viewController in viewControllerArray){
        if ([viewController isKindOfClass:[SgBusesBusStopTableViewController class]]){
            [self.navigationController popToViewController:viewController animated:YES];
        }
    }
    
    
}
@end
