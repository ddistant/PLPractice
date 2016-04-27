//
//  SecondViewController.m
//  PLPractice
//
//  Created by Daniel Distant on 4/15/16.
//  Copyright © 2016 ddistant. All rights reserved.
//

#import "SecondViewController.h"

#define DEGREES_TO_RADIANS(degrees)  ((M_PI * degrees)/ 180)
#define kLineDashPattern @[@5, @65.6]

/*
 
 12 = 270 dgrs
 1 = 300
 2 = 330
 3 = 0
 4 = 30
 5 = 60
 6 = 90
 7 = 120
 8 = 150
 9 = 180
 10 = 210
 11 = 240
 
 */

@interface SecondViewController ()

@property (nonatomic) UIView *clockView;
@property (nonatomic) UIView *whiteView;
@property (nonatomic) UIView *middleView;
@property (nonatomic) UIBezierPath *oneTwoPath;

@property (nonatomic) CAShapeLayer *secondHandLayer;
@property (nonatomic) CAShapeLayer *minuteHandLayer;
@property (nonatomic) CAShapeLayer *hourHandLayer;

@property (nonatomic) UILabel *twelveLabel;
@property (nonatomic) UILabel *threeLabel;
@property (nonatomic) UILabel *sixLabel;
@property (nonatomic) UILabel *nineLabel;

@property (nonatomic) NSTimer *timer;

@property (nonatomic) int degrees;


@property (nonatomic) BOOL didSetupClockViewConstraints;

@property (nonatomic) BOOL didSetupTickViews;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Clock";
    self.degrees = 0;
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self createViewsAndLayers];
    [self setupTimer];

}

-(void) createViewsAndLayers {
    
    //clock view
    
    self.clockView = [[UIView alloc] initWithFrame:CGRectMake(75/2, 367/2, 300, 300)];
    self.clockView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.clockView];
    self.clockView.layer.cornerRadius = 150;
    
    //next layer in - white
    
    self.whiteView = [UIView newAutoLayoutView];
    self.whiteView.backgroundColor = [UIColor whiteColor];
    [self.clockView addSubview:self.whiteView];
    [self.whiteView autoSetDimensionsToSize:CGSizeMake(290, 290)];
    [self.whiteView autoCenterInSuperview];
    self.whiteView.layer.cornerRadius = 145;
    
    //create middle view
    
    self.middleView = [UIView newAutoLayoutView];
    self.middleView.backgroundColor = [UIColor blackColor];
    [self.whiteView addSubview:self.middleView];
    self.middleView.layer.cornerRadius = 7.5;
    [self.middleView autoCenterInSuperview];
    [self.middleView autoSetDimensionsToSize:CGSizeMake(15, 15)];
    
    //12 label
    
    self.twelveLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    self.twelveLabel.backgroundColor = [UIColor clearColor];
    self.twelveLabel.text = @"12";
    self.twelveLabel.font = [UIFont fontWithName:@"Arial" size:26];
    self.twelveLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.whiteView addSubview:self.twelveLabel];
    
    [self.twelveLabel autoAlignAxis:ALAxisVertical toSameAxisOfView:self.whiteView];
    [self.twelveLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.whiteView withOffset:10];
    
    //six label
    
    self.sixLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    self.sixLabel.backgroundColor = [UIColor clearColor];
    self.sixLabel.text = @"6";
    self.sixLabel.font = [UIFont fontWithName:@"Arial" size:26];
    self.sixLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.whiteView addSubview:self.sixLabel];
    
    [self.sixLabel autoAlignAxis:ALAxisVertical toSameAxisOfView:self.whiteView];
    [self.sixLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.whiteView withOffset:-10];
    
    //nine label
    
    self.nineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    self.nineLabel.backgroundColor = [UIColor clearColor];
    self.nineLabel.text = @"9";
    self.nineLabel.font = [UIFont fontWithName:@"Arial" size:26];
    self.nineLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.whiteView addSubview:self.nineLabel];
    
    [self.nineLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.whiteView];
    [self.nineLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.whiteView withOffset:10];
    
    //three label
    
    self.threeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    self.threeLabel.backgroundColor = [UIColor clearColor];
    self.threeLabel.text = @"3";
    self.threeLabel.font = [UIFont fontWithName:@"Arial" size:26];
    self.threeLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.whiteView addSubview:self.threeLabel];
    
    [self.threeLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.whiteView];
    [self.threeLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.whiteView withOffset:-10];
    
    
    //create one to two layer
    
    self.oneTwoPath = [UIBezierPath bezierPathWithArcCenter:self.clockView.center
                                                     radius:123
                                                 startAngle:DEGREES_TO_RADIANS(299)
                                                   endAngle:DEGREES_TO_RADIANS(335)
                                                  clockwise:YES];
    
    CAShapeLayer *oneTwoLayer = [CAShapeLayer layer];
    [oneTwoLayer setPath: self.oneTwoPath.CGPath];
    [oneTwoLayer setStrokeColor:[UIColor grayColor].CGColor];
    [oneTwoLayer setFillColor:[UIColor clearColor].CGColor];
    oneTwoLayer.lineWidth = 15;
    oneTwoLayer.lineDashPattern = @[@6, @58.5];
    oneTwoLayer.strokeStart = 0.0;
    oneTwoLayer.strokeEnd = 1.0;
    
    [self.view.layer addSublayer:oneTwoLayer];
    
    //create four to five layer
    
    UIBezierPath *fourFivePath = [UIBezierPath bezierPathWithArcCenter:self.clockView.center
                                                     radius:123
                                                 startAngle:DEGREES_TO_RADIANS(29)
                                                   endAngle:DEGREES_TO_RADIANS(75)
                                                  clockwise:YES];
    
    CAShapeLayer *fourFiveLayer = [CAShapeLayer layer];
    [fourFiveLayer setPath: fourFivePath.CGPath];
    [fourFiveLayer setStrokeColor:[UIColor grayColor].CGColor];
    [fourFiveLayer setFillColor:[UIColor clearColor].CGColor];
    fourFiveLayer.lineWidth = 15;
    fourFiveLayer.lineDashPattern = @[@6, @58.5];
    fourFiveLayer.strokeStart = 0.0;
    fourFiveLayer.strokeEnd = 1.0;
    
    [self.view.layer addSublayer:fourFiveLayer];
    
    //create seven to eight layer
    
    UIBezierPath *sevenEightPath = [UIBezierPath bezierPathWithArcCenter:self.clockView.center
                                                                radius:123
                                                            startAngle:DEGREES_TO_RADIANS(119)
                                                              endAngle:DEGREES_TO_RADIANS(155)
                                                             clockwise:YES];
    
    CAShapeLayer *sevenEightLayer = [CAShapeLayer layer];
    [sevenEightLayer setPath: sevenEightPath.CGPath];
    [sevenEightLayer setStrokeColor:[UIColor grayColor].CGColor];
    [sevenEightLayer setFillColor:[UIColor clearColor].CGColor];
    sevenEightLayer.lineWidth = 15;
    sevenEightLayer.lineDashPattern = @[@6, @58.5];
    sevenEightLayer.strokeStart = 0.0;
    sevenEightLayer.strokeEnd = 1.0;
    
    [self.view.layer addSublayer:sevenEightLayer];
    
    //create ten to eleven layer
    
    UIBezierPath *tenElevenPath = [UIBezierPath bezierPathWithArcCenter:self.clockView.center
                                                                  radius:123
                                                              startAngle:DEGREES_TO_RADIANS(209)
                                                                endAngle:DEGREES_TO_RADIANS(255)
                                                               clockwise:YES];
    
    CAShapeLayer *tenElevenLayer = [CAShapeLayer layer];
    [tenElevenLayer setPath: tenElevenPath.CGPath];
    [tenElevenLayer setStrokeColor:[UIColor grayColor].CGColor];
    [tenElevenLayer setFillColor:[UIColor clearColor].CGColor];
    tenElevenLayer.lineWidth = 15;
    tenElevenLayer.lineDashPattern = @[@6, @58.5];
    tenElevenLayer.strokeStart = 0.0;
    tenElevenLayer.strokeEnd = 1.0;
    
    [self.view.layer addSublayer:tenElevenLayer];
    
    //second hand
    
    self.secondHandLayer = [CAShapeLayer layer];
    [self.secondHandLayer setPath:[UIBezierPath bezierPathWithRect:CGRectMake(0, -120, 1, 120)].CGPath];
    [self.secondHandLayer setStrokeColor:[UIColor redColor].CGColor];
    [self.secondHandLayer setFillColor:[UIColor redColor].CGColor];
    self.secondHandLayer.position = CGPointMake(self.clockView.bounds.size.width / 2, self.clockView.bounds.size.height / 2);
    
    int sublayersCount = (int)self.clockView.layer.sublayers.count;
    
    [self.clockView.layer insertSublayer:self.secondHandLayer atIndex:sublayersCount];
    
    
    //create clock hands
    
//    UIBezierPath *secondRectPath = [UIBezierPath bezierPathWithRect:CGRectMake(9, 7, 135, 2)];
//    
//    self.secondHandLayer = [CAShapeLayer layer];
//    [self.secondHandLayer setPath:secondRectPath.CGPath];
//    [self.secondHandLayer setStrokeColor:[UIColor redColor].CGColor];
//    [self.secondHandLayer setFillColor:[UIColor redColor].CGColor];
    
    //    [self.middleView.layer addSublayer:self.secondHandLayer];
}

- (void)animateSecondHand {
    
    if (self.degrees > 360) {
        self.degrees = 0;
    }
    
    self.secondHandLayer.affineTransform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(self.degrees));
    
    self.degrees += 6;
}

//- (void)animateArc {
//
//    // Create the arc
//    CGPoint arcStart = CGPointMake(self.nineLabel.frame.origin.x, self.nineLabel.frame.origin.y);
//    CGPoint arcCenter = self.clockView.center;
//    CGFloat arcRadius = 123;
//    
//    CGMutablePathRef arcPath = CGPathCreateMutable();
//    CGPathMoveToPoint(arcPath, NULL, arcStart.x, arcStart.y);
//    CGPathAddArc(arcPath, NULL, arcCenter.x, arcCenter.y, arcRadius, M_PI, 0, NO);
//    
//    // The layer we're going to animate (a 50x50pt red box)
//    UIView* dynamicView = [[UIView alloc] initWithFrame: CGRectMake(self.nineLabel.frame.origin.x, self.nineLabel.frame.origin.y, 100, 2)];
//    dynamicView.layer.backgroundColor = [[UIColor redColor] CGColor];
//    [self.clockView addSubview: dynamicView];
//    dynamicView.center = arcStart;
//    
//    // The animation
//    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
//    pathAnimation.calculationMode = kCAAnimationPaced;
//    pathAnimation.duration = 5.0;
//    pathAnimation.path = arcPath;
//    CGPathRelease(arcPath);
//    
//    // Add the animation and reset the state so we can run again.
//    [CATransaction begin];
//    [CATransaction setCompletionBlock:^{
//        //call method again
//    }];
//    [dynamicView.layer addAnimation:pathAnimation forKey:@"arc"];
//    [CATransaction commit];
//}

//-(void) createSecondHand {
//    

//}


    
//    UIBezierPath *minuteRectPath = [UIBezierPath bezierPathWithRect:CGRectMake(7, 7, 3, 135)];
//    
//    self.minuteHandLayer = [CAShapeLayer layer];
//    [self.minuteHandLayer setPath:minuteRectPath.CGPath];
//    [self.minuteHandLayer setStrokeColor:[UIColor blackColor].CGColor];
//    [self.minuteHandLayer setFillColor:[UIColor blackColor].CGColor];
//    
////    [self.middleView.layer addSublayer:self.minuteHandLayer];
//    
//    UIBezierPath *hourRectPath = [UIBezierPath bezierPathWithRect:CGRectMake(6, 7, 5, -135)];
//    
//    self.hourHandLayer = [CAShapeLayer layer];
//    [self.hourHandLayer setPath:hourRectPath.CGPath];
//    [self.hourHandLayer setStrokeColor:[UIColor blackColor].CGColor];
//    [self.hourHandLayer setFillColor:[UIColor blackColor].CGColor];
    
//    [self.middleView.layer addSublayer:self.hourHandLayer];
//}

- (void) setupTimer {
    
    self.timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(animateSecondHand) userInfo: nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
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
