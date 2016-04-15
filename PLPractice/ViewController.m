//
//  ViewController.m
//  PLPractice
//
//  Created by Daniel Distant on 4/13/16.
//  Copyright © 2016 ddistant. All rights reserved.
//

#import "ViewController.h"
#import "PureLayout.h"

@interface ViewController ()

@property (nonatomic) BOOL didSetupPurpleConstraints;
@property (nonatomic) BOOL didSetupRedConstraints;
@property (nonatomic) BOOL didSetupBlueConstraints;
@property (nonatomic) BOOL didSetupGreenConstraints;
@property (nonatomic) BOOL didSetupYellowConstraints;

@property (nonatomic) ALView *purpleView;
@property (nonatomic) ALView *redView;
@property (nonatomic) ALView *blueView;
@property (nonatomic) ALView *greenView;
@property (nonatomic) ALView *yellowView;

@property (nonatomic) NSArray *colors;
@property (nonatomic) NSUInteger colorCount;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Shapes & Colors";
    
}


-(void)viewDidAppear:(BOOL)animated {
    
    self.view.layer.backgroundColor = [UIColor whiteColor].CGColor;
    
    [self createViews];
    [self addViews];
    [self updateAllConstraints];
    [self setupColorArray];
    [self addTapGestureRecognizer];
    [self addSwipeGestureRecognizer];
}

- (void) createViews {
    
    self.purpleView = [ALView newAutoLayoutView];
    self.purpleView.layer.backgroundColor = [UIColor purpleColor].CGColor;
    
    self.redView = [ALView newAutoLayoutView];
    self.redView.layer.backgroundColor = [UIColor redColor].CGColor;
    
    self.blueView = [ALView newAutoLayoutView];
    self.blueView.layer.backgroundColor = [UIColor blueColor].CGColor;
    
    self.greenView = [ALView newAutoLayoutView];
    self.greenView.layer.backgroundColor = [UIColor greenColor].CGColor;
    
    self.yellowView = [ALView newAutoLayoutView];
    self.yellowView.layer.backgroundColor = [UIColor yellowColor].CGColor;
    
}

-(void) addViews {
    
    [self.view addSubview:self.purpleView];
    [self.view addSubview:self.redView];
    [self.view addSubview:self.blueView];
    [self.view addSubview:self.greenView];
    [self.view addSubview:self.yellowView];
}

-(void) setupColorArray {
    self.colors = @[[UIColor blackColor], [UIColor grayColor], [UIColor orangeColor], [UIColor lightTextColor], [UIColor brownColor], [UIColor purpleColor]];
    self.colorCount = 0;
}

#pragma mark - pure layout

-(void) updateAllConstraints {
    
    [self updatePurpleConstraints];
    [self updateRedConstraints];
    [self updateBlueConstraints];
    [self updateGreenConstraints];
    [self updateYellowConstraints];
}

-(void) updatePurpleConstraints {
    
    if (!self.didSetupPurpleConstraints) {
        [NSLayoutConstraint autoCreateAndInstallConstraints:^{
            [self.purpleView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(15.0, 15.0, 15.0, 15.0)];
        }];
    }
    
    self.didSetupPurpleConstraints = YES;
}

-(void) updateRedConstraints {
    
    if (!self.didSetupRedConstraints) {
        
        [NSLayoutConstraint autoCreateAndInstallConstraints:^{
            [self.redView autoCenterInSuperview];
            [self.redView autoSetDimensionsToSize:CGSizeMake(100.0, 100.0)];
        }];
        
        self.didSetupRedConstraints = YES;
    }
}

-(void) updateBlueConstraints {
    
    if (!self.didSetupBlueConstraints) {
        
        [NSLayoutConstraint autoCreateAndInstallConstraints:^{
            [self.blueView autoSetDimensionsToSize:CGSizeMake(200.0, 30.0)];
            [self.blueView autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.redView];
            [self.blueView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:5.0];
        }];
        
        self.didSetupBlueConstraints = YES;
    }
}

-(void) updateGreenConstraints {
    
    if (!self.didSetupGreenConstraints) {
        
        [NSLayoutConstraint autoCreateAndInstallConstraints:^{
            [self.greenView autoSetDimensionsToSize:CGSizeMake(50.0, 250.0)];
            [self.greenView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.purpleView withOffset:10.0];
            [self.greenView autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.redView];
        }];
        
        self.didSetupGreenConstraints = YES;
    }
}

-(void) updateYellowConstraints {
    
    if (!self.didSetupYellowConstraints) {
        
        [NSLayoutConstraint autoCreateAndInstallConstraints:^{
            [self.yellowView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:30.0];
            [self.yellowView autoAlignAxis:ALAxisVertical toSameAxisOfView:self.redView];
            [self.yellowView autoSetDimensionsToSize:CGSizeMake(100.0, 100.0)];
        }];
        
        self.didSetupYellowConstraints = YES;
    }
}

-(void) undoConstraints {
    self.didSetupPurpleConstraints = NO;
    self.didSetupGreenConstraints = NO;
    self.didSetupRedConstraints = NO;
    self.didSetupYellowConstraints = NO;
    self.didSetupBlueConstraints = NO;
}

#pragma mark - gesture recognizers

-(void) addTapGestureRecognizer {
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognizerTapped:)];
    
    tapGestureRecognizer.numberOfTapsRequired = 2;
    tapGestureRecognizer.numberOfTouchesRequired = 1;
    
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

-(void) tapGestureRecognizerTapped:(UITapGestureRecognizer *)recognizer {
    
//    NSInteger transformerPicker = arc4random_uniform(3); //use this to randomize which method is called
    
    [self shrinkRedView];
    [self moveYellowView];
    [self rotateGreenView];
    [self fadeBlueView];
    [self recolorPurpleView];
}

-(void) addSwipeGestureRecognizer {
    
    UISwipeGestureRecognizer *swipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestureRecognizerSwiped:)];
    
    swipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    
    [self.view addGestureRecognizer:swipeGestureRecognizer];
}

-(void) swipeGestureRecognizerSwiped:(UISwipeGestureRecognizer *)recognizer {
    
    SecondViewController *secondViewController = [[SecondViewController alloc] init];
    [self.navigationController pushViewController:secondViewController animated:YES];
    
}

#pragma mark - translate, scale and rotating views

-(void) shrinkRedView {
    
    [self undoConstraints];
    
    CGFloat scaleFloat = arc4random_uniform(9) / 10.0;
    
    [UIView animateWithDuration:1.0 animations:^{
        self.redView.transform = CGAffineTransformMakeScale(scaleFloat, scaleFloat);
        
    } completion:^(BOOL finished) {
        [self updateAllConstraints];
    }];
}

-(void) moveYellowView {
    
    [self undoConstraints];
    
    CGFloat translateFloat = arc4random_uniform(99) * 1.0;
    
    [UIView animateWithDuration:1.0 animations:^{
        self.yellowView.transform = CGAffineTransformMakeTranslation(translateFloat, -translateFloat);
        
    } completion:^(BOOL finished) {
        [self updateAllConstraints];
    }];
}

-(void) rotateGreenView {
    
    [self undoConstraints];
    
    CGFloat rotateFloat = arc4random_uniform(99) * 1.0;
    
    [UIView animateWithDuration:1.0 animations:^{
        self.greenView.transform = CGAffineTransformMakeRotation(rotateFloat);
        
    } completion:^(BOOL finished) {
        [self updateAllConstraints];
    }];
}

-(void) fadeBlueView {
    
    [self undoConstraints];
    
    CGFloat fadeFloat = arc4random_uniform(5) * 1.0;
    
    [UIView animateWithDuration:1.0 animations:^{
        self.blueView.alpha = fadeFloat;
        
    } completion:^(BOOL finished) {
        [self updateAllConstraints];
    }];
}

-(void) recolorPurpleView {
    
    [self undoConstraints];
    
    [UIView animateWithDuration:1.0 animations:^{
        self.purpleView.layer.backgroundColor = [self pickColor].CGColor;
        
    } completion:^(BOOL finished) {
        [self updateAllConstraints];
    }];
}

-(UIColor *) pickColor {
    
    self.colorCount++;
    
    if (self.colorCount >= self.colors.count) {
        self.colorCount = 0;
    }
    
    return self.colors[self.colorCount];
}



@end
