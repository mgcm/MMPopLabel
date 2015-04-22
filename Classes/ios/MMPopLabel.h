//
//  MMPopLabel.h
//  MMPopLabel
//
//  Created by Milton Moura on 05/01/14.
//  Copyright (c) 2014 Milton Moura. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMPopLabelDelegate.h"
#import "MMLabel.h"

///////////////////////////////////////////////////////////////////////////////
#pragma mark - Public Interface
///////////////////////////////////////////////////////////////////////////////

@interface MMPopLabel : UIView


@property (nonatomic, retain) UIColor *labelColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, retain) UIColor *labelTextColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, retain) UIColor *labelTextHighlightColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, retain) UIFont *labelFont UI_APPEARANCE_SELECTOR;
@property (nonatomic, retain) UIFont *buttonFont UI_APPEARANCE_SELECTOR;

@property (nonatomic, weak) id<MMPopLabelDelegate> delegate;

+ (MMPopLabel *)popLabelWithAttributedString:(NSAttributedString *)attributedString;

+ (MMPopLabel *)popLabelWithText:(NSString *)text;
- (void)addButton:(UIButton *)button;

- (void)popAtView:(UIView *)view animated: (BOOL) animated;

//Keeping this method without animated boolean for retrocompatibility
//will use animations by default
- (void)popAtView:(UIView *)view;

- (void)setText: (NSString *)text;

- (void)dismiss;


@end
