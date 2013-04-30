//
//  SgBusesCoreDataSetupViewController.m
//  Freestyle
//
//  Created by Kenneth on 9/4/13.
//
//

#import "SgBusesCoreDataSetupViewController.h"
#import "SgBusesCoreDataSetup.h"
#import <QuartzCore/QuartzCore.h>
#import "ApplicationDelegateAction.h"

@implementation SgBusesCoreDataSetupViewController{
    @private UIProgressView* progressView;
    @private UILabel* progressLabel;
    @private SgBusesCoreDataSetup* sgBusesCoreDataSetup;
    @private UIButton* startAppButton;
}

-(id) init{
    self = [super init];
    progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(20, 200, 280, 30)];
    progressLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 160, 280, 20)];

    [progressLabel setBackgroundColor:[UIColor clearColor]];
    [progressLabel setFont:[UIFont systemFontOfSize:16]];
    [progressLabel setTextColor:[UIColor whiteColor]];
    sgBusesCoreDataSetup = [[SgBusesCoreDataSetup alloc]init];
    sgBusesCoreDataSetup.sgBusesCoreDataUpdateUIActionDelegate = self;
    [self updateProgress:0];
    
    startAppButton = [[UIButton alloc]initWithFrame:CGRectZero];
    startAppButton.layer.cornerRadius = 5; // this value vary as per your desire
    startAppButton.clipsToBounds = YES;
    [startAppButton setBackgroundColor:[UIColor darkGrayColor]];
    [startAppButton setTintColor:[UIColor colorWithRed:0.764 green:1.000 blue:0.000 alpha:1.000]];
    [startAppButton setTitle:@"Start Using SG Buses" forState:UIControlStateNormal];
    [startAppButton.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
    [startAppButton addTarget:self  action:@selector(startApplication) forControlEvents:UIControlEventTouchUpInside];



    return self;
}

-(void) dealloc{
    if (startAppButton){
        [startAppButton release];
        startAppButton = nil;
    }
    if (sgBusesCoreDataSetup){
        [sgBusesCoreDataSetup release];
        sgBusesCoreDataSetup = nil;
    }
    if (progressView){
        [progressView release];
        progressView = nil;
    }
    if (progressLabel){
        [progressLabel release];
        progressLabel = nil;
    }
    [super dealloc];
}

-(void) viewDidLoad{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithRed:50.0/255.0 green:50.0/255.0 blue:50.0/255.0 alpha:1]];
    [self.view addSubview:progressView];
    [self.view addSubview:progressLabel];
    
    [startAppButton setFrame:CGRectMake(20, 350, 280, 30)];
    [self.view addSubview:startAppButton];
    [startAppButton setHidden:YES];
    
    
    
}

-(void) updateLabel: (float) progressValue{
    NSString* labelText = [NSString stringWithFormat:@"Data Initialization Progress: %.0f%%", progressValue];
    [progressLabel setText:labelText];

}

-(void) updateProgress: (NSNumber*) progressValue{
    float value = [progressValue floatValue];
    
    [self updateLabel:value];
    [progressView setProgress:(value/100)];
    
    if (value == 100){
        [startAppButton setHidden:NO];
    }
    
}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [NSThread sleepForTimeInterval:1];
    [sgBusesCoreDataSetup setupCoreData];
}

-(void) startApplication{
    NSObject<ApplicationDelegateAction>* appDelegate = (NSObject<ApplicationDelegateAction>*) [[UIApplication sharedApplication] delegate];
    [appDelegate beginApp];
    
}
@end
