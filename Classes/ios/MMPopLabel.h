
#import <UIKit/UIKit.h>
#import "MMPopLabelDelegate.h"
#import "MMLabel.h"


///////////////////////////////////////////////////////////////////////////////
#pragma mark - Animation Options
///////////////////////////////////////////////////////////////////////////////


typedef NS_OPTIONS(NSUInteger, MMPopLabelAnimationOptions) {
    MMPopLabelAnimationOptionPopViewAndLabel = 0, // default
    MMPopLabelAnimationOptionPopViewOnly = 1,
    MMPopLabelAnimationOptionDontPop = 2
};


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


+ (MMPopLabel *)popLabelWithText:(NSString *)text;
+ (MMPopLabel *)popLabelWithText:(NSString *)text options:(MMPopLabelAnimationOptions)options;
- (void)addButton:(UIButton *)button;
- (void)popAtView:(UIView *)view;
- (void)popAtBarButtonItem:(UIBarButtonItem *)barButtonItem;
- (void)dismiss;


@end
