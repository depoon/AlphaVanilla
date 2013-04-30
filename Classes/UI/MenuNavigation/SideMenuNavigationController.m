//
//  SideMenuNavigationController.m
//  Freestyle
//
//  Created by Kenneth on 18/3/13.
//
//

#import "SideMenuNavigationController.h"
#import "PGKeyboardInputAccessoryViewGenerator.h"
#import "ApplicationDelegateAction.h"
#import "SideMenuTableViewController.h"
#import "SideMenuController.h"

int const SideMenuNavigationController_MainPageButtonTag = 100;

@implementation SideMenuNavigationController{
    @private UISearchBar* topSearchBar;
    @private UIPanGestureRecognizer* sideScrollRecognizer;
    @private CGRect originalFrame;
    @private float currentSelfViewXPoint;
    @private SideMenuTableViewController* sideMenuTableViewController;
    @private SideMenuController* sideMenuController;

}

int const SideMenuNavigationController_SideMenuWidth = 270;

-(id) initWithRootViewController:(UIViewController *)rootViewController{

    self.delegate = self;
    self = [super initWithRootViewController:rootViewController];
    sideMenuController = [[SideMenuController alloc]init];
    sideMenuController.sideMenuNavigationController = self;
    sideScrollRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(slideGestureObserved:)];
    [sideScrollRecognizer setMaximumNumberOfTouches:1];
    [sideScrollRecognizer setMinimumNumberOfTouches:1];
    [sideScrollRecognizer setDelegate:self];
    
    currentSelfViewXPoint = 0;
    
    sideMenuTableViewController = [[SideMenuTableViewController alloc]init];
    sideMenuTableViewController.sideMenuController = sideMenuController;


    
    return self;
}

-(void) dealloc{
    if (sideMenuController){
        [sideMenuController release];
        sideMenuController = nil;
    }
    if (sideMenuTableViewController){
        [sideMenuTableViewController release];
        sideMenuTableViewController = nil;
    }
    if (sideScrollRecognizer){
        [sideScrollRecognizer release];
        sideScrollRecognizer = nil;
    }
    if (topSearchBar){
        [topSearchBar release];
        topSearchBar = nil;
    }
    [super dealloc];
}

-(void) viewDidLoad{
    [super viewDidLoad];

}


-(UIImage *)generateMenuImage {
    static UIImage *defaultImage = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(20.f, 13.f), NO, 0.0f);
        
        [[UIColor blackColor] setFill];
        [[UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 20, 1)] fill];
        [[UIBezierPath bezierPathWithRect:CGRectMake(0, 5, 20, 1)] fill];
        [[UIBezierPath bezierPathWithRect:CGRectMake(0, 10, 20, 1)] fill];
        
        [[UIColor whiteColor] setFill];
        [[UIBezierPath bezierPathWithRect:CGRectMake(0, 1, 20, 2)] fill];
        [[UIBezierPath bezierPathWithRect:CGRectMake(0, 6, 20, 2)] fill];
        [[UIBezierPath bezierPathWithRect:CGRectMake(0, 11, 20, 2)] fill];
        
        defaultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
    });
    return defaultImage;
}

-(void) addTopViewTriggerButton{
    CGRect viewFrame = self.view.frame;
    float originalAlpla = 0;
    UIButton* mainPageButton = (UIButton*)[self.topViewController.view viewWithTag:SideMenuNavigationController_MainPageButtonTag];
    originalAlpla = mainPageButton.alpha;

    
    [[self.topViewController.view viewWithTag:SideMenuNavigationController_MainPageButtonTag] removeFromSuperview];
    mainPageButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, viewFrame.size.width, viewFrame.size.height)];
    [mainPageButton setBackgroundColor:[UIColor blackColor]];
    [mainPageButton setAlpha:originalAlpla];
    [mainPageButton setTag:SideMenuNavigationController_MainPageButtonTag];
    [mainPageButton addTarget:self action:@selector(menuButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.topViewController.view addSubview:mainPageButton];
    [mainPageButton release];
}

- (void)animateSlideMenu:(CGRect)destination viewToAnimate: (UIView*) viewToAnimate{
    float alpha = 0.7;
    if (destination.origin.x == 0){
        alpha = 0;
    }

    [self addTopViewTriggerButton];
    UIButton* mainPageButton = (UIButton*)[self.topViewController.view viewWithTag:SideMenuNavigationController_MainPageButtonTag];


    
    [UIView animateWithDuration:0.25 animations:^{
        
        viewToAnimate.frame = destination;
        mainPageButton.alpha = alpha;
        
    } completion:^(BOOL finished) {
        if (destination.origin.x == 0) {
            [[self.topViewController.view viewWithTag:SideMenuNavigationController_MainPageButtonTag] removeFromSuperview];
        }
        
        
        
    }];
}

- (void)menuButtonPressed:(id)sender {

    CGRect destination = self.view.frame;
    

    if (destination.origin.x!=0) {
        destination.origin.x = 0;
    } else {
        destination.origin.x = SideMenuNavigationController_SideMenuWidth;
    }

    [self animateSlideMenu:destination viewToAnimate:self.view];
}

-(void) closeMenu{
    CGRect destination = self.view.frame;
    destination.origin.x = 0;
    [self animateSlideMenu:destination viewToAnimate:self.view];

}



-(UIView*) generateSideMenuView{
    UIView* sideMenuView = [[[UIView alloc]initWithFrame:CGRectMake(0, 19, SideMenuNavigationController_SideMenuWidth, self.view.frame.size.height)]autorelease];
    [sideMenuView setBackgroundColor:[UIColor darkGrayColor]];

    UIToolbar* topToolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, SideMenuNavigationController_SideMenuWidth, 44)];
    [topToolBar setTintColor:[UIColor darkGrayColor]];
    [sideMenuView addSubview:topToolBar];
    [topToolBar release];
    
    UISearchBar* _topSearchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, SideMenuNavigationController_SideMenuWidth, 44)];
    [_topSearchBar setTintColor:[UIColor darkGrayColor]];
    [_topSearchBar setPlaceholder:@"Search for Engineer"];
    [_topSearchBar setInputAccessoryView: [self generateInputAccessoryView]];
    [self setTopSearchBar:_topSearchBar];
    [_topSearchBar release];

    [topToolBar addSubview:_topSearchBar];
    
    [sideMenuTableViewController loadView];
    UITableView* tableView = sideMenuTableViewController.tableView;
    [tableView setFrame:CGRectMake(0, topToolBar.frame.origin.y+topToolBar.frame.size.height, SideMenuNavigationController_SideMenuWidth, sideMenuView.frame.size.height-topToolBar.frame.size.height)];
    [sideMenuView addSubview:tableView];
    
    return sideMenuView;
    
}

-(void) keyboardInputAccessoryDoneButtonPressed{
    [topSearchBar resignFirstResponder];
}


- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [viewController.view addGestureRecognizer:sideScrollRecognizer];

}





-(void)slideGestureObserved:(UIPanGestureRecognizer *)gesture{
    if (gesture.state == UIGestureRecognizerStateBegan){
        [self addTopViewTriggerButton];
        currentSelfViewXPoint = self.view.frame.origin.x;
    }
    if (gesture.state == UIGestureRecognizerStateChanged){
        CGPoint gesturePoint = [gesture translationInView:self.view];
        CGRect originalTopViewFrame = self.view.frame;
        
        

        float newFrameXPoint = currentSelfViewXPoint+gesturePoint.x;
        if (newFrameXPoint<0){
            newFrameXPoint = 0;
        }
        if (newFrameXPoint>SideMenuNavigationController_SideMenuWidth){
            newFrameXPoint = SideMenuNavigationController_SideMenuWidth;
        }
        
        float reverseAlpha = newFrameXPoint/([[UIScreen mainScreen] bounds].size.width)*0.7;
        UIButton* mainPageButton = (UIButton*)[self.topViewController.view viewWithTag:SideMenuNavigationController_MainPageButtonTag];

        [mainPageButton setAlpha:(reverseAlpha)];
        [self.view setFrame:CGRectMake(newFrameXPoint, originalTopViewFrame.origin.y, originalTopViewFrame.size.width, originalTopViewFrame.size.height)];

        
    }
    if (gesture.state == UIGestureRecognizerStateEnded){

        CGRect originalTopViewFrame = self.view.frame;
        float frameXPoint = originalTopViewFrame.origin.x;
        float midPoint = ([[UIScreen mainScreen] bounds].size.width)/2;
        

        
        CGRect destination = self.view.frame;
        
        destination.origin.x = 0;
        if (frameXPoint>midPoint){
            destination.origin.x = SideMenuNavigationController_SideMenuWidth;
        }        
        [self animateSlideMenu:destination  viewToAnimate:self.view];

    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer{
    CGPoint translation = [gestureRecognizer translationInView:self.topViewController.view];
    

    
    
    // Check for horizontal gesture
    if (fabsf(translation.x) > fabsf(translation.y)){
        originalFrame = self.topViewController.view.frame;
        return YES;
    }
    
    return NO;
}

-(void) setTopSearchBar: (UISearchBar*) _topSearchBar{
    if (topSearchBar){
        [topSearchBar release];
        topSearchBar = nil;
    }
    topSearchBar = [_topSearchBar retain];
}

-(UIView*) generateInputAccessoryView{
    PGKeyboardInputAccessoryViewGenerator* pgKeyboardInputAccessoryViewGenerator =[[PGKeyboardInputAccessoryViewGenerator alloc]init];
    UIView* inputAccessoryView = [pgKeyboardInputAccessoryViewGenerator generateInputAccessoryView:self];
    [pgKeyboardInputAccessoryViewGenerator release];
    return inputAccessoryView;
}



@end
