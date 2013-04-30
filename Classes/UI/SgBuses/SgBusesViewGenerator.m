//
//  SgBusesViewGenerator.m
//  Freestyle
//
//  Created by Kenneth on 8/4/13.
//
//

#import "SgBusesViewGenerator.h"
#import "SGBusesMapAnnotation.h"
#import <QuartzCore/QuartzCore.h>

@implementation SgBusesViewGenerator
@synthesize sgBusesBustStopShortlistActionDelegate;

-(void) dealloc{
    if (sgBusesBustStopShortlistActionDelegate){
        [sgBusesBustStopShortlistActionDelegate release];
        sgBusesBustStopShortlistActionDelegate = nil;
    }
    [super dealloc];
}

-(UIColor*) generateLightBlueColor{
    return [UIColor colorWithRed:51.0/255.0 green:204.0/255.0 blue:255.0/255.0 alpha:1];
}

-(UIView*) generateSgBusesBusStopSelectionCellViewFor: (BusStopCoreData*) busStop rectSize: (CGRect) rectSize{
    return [self generateSgBusesBusStopSelectionCellViewFor:busStop rectSize:rectSize mapViewHeight:90 shouldShowShortListButton:NO];
}

-(UIView*) generateSgBusesBusStopPreviewViewFor: (BusStopCoreData*) busStop rectSize: (CGRect) rectSize{
    return [self generateSgBusesBusStopSelectionCellViewFor:busStop rectSize:rectSize mapViewHeight:160 shouldShowShortListButton:YES];
}


-(UIView*) generateSgBusesBusStopSelectionCellViewFor: (BusStopCoreData*) busStop rectSize: (CGRect) rectSize mapViewHeight: (int) mapViewheight shouldShowShortListButton: (BOOL) shouldShowShortListButton{
    UIView* cellView = [[[UIView alloc]initWithFrame:rectSize]autorelease];
    [cellView setBackgroundColor:[UIColor clearColor]];
    
    NSString* busStopNumberString = busStop.busStopNumber;
    NSString* busStopName = busStop.busStopName;
    NSNumber* busStoplatitude = busStop.latitude;
    NSNumber* busStoplongitude = busStop.longitude;
    
    
    
    SGBusesMapAnnotation* sgBusesMapAnnotation = [[SGBusesMapAnnotation alloc]initWithLatitude:[busStoplatitude floatValue] longitude:[busStoplongitude floatValue] busStopNumber:busStopNumberString busStopName:busStopName];
    
    UILabel* busStopLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 70, 20)];
    [busStopLabel setBackgroundColor:[UIColor clearColor]];
    [busStopLabel setTextAlignment:NSTextAlignmentLeft];
    [busStopLabel setTextColor:[UIColor whiteColor]];
    [busStopLabel setText:@"Bus Stop: "];
    [busStopLabel setFont:[UIFont boldSystemFontOfSize:12]];
    [cellView addSubview:busStopLabel];
    [busStopLabel release];
    
    UILabel* busStopNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 10, 70, 20)];
    [busStopNumberLabel setBackgroundColor:[UIColor clearColor]];
    [busStopNumberLabel setTextAlignment:NSTextAlignmentLeft];
    [busStopNumberLabel setTextColor:[self generateLightBlueColor]];
    [busStopNumberLabel setText:busStopNumberString];
    [busStopNumberLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [cellView addSubview:busStopNumberLabel];
    [busStopNumberLabel release];
    
    UILabel* busStopNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 30, 250, 20)];
    [busStopNameLabel setBackgroundColor:[UIColor clearColor]];
    [busStopNameLabel setTextAlignment:NSTextAlignmentLeft];
    [busStopNameLabel setTextColor:[UIColor whiteColor]];
    [busStopNameLabel setText:busStopName];
    [busStopNameLabel setFont:[UIFont boldSystemFontOfSize:12]];
    [cellView addSubview:busStopNameLabel];
    [busStopNameLabel release];
    
    MKMapView *map = [[MKMapView alloc] initWithFrame:CGRectMake(20, 55, 280, mapViewheight)];
    [map addAnnotation:sgBusesMapAnnotation];
    
    
    
    [cellView addSubview:map];
    
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta = 0.001;
    span.longitudeDelta = 0.001;
    region.span = span;
    region.center = sgBusesMapAnnotation.coordinate;

    [map setRegion:region animated:YES];
    
    [map release];
    [sgBusesMapAnnotation release];
    
    if (shouldShowShortListButton){
        UIButton* shortListButton = [[UIButton alloc]initWithFrame:CGRectMake(20, rectSize.size.height-90, map.frame.size.width, 30)];
        shortListButton.layer.cornerRadius = 5; // this value vary as per your desire
        shortListButton.clipsToBounds = YES;
        [shortListButton setBackgroundColor:[UIColor darkGrayColor]];
        [shortListButton setTintColor:[UIColor colorWithRed:0.764 green:1.000 blue:0.000 alpha:1.000]];
        [shortListButton setTitle:@"Shortlist" forState:UIControlStateNormal];
        [shortListButton.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
        [shortListButton addTarget:sgBusesBustStopShortlistActionDelegate  action:@selector(shortlistBusStop) forControlEvents:UIControlEventTouchUpInside];
        [cellView addSubview:shortListButton];
        [shortListButton release];
    }
    
    
    return cellView;
    
}

-(int) calculateShortListCellViewHeightFor:(ShortListedBusStopCoreData*) shortListedBusStop{
    int basedHeight = 55;
    int numberOfBusServices = [shortListedBusStop.busStop.busRoute count];
    return basedHeight+(numberOfBusServices*25);
    
}

@end
