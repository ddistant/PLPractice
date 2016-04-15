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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated {
    
    [self createViews];
    [self addViews];
    [self updateAllConstraints];
    [self addTapGestureRecognizer];
}

- (void) createViews {
    
    self.purpleView = [ALView newAutoLayoutView];
    self.redView = [ALView newAutoLayoutView];
    self.blueView = [ALView newAutoLayoutView];
    self.greenView = [ALView newAutoLayoutView];
    self.yellowView = [ALView newAutoLayoutView];
    
}

-(void) addViews {
    
    [self.view addSubview:self.purpleView];
    [self.view addSubview:self.redView];
    [self.view addSubview:self.blueView];
    [self.view addSubview:self.greenView];
    [self.view addSubview:self.yellowView];
}

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
            self.purpleView.layer.backgroundColor = [UIColor purpleColor].CGColor;
        }];
    }
    
    self.didSetupPurpleConstraints = YES;
}

-(void) updateRedConstraints {
    
    if (!self.didSetupRedConstraints) {
        
        [NSLayoutConstraint autoCreateAndInstallConstraints:^{
            [self.redView autoCenterInSuperview];
            [self.redView autoSetDimensionsToSize:CGSizeMake(100.0, 100.0)];
            self.redView.layer.backgroundColor = [UIColor redColor].CGColor;
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
            self.blueView.layer.backgroundColor = [UIColor blueColor].CGColor;
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
            self.greenView.layer.backgroundColor = [UIColor greenColor].CGColor;
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
            self.yellowView.layer.backgroundColor = [UIColor yellowColor].CGColor;
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

-(void) addTapGestureRecognizer {
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognizerTapped:)];
    
    tapGestureRecognizer.numberOfTapsRequired = 2;
    tapGestureRecognizer.numberOfTouchesRequired = 1;
    
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

-(void) tapGestureRecognizerTapped:(UITapGestureRecognizer *)recognizer {
    
    NSInteger transformerPicker = arc4random_uniform(3); //use this to randomize which method is called
    
    [self shrinkRedView];
    [self moveYellowView];
    [self rotateGreenView];
    [self fadeBlueView];
}

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



@end
