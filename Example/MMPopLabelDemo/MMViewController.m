//
//  MMViewController.m
//  MMPopLabelDemo
//
//  Created by Milton Moura on 27/05/14.
//  Copyright (c) 2014 Milton Moura. All rights reserved.
//

#import "MMViewController.h"
#import "MMPopLabelDelegate.h"


///////////////////////////////////////////////////////////////////////////////
#pragma mark - Private Interface
///////////////////////////////////////////////////////////////////////////////


@interface MMViewController () <MMPopLabelDelegate>

@property (weak, nonatomic) IBOutlet UIButton *topButton;
@property (weak, nonatomic) IBOutlet UIButton *bottomButton;
@property (weak, nonatomic) IBOutlet UIButton *showPopupButton;
@property (nonatomic, retain) MMPopLabel *label;

@end


///////////////////////////////////////////////////////////////////////////////
#pragma mark - Implementation
///////////////////////////////////////////////////////////////////////////////


@implementation MMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [[MMPopLabel appearance] setLabelColor:[UIColor colorWithRed: 0.89 green: 0.6 blue: 0 alpha: 1]];
    [[MMPopLabel appearance] setLabelTextColor:[UIColor whiteColor]];
    [[MMPopLabel appearance] setLabelTextHighlightColor:[UIColor greenColor]];
    [[MMPopLabel appearance] setLabelFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:12.0f]];
    [[MMPopLabel appearance] setButtonFont:[UIFont fontWithName:@"HelveticaNeue" size:12.0f]];
    
    _label = [MMPopLabel popLabelWithText:
              @"Lorem Ipsum is simply dummy text of the printing and typesetting industry. "
              "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s."];

    _label.delegate = self;

    UIButton *skipButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [skipButton setTitle:NSLocalizedString(@"Skip Tutorial", @"Skip Tutorial Button") forState:UIControlStateNormal];
    [_label addButton:skipButton];
    
    UIButton *okButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [okButton setTitle:NSLocalizedString(@"OK, Got It!", @"Dismiss Button") forState:UIControlStateNormal];
    [_label addButton:okButton];

    [self.view addSubview:_label];
}


- (IBAction)showLabel:(id)sender
{
    [_label popAtView:_showPopupButton];
}


- (IBAction)topPressed:(id)sender
{
    [_label popAtView:_topButton];
}


- (IBAction)bottomPressed:(id)sender
{
    [_label popAtView:_bottomButton];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_label dismiss];
}


///////////////////////////////////////////////////////////////////////////////
#pragma mark - MMPopLabelDelegate
///////////////////////////////////////////////////////////////////////////////


- (void)dismissedPopLabel:(MMPopLabel *)popLabel
{
    NSLog(@"disappeared");
}

- (void)didPressButtonForPopLabel:(MMPopLabel *)popLabel atIndex:(NSInteger)index
{
    NSLog(@"pressed %i", index);
}

/*
- (void)didPressDismissForPopLabel:(MMPopLabel *)popLabel
{
    NSLog(@"dismiss");
}


- (void)didPressSkipForPopLabel:(MMPopLabel *)popLabel
{
    NSLog(@"skip");    
}
*/

@end
