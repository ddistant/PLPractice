//
//  SecondViewController.m
//  PLPractice
//
//  Created by Daniel Distant on 4/15/16.
//  Copyright © 2016 ddistant. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@property (nonatomic) ALView *clockView;
@property (nonatomic) UIView *whiteView;
@property (nonatomic) BOOL didSetupClockViewConstraints;

@property (nonatomic) BOOL didSetupTickViews;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self createViews];

//    [self setupClockViewConstraints];
}

-(void) createViews {
    
    //clock view - most outside layer
    
    self.clockView = [ALView newAutoLayoutView];
    self.clockView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.clockView];
    self.clockView.layer.cornerRadius = 150;
    [self.clockView autoCenterInSuperview];
    [self.clockView autoSetDimensionsToSize:CGSizeMake(300, 300)];
    
    //next layer in - white
    
    self.whiteView = [ALView newAutoLayoutView];
    self.whiteView.backgroundColor = [UIColor whiteColor];
    [self.clockView addSubview:self.whiteView];
    [self.whiteView autoSetDimensionsToSize:CGSizeMake(290, 290)];
    [self.whiteView autoCenterInSuperview];
    self.whiteView.layer.cornerRadius = 145;
    
    //create tick views
    
    [self createTickViews];
    
}

-(void) setupClockViewConstraints {
    
    if (!self.didSetupClockViewConstraints) {
        [NSLayoutConstraint autoCreateAndInstallConstraints:^{
            [self.clockView autoCenterInSuperview];
            [self.clockView autoSetDimensionsToSize:CGSizeMake(150, 150)];
        }];
        
        self.didSetupClockViewConstraints = YES;
    }
}

-(void) createTickViews {
    
    for (int i = 1; i < 5; i++) {
        
        UIView *tickView = [[UIView alloc] init];
        tickView.backgroundColor = [UIColor redColor];
        [self.whiteView addSubview:tickView];
        [tickView autoSetDimensionsToSize:CGSizeMake(i, 12.0)];
        [tickView autoCenterInSuperview];
        tickView.transform = CGAffineTransformMakeTranslation(0.0, 130);
        [self rotateView:self.clockView];
        
    }
}

-(void) rotateView:(UIView *)view {
    
    CGFloat angle = M_PI;
    CGAffineTransform rotateTransform = CGAffineTransformRotate(view.transform, angle);
    view.transform = rotateTransform;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
