//
//  SgBusesEditTableViewController.m
//  Freestyle
//
//  Created by Kenneth on 5/4/13.
//
//

#import "SgBusesBusStopEditTableViewController.h"
#import "AppConfigurationAction.h"
#import <QuartzCore/QuartzCore.h>
#import "PGKeyboardInputAccessoryViewGenerator.h"
#import "SgBusesBusStopAddViewController.h"
#import "SgBusesCoreDataManager.h"

@implementation SgBusesBusStopEditTableViewController{
    @private NSArray* shortListedBusStopArray;
}

-(id) init{
    self = [super init];
    [self setShortListedBusStopArray:[NSArray array]];
    return self;
}

-(void) dealloc{
    if (shortListedBusStopArray){
        [shortListedBusStopArray release];
        shortListedBusStopArray = nil;
    }
    [super dealloc];
}

-(void) setShortListedBusStopArray: (NSArray*) _shortListedBusStopArray{
    if (shortListedBusStopArray){
        [shortListedBusStopArray release];
        shortListedBusStopArray = nil;
    }
    shortListedBusStopArray = [_shortListedBusStopArray retain];
}

-(UIColor*) generateLightBlueColor{
    return [UIColor colorWithRed:51.0/255.0 green:204.0/255.0 blue:255.0/255.0 alpha:1];
}

-(UIColor*) generateYellowColor{
    return [UIColor colorWithRed:255.0/255.0 green:204.0/255.0 blue:51.0/255.0 alpha:1];
}

-(UIColor*) generateRedColor{
    return [UIColor colorWithRed:255.0/255.0 green:71.0/255.0 blue:117.0/255.0 alpha:1];
}

-(UIColor*) generateGreenColor{
    return [UIColor colorWithRed:117.0/255.0 green:225.0/255.0 blue:71/255.0 alpha:1];
}

-(UIView*) generateInputAccessoryView{
    PGKeyboardInputAccessoryViewGenerator* pgKeyboardInputAccessoryViewGenerator =[[PGKeyboardInputAccessoryViewGenerator alloc]init];
    UIView* inputAccessoryView = [pgKeyboardInputAccessoryViewGenerator generateInputAccessoryView:self];
    [pgKeyboardInputAccessoryViewGenerator release];
    return inputAccessoryView;
}

-(void) reloadShortList{
    SgBusesCoreDataManager* sgBusesCoreDataManager = [[SgBusesCoreDataManager alloc]init];
    NSArray* _shortListedBusStopArray = [sgBusesCoreDataManager getAllShortListedBusStopArray];
    [sgBusesCoreDataManager release];
    [self setShortListedBusStopArray:_shortListedBusStopArray];
}

-(void) viewDidLoad{
    [super viewDidLoad];
    self.navigationItem.backBarButtonItem =
    [[[UIBarButtonItem alloc] initWithTitle:@"Back"
                                      style:UIBarButtonItemStyleBordered
                                     target:nil
                                     action:nil] autorelease];
    [self.view setBackgroundColor:[UIColor colorWithRed:50.0/255.0 green:50.0/255.0 blue:50.0/255.0 alpha:1]];
    NSObject<AppConfigurationAction>* appDelegate = (NSObject<AppConfigurationAction>*) [[UIApplication sharedApplication] delegate];
    NSArray* _sideMenuItemArray = [[[appDelegate getConfiguration] getSideMenuConfigurationSetup] getSideMenuItemArray];
    NSDictionary* sideMenuItemDictionary = [_sideMenuItemArray objectAtIndex:0];
    NSString* menuItemName = [sideMenuItemDictionary objectForKey:CONFIG_KEY_SIDEMENU_MENU_NAME];
    [self setTitle:menuItemName];
    
    [self.navigationItem setHidesBackButton:YES];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveBusesList)];

    
    [self.tableView setEditing:YES];
    
    [self.tableView setSeparatorColor:[UIColor blackColor]];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addBusToShortlist)];
    /*
     UITextField* busStopTextField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 100, 50)];
     [busStopTextField setBackgroundColor:[UIColor blackColor]];
     [busStopTextField setTextColor:[UIColor whiteColor]];
     busStopTextField.layer.cornerRadius = 8;
     [self.view addSubview:busStopTextField];
     [busStopTextField release];
     */
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [shortListedBusStopArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self reloadShortList];
    [self.tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             SimpleTableIdentifier];
	if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SimpleTableIdentifier] autorelease];
	}
	if([cell.contentView subviews]){
		for (UIView *subviews in [cell.contentView subviews]){
			[subviews removeFromSuperview];
		}
	}
    
    ShortListedBusStopCoreData* shortListedBusStop = (ShortListedBusStopCoreData*) [shortListedBusStopArray objectAtIndex:indexPath.row];
    
    UILabel* busStopLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 70, 20)];
    [busStopLabel setBackgroundColor:[UIColor clearColor]];
    [busStopLabel setTextAlignment:NSTextAlignmentLeft];
    [busStopLabel setTextColor:[self generateLightBlueColor]];
    [busStopLabel setText:@"Bus Stop: "];
    [busStopLabel setFont:[UIFont boldSystemFontOfSize:12]];
    [cell.contentView addSubview:busStopLabel];
    [busStopLabel release];
    
    UILabel* busStopNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 10, 70, 20)];
    [busStopNumberLabel setBackgroundColor:[UIColor clearColor]];
    [busStopNumberLabel setTextAlignment:NSTextAlignmentLeft];
    [busStopNumberLabel setTextColor:[UIColor whiteColor]];
    [busStopNumberLabel setText:shortListedBusStop.busStop.busStopNumber];
    busStopNumberLabel.layer.cornerRadius = 5;
    [busStopNumberLabel setFont:[UIFont systemFontOfSize:14]];
    [cell.contentView addSubview:busStopNumberLabel];
    [busStopNumberLabel release];
    
    UILabel* busStopNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 30, 250, 20)];
    [busStopNameLabel setBackgroundColor:[UIColor clearColor]];
    [busStopNameLabel setTextAlignment:NSTextAlignmentLeft];
    [busStopNameLabel setTextColor:[UIColor whiteColor]];
    [busStopNameLabel setText:shortListedBusStop.busStop.busStopName];
    [busStopNameLabel setFont:[UIFont boldSystemFontOfSize:12]];
    [cell.contentView addSubview:busStopNameLabel];
    [busStopNameLabel release];
    /*
    UILabel* busNumberLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(20, 50, 250, 20)];
    [busNumberLabel1 setBackgroundColor:[UIColor clearColor]];
    [busNumberLabel1 setTextAlignment:NSTextAlignmentLeft];
    [busNumberLabel1 setTextColor:[self generateYellowColor]];
    [busNumberLabel1 setText:@"970"];
    [busNumberLabel1 setFont:[UIFont boldSystemFontOfSize:12]];
    [cell.contentView addSubview:busNumberLabel1];
    [busNumberLabel1 release];
    
    UILabel* busFirstTimingLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(100, 50, 250, 20)];
    [busFirstTimingLabel1 setBackgroundColor:[UIColor clearColor]];
    [busFirstTimingLabel1 setTextAlignment:NSTextAlignmentLeft];
    [busFirstTimingLabel1 setTextColor:[self generateRedColor]];
    [busFirstTimingLabel1 setText:@"2 mins"];
    [busFirstTimingLabel1 setFont:[UIFont boldSystemFontOfSize:12]];
    [cell.contentView addSubview:busFirstTimingLabel1];
    [busFirstTimingLabel1 release];
    
    UILabel* busFirstTimingLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(180, 50, 250, 20)];
    [busFirstTimingLabel2 setBackgroundColor:[UIColor clearColor]];
    [busFirstTimingLabel2 setTextAlignment:NSTextAlignmentLeft];
    [busFirstTimingLabel2 setTextColor:[self generateGreenColor]];
    [busFirstTimingLabel2 setText:@"11 mins"];
    [busFirstTimingLabel2 setFont:[UIFont boldSystemFontOfSize:12]];
    [cell.contentView addSubview:busFirstTimingLabel2];
    [busFirstTimingLabel2 release];
    
    */
    return cell;
}

-(void) keyboardInputAccessoryDoneButtonPressed{
   // [topSearchBar resignFirstResponder];
}

-(void) addBusToShortlist{
    SgBusesBusStopAddViewController* sgBusesBusStopAddTableViewController = [[SgBusesBusStopAddViewController alloc]init];
    [self.navigationController pushViewController:sgBusesBusStopAddTableViewController animated:YES];
    [sgBusesBusStopAddTableViewController release];
}

-(void) saveBusesList{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete){
        ShortListedBusStopCoreData* shortListedBusStop = (ShortListedBusStopCoreData*) [shortListedBusStopArray objectAtIndex:indexPath.row];
        SgBusesCoreDataManager* sgBusesCoreDataManager = [[SgBusesCoreDataManager alloc]init];
        [sgBusesCoreDataManager removeShortListedBusStop:shortListedBusStop];
        [sgBusesCoreDataManager release];
 
        [self reloadShortList];
        
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        return;
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(SgBusesCoreDataManager*) generateSgBusesCoreDataManager{
    SgBusesCoreDataManager* sgBusesCoreDataManager = [[[SgBusesCoreDataManager alloc]init]autorelease];
    return sgBusesCoreDataManager;
}
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    NSLog(@"moveRowAtIndexPath");
    
    int sourceIndex = sourceIndexPath.row;
    int targetIndex = destinationIndexPath.row;
    
    
    ShortListedBusStopCoreData* movedShortListedBusStop = (ShortListedBusStopCoreData*) [shortListedBusStopArray objectAtIndex: sourceIndex];
    float targetTempRank = 0.5+targetIndex;
    [movedShortListedBusStop setRank:[NSNumber numberWithFloat:targetTempRank]];
    
    NSSortDescriptor *sortDesc = [NSSortDescriptor sortDescriptorWithKey:@"rank" ascending:YES];
    NSArray *sortedShortlistedBusStopsArray = [shortListedBusStopArray sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDesc]];
    
    for (int i=0; i<[sortedShortlistedBusStopsArray count]; i++){
        ShortListedBusStopCoreData* shortListedBusStop = (ShortListedBusStopCoreData*) [shortListedBusStopArray objectAtIndex:i];
        [shortListedBusStop setRank:[NSNumber numberWithInt:i]];
    }
    
    SgBusesCoreDataManager* sgBusesCoreDataManager = [self generateSgBusesCoreDataManager];
    [sgBusesCoreDataManager saveContext];
    

    
}


@end
