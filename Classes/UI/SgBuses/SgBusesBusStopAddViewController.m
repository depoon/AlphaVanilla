//
//  SgBusesAddViewController.m
//  Freestyle
//
//  Created by Kenneth on 7/4/13.
//
//

#import "SgBusesBusStopAddViewController.h"
#import "SgBusesBusStopAddTableViewController.h"
#import "PGKeyboardInputAccessoryViewGenerator.h"
#import "SgBusesBusStopPreviewViewController.h"

@implementation SgBusesBusStopAddViewController{
    @private UISearchBar* searchBar;
    @private SgBusesBusStopAddTableViewController* sgBusesBusStopAddTableViewController;
    @private NSOperationQueue* queue;
}


-(id) init{
    self = [super init];
    sgBusesBusStopAddTableViewController = [[SgBusesBusStopAddTableViewController alloc]init];
    sgBusesBusStopAddTableViewController.sgBusesBusStopSelectionActionDelegate = self;
    
    queue = [[NSOperationQueue alloc]init];
    return self;
}

-(void) dealloc{
    if (queue){
        [queue cancelAllOperations];
        [queue release];
        queue = nil;
    }
    if (searchBar){
        [searchBar release];
        searchBar = nil;
    }
    if (sgBusesBusStopAddTableViewController){
        [sgBusesBusStopAddTableViewController release];
        sgBusesBusStopAddTableViewController = nil;
    }
    [super dealloc];
}


-(void) setSearchBar: (UISearchBar*) _searchBar{
    if (searchBar){
        [searchBar release];
        searchBar = nil;
    }
    searchBar = [_searchBar retain];
}

-(void) viewDidLoad{
    [super viewDidLoad];
    
    UISearchBar* _topSearchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    [_topSearchBar setTintColor:[UIColor darkGrayColor]];
    [_topSearchBar setInputAccessoryView: [self generateInputAccessoryView]];
    [_topSearchBar setKeyboardType:UIKeyboardTypeNumberPad];
    [_topSearchBar setPlaceholder:@"Enter Bus Stop Number"];
    [_topSearchBar setDelegate:self];
    [self setSearchBar:_topSearchBar];
    [_topSearchBar release];
    
    [self.view addSubview:searchBar];

    
    [sgBusesBusStopAddTableViewController loadView];
    UITableView* addTableView = sgBusesBusStopAddTableViewController.tableView;
    [addTableView setFrame:CGRectMake(0, searchBar.frame.origin.y+searchBar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-searchBar.frame.size.height)];
    [self.view addSubview:addTableView];
    
    self.title = @"Bus Stop Selection";

}

-(UIView*) generateInputAccessoryView{
    PGKeyboardInputAccessoryViewGenerator* pgKeyboardInputAccessoryViewGenerator =[[PGKeyboardInputAccessoryViewGenerator alloc]init];
    UIView* inputAccessoryView = [pgKeyboardInputAccessoryViewGenerator generateInputAccessoryView:self];
    [pgKeyboardInputAccessoryViewGenerator release];
    return inputAccessoryView;
}

-(void) keyboardInputAccessoryDoneButtonPressed{
    [searchBar resignFirstResponder];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [sgBusesBusStopAddTableViewController searchBusStopsFor:searchText];
    
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:sgBusesBusStopAddTableViewController
                                                                            selector:@selector(searchBusStopsFor:)
                                                                              object:searchText];
    [queue addOperation:operation];
    [operation release];
}

-(void) busStopSelected: (BusStopCoreData*) busStop{
    SgBusesBusStopPreviewViewController* sgBusesBusStopPreviewViewController= [[SgBusesBusStopPreviewViewController alloc]initWithBusStopCoreData:busStop];
    [self.navigationController pushViewController:sgBusesBusStopPreviewViewController animated:YES];
    [sgBusesBusStopPreviewViewController release];

    
}


@end
