//
//  SgBusesViewController.m
//  Freestyle
//
//  Created by Kenneth on 1/4/13.
//
//

#import "SgBusesBusStopTableViewController.h"
#import "AppConfigurationAction.h"
#import "SgBusesCoreDataManager.h"
#import "SgBusesViewGenerator.h"
#import "SgBusesShortListBusStopFeedComponent.h"
#import "SgBusesBusStopEditTableViewController.h"
#import "SgBusesShortListBusRouteFeedComponent.h"

@implementation SgBusesBusStopTableViewController{
    @private NSArray* feedComponentArray;
    @private NSOperationQueue* queue;
    
    @private EGORefreshTableHeaderView *refreshHeaderView;
    @private BOOL _reloading;
}

-(id) init{
    self = [super init];
    [self setFeedComponentArray:[NSArray array]];
    queue = [[NSOperationQueue alloc]init];
    return self;
}

-(void) dealloc{
    if (refreshHeaderView){
        [refreshHeaderView release];
        refreshHeaderView = nil;
    }
    if (queue){
        [queue cancelAllOperations];
        [queue release];
        queue = nil;
    }
    if (feedComponentArray){
        [feedComponentArray release];
        feedComponentArray = nil;
    }
    [super dealloc];
}

-(void) setRefreshHeaderView: (EGORefreshTableHeaderView*) _refreshHeaderView{
    if (refreshHeaderView){
        [refreshHeaderView release];
        refreshHeaderView = nil;
    }
    refreshHeaderView = [_refreshHeaderView retain];
}

-(void) setFeedComponentArray: (NSArray*) _feedComponentArray{
    if (feedComponentArray){
        [feedComponentArray release];
        feedComponentArray = nil;
    }
    feedComponentArray = [_feedComponentArray retain];
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

-(void) reloadShortList{
    SgBusesCoreDataManager* sgBusesCoreDataManager = [[SgBusesCoreDataManager alloc]init];
    NSArray* _shortListedBusStopArray = [sgBusesCoreDataManager getAllShortListedBusStopArray];
    [sgBusesCoreDataManager release];
    
    NSMutableArray* feedArray = [NSMutableArray array];
    for (ShortListedBusStopCoreData* shortListedBusStop in _shortListedBusStopArray){
        SgBusesShortListBusStopFeedComponent* feedComponent = [[SgBusesShortListBusStopFeedComponent alloc]initWithShortListedBusStopCoreData:shortListedBusStop];
        feedComponent.sgTableViewUpdatableActionDelegate = self;
        [feedArray addObject:feedComponent];
        [feedComponent release];
    }
    [self setFeedComponentArray:feedArray];
    [self.tableView reloadData];
}

-(void) viewDidLoad{
    [super viewDidLoad];

    [self.view setBackgroundColor:[UIColor colorWithRed:50.0/255.0 green:50.0/255.0 blue:50.0/255.0 alpha:1]];
    self.title = @"Bus Stops Tracker";
    

    
    
    [self.tableView setSeparatorColor:[UIColor blackColor]];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editBusesList)];
    
  //  [self initWithFrame:frame arrowImageName:@"blueArrow.png" textColor:TEXT_COLOR]
    CGRect refreshFrame = CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, self.view.frame.size.width, self.tableView.bounds.size.height);
    EGORefreshTableHeaderView *_refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:refreshFrame arrowImageName:@"whiteArrow.png" textColor:[UIColor whiteColor]];
    _refreshHeaderView.backgroundColor = [self.view backgroundColor];
    _refreshHeaderView.delegate = self;
    [self.tableView addSubview:_refreshHeaderView];
    [self setRefreshHeaderView:_refreshHeaderView];
    [_refreshHeaderView release];
}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self reloadShortList];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [feedComponentArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    SgBusesShortListBusStopFeedComponent* feedComponent = (SgBusesShortListBusStopFeedComponent*) [feedComponentArray objectAtIndex:indexPath.row];
    ShortListedBusStopCoreData* shortListedBusStop = [feedComponent getShortListedBusStop];
    
    SgBusesViewGenerator* sgBusesViewGenerator = [[SgBusesViewGenerator alloc]init];
    int height = [sgBusesViewGenerator calculateShortListCellViewHeightFor:shortListedBusStop];
    [sgBusesViewGenerator release];
    return height;
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
    
    SgBusesShortListBusStopFeedComponent* feedComponent = (SgBusesShortListBusStopFeedComponent*) [feedComponentArray objectAtIndex:indexPath.row];
    
    ShortListedBusStopCoreData* shortListedBusStop = [feedComponent getShortListedBusStop];
    
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
    [busStopNumberLabel setFont:[UIFont boldSystemFontOfSize:14]];
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
    
    NSArray* busNumberArray = [feedComponent getBusNumberArray];
    
    int baseYCoor = 50;
    for (int i=0; i<[busNumberArray count]; i++){
        SgBusesShortListBusRouteFeedComponent* busRouteFeedComponent = (SgBusesShortListBusRouteFeedComponent*) [busNumberArray objectAtIndex:i];
        SgBusesUIDomainBusRouteDetails* busRouteDetails = [busRouteFeedComponent getBusRouteDetails];


        int height = baseYCoor + (25 * i);
        
        UILabel* busNumberLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(20, height, 250, 20)];
        [busNumberLabel1 setBackgroundColor:[UIColor clearColor]];
        [busNumberLabel1 setTextAlignment:NSTextAlignmentLeft];
        [busNumberLabel1 setTextColor:[self generateYellowColor]];
        [busNumberLabel1 setText:[busRouteDetails getBusNumber]];
        [busNumberLabel1 setFont:[UIFont boldSystemFontOfSize:12]];
        [cell.contentView addSubview:busNumberLabel1];
        [busNumberLabel1 release];

        UILabel* busFirstTimingLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(100, height, 250, 20)];
        [busFirstTimingLabel1 setBackgroundColor:[UIColor clearColor]];
        [busFirstTimingLabel1 setTextAlignment:NSTextAlignmentLeft];
        [busFirstTimingLabel1 setTextColor:[self generateRedColor]];
        [busFirstTimingLabel1 setText:[busRouteDetails getNextArrivalMessage]];
        [busFirstTimingLabel1 setFont:[UIFont boldSystemFontOfSize:12]];
        [cell.contentView addSubview:busFirstTimingLabel1];
        [busFirstTimingLabel1 release];
        
        UILabel* busFirstTimingLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(180, height, 250, 20)];
        [busFirstTimingLabel2 setBackgroundColor:[UIColor clearColor]];
        [busFirstTimingLabel2 setTextAlignment:NSTextAlignmentLeft];
        [busFirstTimingLabel2 setTextColor:[self generateGreenColor]];
        [busFirstTimingLabel2 setText:@"11 mins"];
        [busFirstTimingLabel2 setFont:[UIFont boldSystemFontOfSize:12]];
        [cell.contentView addSubview:busFirstTimingLabel2];
        [busFirstTimingLabel2 release];

    }
    
    /*

    */
    
    return cell;
}


-(void) editBusesList{
    SgBusesBusStopEditTableViewController* sgBusesBusStopEditTableViewController = [[SgBusesBusStopEditTableViewController alloc]init];
    [self.navigationController pushViewController:sgBusesBusStopEditTableViewController animated:YES];
    [sgBusesBusStopEditTableViewController release];
    
}

-(void) clearAllTimings{
    for (SgBusesShortListBusStopFeedComponent* feedComponent in feedComponentArray){
        [feedComponent clearTiming];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];


    
    SgBusesShortListBusStopFeedComponent* feedComponent = (SgBusesShortListBusStopFeedComponent*) [feedComponentArray objectAtIndex:indexPath.row];
    [feedComponent updateTiming];

}

-(void) updateTable{
    [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    //[self.tableView performSelectorInBackground:@selector(reloadData) withObject:nil];
}

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    
    [self reloadTableViewDataSource];
    for (SgBusesShortListBusStopFeedComponent* feedComponent in feedComponentArray){
        [feedComponent clearTiming];
    }
    
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
    for (SgBusesShortListBusStopFeedComponent* feedComponent in feedComponentArray){
        [feedComponent updateTiming];
    }



    
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
    
    return _reloading; // should return if data source model is reloading
    
}

- (void)reloadTableViewDataSource{
    
    // should be calling your tableviews data source model to reload
    // put here just for demo
    _reloading = YES;
    
}

- (void)doneLoadingTableViewData{
    
    // model should call this when its done loading
    _reloading = NO;
    [refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    [refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    
}

@end
