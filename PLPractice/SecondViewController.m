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


@property (nonatomic) BOOL didSetupClockViewConstraints;

@property (nonatomic) BOOL didSetupTickViews;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Clock";
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self createViewsAndLayers];
//    [self animateLayers];

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
                                                 startAngle:DEGREES_TO_RADIANS(300)
                                                   endAngle:DEGREES_TO_RADIANS(340)
                                                  clockwise:YES];
    
    CAShapeLayer *oneTwoLayer = [CAShapeLayer layer];
    [oneTwoLayer setPath: self.oneTwoPath.CGPath];
    [oneTwoLayer setStrokeColor:[UIColor grayColor].CGColor];
    [oneTwoLayer setFillColor:[UIColor clearColor].CGColor];
    oneTwoLayer.lineWidth = 15;
    oneTwoLayer.lineDashPattern = @[@5, @65];
    oneTwoLayer.strokeStart = 0.0;
    oneTwoLayer.strokeEnd = 1.0;
    
    [self.view.layer addSublayer:oneTwoLayer];
    
    //create four to five layer
    
    UIBezierPath *fourFivePath = [UIBezierPath bezierPathWithArcCenter:self.clockView.center
                                                     radius:123
                                                 startAngle:DEGREES_TO_RADIANS(25)
                                                   endAngle:DEGREES_TO_RADIANS(70)
                                                  clockwise:YES];
    
    CAShapeLayer *fourFiveLayer = [CAShapeLayer layer];
    [fourFiveLayer setPath: fourFivePath.CGPath];
    [fourFiveLayer setStrokeColor:[UIColor grayColor].CGColor];
    [fourFiveLayer setFillColor:[UIColor clearColor].CGColor];
    fourFiveLayer.lineWidth = 15;
    fourFiveLayer.lineDashPattern = @[@5, @65];
    fourFiveLayer.strokeStart = 0.0;
    fourFiveLayer.strokeEnd = 1.0;
    
    [self.view.layer addSublayer:fourFiveLayer];
    
    //create seven to eight layer
    
    UIBezierPath *sevenEightPath = [UIBezierPath bezierPathWithArcCenter:self.clockView.center
                                                                radius:123
                                                            startAngle:DEGREES_TO_RADIANS(120)
                                                              endAngle:DEGREES_TO_RADIANS(160)
                                                             clockwise:YES];
    
    CAShapeLayer *sevenEightLayer = [CAShapeLayer layer];
    [sevenEightLayer setPath: sevenEightPath.CGPath];
    [sevenEightLayer setStrokeColor:[UIColor grayColor].CGColor];
    [sevenEightLayer setFillColor:[UIColor clearColor].CGColor];
    sevenEightLayer.lineWidth = 15;
    sevenEightLayer.lineDashPattern = @[@5, @65];
    sevenEightLayer.strokeStart = 0.0;
    sevenEightLayer.strokeEnd = 1.0;
    
    [self.view.layer addSublayer:sevenEightLayer];
    
    //create ten to eleven layer
    
    UIBezierPath *tenElevenPath = [UIBezierPath bezierPathWithArcCenter:self.clockView.center
                                                                  radius:123
                                                              startAngle:DEGREES_TO_RADIANS(205)
                                                                endAngle:DEGREES_TO_RADIANS(250)
                                                               clockwise:YES];
    
    CAShapeLayer *tenElevenLayer = [CAShapeLayer layer];
    [tenElevenLayer setPath: tenElevenPath.CGPath];
    [tenElevenLayer setStrokeColor:[UIColor grayColor].CGColor];
    [tenElevenLayer setFillColor:[UIColor clearColor].CGColor];
    tenElevenLayer.lineWidth = 15;
    tenElevenLayer.lineDashPattern = @[@5, @65];
    tenElevenLayer.strokeStart = 0.0;
    tenElevenLayer.strokeEnd = 1.0;
    
    [self.view.layer addSublayer:tenElevenLayer];
    
    //create clock hands
    
//    UIBezierPath *secondRectPath = [UIBezierPath bezierPathWithRect:CGRectMake(9, 7, 135, 2)];
//    
//    self.secondHandLayer = [CAShapeLayer layer];
//    [self.secondHandLayer setPath:secondRectPath.CGPath];
//    [self.secondHandLayer setStrokeColor:[UIColor redColor].CGColor];
//    [self.secondHandLayer setFillColor:[UIColor redColor].CGColor];
    
    //    [self.middleView.layer addSublayer:self.secondHandLayer];
    
    UIBezierPath *secondHandPath = [UIBezierPath bezierPathWithArcCenter:self.clockView.center
                                                                 radius:57.5
                                                             startAngle:DEGREES_TO_RADIANS(0)
                                                               endAngle:DEGREES_TO_RADIANS(359)
                                                              clockwise:YES];
    
    self.secondHandLayer = [CAShapeLayer layer];
    [self.secondHandLayer setPath:secondHandPath.CGPath];
    [self.secondHandLayer setStrokeColor:[UIColor redColor].CGColor];
    [self.secondHandLayer setFillColor:[UIColor clearColor].CGColor];
    self.secondHandLayer.lineWidth = 135;
    self.secondHandLayer.lineDashPattern = @[@0, @360];
    self.secondHandLayer.strokeStart = 0.0;
    self.secondHandLayer.strokeEnd = 1.0;
    
    [self.view.layer addSublayer:self.secondHandLayer];
    

    
    UIBezierPath *minuteRectPath = [UIBezierPath bezierPathWithRect:CGRectMake(7, 7, 3, 135)];
    
    self.minuteHandLayer = [CAShapeLayer layer];
    [self.minuteHandLayer setPath:minuteRectPath.CGPath];
    [self.minuteHandLayer setStrokeColor:[UIColor blackColor].CGColor];
    [self.minuteHandLayer setFillColor:[UIColor blackColor].CGColor];
    
//    [self.middleView.layer addSublayer:self.minuteHandLayer];
    
    UIBezierPath *hourRectPath = [UIBezierPath bezierPathWithRect:CGRectMake(6, 7, 5, -135)];
    
    self.hourHandLayer = [CAShapeLayer layer];
    [self.hourHandLayer setPath:hourRectPath.CGPath];
    [self.hourHandLayer setStrokeColor:[UIColor blackColor].CGColor];
    [self.hourHandLayer setFillColor:[UIColor blackColor].CGColor];
    
//    [self.middleView.layer addSublayer:self.hourHandLayer];
    
}

-(void) setupTimer {
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(animateLayers) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

//-(void) animateLayers {
//    
//    CGRect boundingRect = CGRectMake(-150, -150, 50, 50);
//    
//    CAKeyframeAnimation *secondAnimation = [CAKeyframeAnimation animation];
//    secondAnimation.keyPath = @"position";
//    secondAnimation.path = CFAutorelease(CGPathCreateWithEllipseInRect(boundingRect, NULL));
//    secondAnimation.duration = 3;
//    secondAnimation.additive = YES;
//    secondAnimation.repeatCount = HUGE_VALF;
//    secondAnimation.calculationMode = kCAAnimationPaced;
////    secondAnimation.rotationMode = kCAAnimationRotateAuto;
//    
//    [self.secondHandLayer addAnimation:secondAnimation forKey:@"secondAnimation"];
//    
//}

//-(void) setupClockViewConstraints {
//    
//    if (!self.didSetupClockViewConstraints) {
//        [NSLayoutConstraint autoCreateAndInstallConstraints:^{
//            [self.clockView autoCenterInSuperview];
//            [self.clockView autoSetDimensionsToSize:CGSizeMake(150, 150)];
//        }];
//        
//        self.didSetupClockViewConstraints = YES;
//    }
//}

//-(void) createTickViews {
//    
//    for (int i = 1; i < 5; i++) {
//        
//        UIView *tickView = [[UIView alloc] init];
//        tickView.backgroundColor = [UIColor redColor];
//        [self.whiteView addSubview:tickView];
//        [tickView autoSetDimensionsToSize:CGSizeMake(i, 12.0)];
//        [tickView autoCenterInSuperview];
//        tickView.transform = CGAffineTransformMakeTranslation(0.0, 130);
//        [self rotateView:self.clockView];
//        
//    }
//}

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
