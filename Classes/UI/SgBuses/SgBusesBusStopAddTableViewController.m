//
//  SgBusesAddTableViewController.m
//  Freestyle
//
//  Created by Kenneth on 7/4/13.
//
//

#import "SgBusesBusStopAddTableViewController.h"
#import "FileContentsReader.h"
#import <MapKit/MapKit.h>
#import "SGBusesMapAnnotation.h"
#import "SgBusesCoreDataManager.h"
#import "BusStopCoreData.h"
#import "SgBusesViewGenerator.h"




@implementation SgBusesBusStopAddTableViewController{
    @private NSDictionary* busStopDictionary;
    @private NSArray* filteredBusStopArray;

}
@synthesize sgBusesBusStopSelectionActionDelegate;


-(id) init{
    self = [super init];
    FileContentsReader* fileContentsReader = [[FileContentsReader alloc]init];
    NSDictionary *jsonData = [fileContentsReader getJsonDictionaryValueFromFile:@"bus-stops.json"];
    [fileContentsReader release];
    
    [self setBusStopDictionary:jsonData];
    
    [self searchBusStopsFor:@""];
    
    
    
    return self;
}

-(void) dealloc{
    if (sgBusesBusStopSelectionActionDelegate){
        [sgBusesBusStopSelectionActionDelegate release];
        sgBusesBusStopSelectionActionDelegate = nil;
    }
    if (filteredBusStopArray){
        [filteredBusStopArray release];
        filteredBusStopArray = nil;
    }
    if (busStopDictionary){
        [busStopDictionary release];
        busStopDictionary = nil;
    }
    [super dealloc];
}

-(void) setBusStopDictionary: (NSDictionary*) _busStopDictionary{
    if (busStopDictionary){
        [busStopDictionary release];
        busStopDictionary = nil;
    }
    busStopDictionary = [_busStopDictionary retain];
}

-(void) setFilteredBusStopArray: (NSArray*) _filteredBusStopArray{
    if (filteredBusStopArray){
        [filteredBusStopArray release];
        filteredBusStopArray = nil;
    }
    filteredBusStopArray = [_filteredBusStopArray retain];
}

-(void) searchBusStopsFor: (NSString*) input{
    
    SgBusesCoreDataManager* sgBusesCoreDataManager = [[SgBusesCoreDataManager alloc]init];
    NSArray* filteredArray = [sgBusesCoreDataManager getFilteredBusStop:input];
    NSLog(@"filteredArray count: %d", [filteredArray count]);
    [sgBusesCoreDataManager release];
    [self setFilteredBusStopArray:filteredArray];
    [self.tableView reloadData];
    
    

    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [filteredBusStopArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 160;
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
    
    BusStopCoreData* busStop = (BusStopCoreData*) [filteredBusStopArray objectAtIndex:indexPath.row];
    SgBusesViewGenerator* sgBusesViewGenerator = [[SgBusesViewGenerator alloc]init];
    UIView* cellContentView = [sgBusesViewGenerator generateSgBusesBusStopSelectionCellViewFor:busStop rectSize:cell.contentView.frame];
    [sgBusesViewGenerator release];
    
    [cell.contentView addSubview:cellContentView];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BusStopCoreData* busStop = (BusStopCoreData*) [filteredBusStopArray objectAtIndex:indexPath.row];
    if (sgBusesBusStopSelectionActionDelegate!=nil){
        [sgBusesBusStopSelectionActionDelegate busStopSelected:busStop];
    }
}





-(void) loadView{
    [super loadView];
    [self.view setBackgroundColor:[UIColor colorWithRed:50.0/255.0 green:50.0/255.0 blue:50.0/255.0 alpha:1]];
    [self.tableView setSeparatorColor:[UIColor blackColor]];
}


@end
