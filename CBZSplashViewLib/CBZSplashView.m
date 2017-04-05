//
//  CBZSplashView.m
//  MicroMessage
//
//  Created by Callum Boddy on 22/07/2014.
//  Copyright (c) 2014 Callum Boddy. All rights reserved.
//

#import "CBZSplashView.h"
#import "CBZRasterSplashView.h"
#import "CBZVectorSplashView.h"


@implementation CBZSplashView

#pragma mark - Factory methods

+ (instancetype)splashViewWithIcon:(UIImage *)icon backgroundColor:(UIColor *)backgroundColor {
	/* This component is useless without an icon */
	NSParameterAssert(icon);

	return [[CBZRasterSplashView alloc] initWithIconImage:icon backgroundColor:backgroundColor];
}

+ (instancetype)splashViewWithBezierPath:(UIBezierPath *)bezier backgroundColor:(UIColor *)backgroundColor {
	return [[CBZVectorSplashView alloc] initWithBezierPath:bezier backgroundColor:backgroundColor];
}

#pragma mark - Init & Dealloc

- (instancetype)init {
	return [super initWithFrame:[[UIScreen mainScreen] bounds]];
}

#pragma mark - Public methods

- (void)startAnimation {
	[self startAnimationWithCompletionHandler:nil];
}

- (void)startAnimationWithCompletionHandler:(void (^)())completionHandler; {
	NSAssert(NO, @"Override me!");
}

#pragma mark - property getters

- (CGSize)iconStartSize {
	if (!_iconStartSize.height) {
		_iconStartSize = CGSizeMake(60, 60);
	}
	return _iconStartSize;
}

- (CGFloat)animationDuration {
	if (!_animationDuration) {
		_animationDuration = 1.0f;
	}
	return _animationDuration;
}

- (CAAnimationGroup *)iconAnimation {
	if (!_iconAnimation) {
		CAAnimationGroup *animationGroup = [CAAnimationGroup animation];

//		CAKeyframeAnimation *fade = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
//		fade.values = @[@1.0, @1.0, @0.0];
//		fade.keyTimes = @[@0, @0.8, @1];
		CABasicAnimation *fade = [CABasicAnimation animationWithKeyPath:@"opacity"];		fade.fromValue = [NSNumber numberWithFloat:0.0];
		fade.toValue = [NSNumber numberWithFloat:1.0];
		fade.duration = self.animationDuration;
		fade.removedOnCompletion = NO;
		fade.fillMode = kCAFillModeForwards;
		fade.timingFunction = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
				[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
//		fade.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
//				[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];

//		CAKeyframeAnimation *scale = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
//		scale.values = @[@1, @0.9, @300];
//		scale.keyTimes = @[@0, @0.4, @1];
//		scale.duration = self.animationDuration;
//		scale.removedOnCompletion = NO;
//		scale.fillMode = kCAFillModeForwards;
//		scale.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
//				[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];

//		animationGroup.animations = [NSArray arrayWithObjects:scale, fade, nil];
		animationGroup.animations = [NSArray arrayWithObjects:fade, nil];

		_iconAnimation = animationGroup;
	}
	return _iconAnimation;
}

- (UIColor *)iconColor {
	if (!_iconColor) {
		_iconColor = [UIColor whiteColor];
	}
	return _iconColor;
}

@end
