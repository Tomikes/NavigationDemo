//
//  Nav.m
//  CustomPopAnimation
//
//  Created by Jazys on 15/3/30.
//  Copyright (c) 2015年 Jazys. All rights reserved.
//

#import "Nav.h"
#import "NavigationInteractiveTransition.h"

@interface Nav () <UIGestureRecognizerDelegate>
@property (nonatomic, weak) UIPanGestureRecognizer *popRecognizer;
/**
 *  方案一不需要的变量
 */
@property (nonatomic, strong) NavigationInteractiveTransition *navT;
@end

@implementation Nav

- (void)viewDidLoad {
    [super viewDidLoad];

    UIGestureRecognizer *gesture = self.interactivePopGestureRecognizer;
    gesture.enabled = NO;
    UIView *gestureView = gesture.view;
    
    UIPanGestureRecognizer *popRecognizer = [[UIPanGestureRecognizer alloc] init];
    popRecognizer.delegate = self;
    popRecognizer.maximumNumberOfTouches = 1;
    [gestureView addGestureRecognizer:popRecognizer];
    

    _navT = [[NavigationInteractiveTransition alloc] initWithViewController:self];
    [popRecognizer addTarget:_navT action:@selector(handleControllerPop:)];
    

}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    /**
     *  这里有两个条件不允许手势执行，1、当前控制器为根控制器；2、如果这个push、pop动画正在执行（私有属性）
     */
    return self.viewControllers.count != 1 && ![[self valueForKey:@"_isTransitioning"] boolValue];
}

@end
