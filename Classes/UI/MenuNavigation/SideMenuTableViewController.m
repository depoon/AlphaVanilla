//
//  SideMenuTableViewController.m
//  Freestyle
//
//  Created by Kenneth on 31/3/13.
//
//

#import "SideMenuTableViewController.h"
#import "AppConfigurationAction.h"



@implementation SideMenuTableViewController{
    @private NSArray* sideMenuItemArray;
}
@synthesize sideMenuController;

-(void) dealloc{
    if (sideMenuController){
        [sideMenuController release];
        sideMenuController = nil;
    }
    if (sideMenuItemArray){
        [sideMenuItemArray release];
        sideMenuItemArray = nil;
    }
    [super dealloc];
}

-(void) setSideMenuItemArray: (NSArray*) _sideMenuItemArray{
    if (sideMenuItemArray){
        [sideMenuItemArray release];
        sideMenuItemArray = nil;
    }
    sideMenuItemArray = [_sideMenuItemArray retain];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [sideMenuItemArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
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
    NSDictionary* sideMenuItemDictionary = [sideMenuItemArray objectAtIndex:indexPath.row];
    NSString* menuItemName = [sideMenuItemDictionary objectForKey:CONFIG_KEY_SIDEMENU_MENU_NAME];
    NSString* menuItemImagePage = [sideMenuItemDictionary objectForKey:CONFIG_KEY_SIDEMENU_MENU_IMAGE];
    NSString* menuItemSelectorString = [sideMenuItemDictionary objectForKey:CONFIG_KEY_SIDEMENU_MENU_SELECTOR];
    SEL menuItemSelector = NSSelectorFromString(menuItemSelectorString);

    UIImageView* imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:menuItemImagePage]];
    [cell addSubview:imageView];
    [imageView release];
    
    UIView* menuItemView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 50)];
    [menuItemView setBackgroundColor:[UIColor blackColor]];
    [menuItemView setAlpha:0.6];
    [imageView addSubview:menuItemView];
    [menuItemView release];
    

    
    UIButton* menuItemButton = [[UIButton alloc]initWithFrame:menuItemView.frame];
    [menuItemButton setBackgroundColor:[UIColor clearColor]];
    [menuItemButton setTitle:menuItemName forState:UIControlStateNormal];
    [menuItemButton.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
    [menuItemButton addTarget:sideMenuController action:menuItemSelector forControlEvents:UIControlEventTouchUpInside];
    [cell addSubview:menuItemButton];
    [menuItemButton release];
    

    
    
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(void)loadView{
    [super loadView];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setBackgroundColor:[UIColor blackColor]];
    self.tableView.bounces = NO;
    
    NSObject<AppConfigurationAction>* appDelegate = (NSObject<AppConfigurationAction>*) [[UIApplication sharedApplication] delegate];
    NSArray* _sideMenuItemArray = [[[appDelegate getConfiguration] getSideMenuConfigurationSetup] getSideMenuItemArray];
    [self setSideMenuItemArray:_sideMenuItemArray];

}

-(void) nutting{
    NSLog(@"nutting");
}
@end
