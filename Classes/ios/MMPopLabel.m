

#import "MMPopLabel.h"


///////////////////////////////////////////////////////////////////////////////
#pragma mark - Local Types and Constants
///////////////////////////////////////////////////////////////////////////////


CGFloat const kMMPopLabelSidePadding = 10.0f;
CGFloat const kMMPopLabelViewPadding = 2.0f;
CGFloat const kMMPopLabelCornerRadius = 6.0f;
CGFloat const kMMPopLabelTipPadding = 8.0f;


typedef enum : NSUInteger {
    MMPopLabelTopArrow,
    MMPopLabelBottomArrow,
} MMPopLabelArrowType;


///////////////////////////////////////////////////////////////////////////////
#pragma mark - Private Interface
///////////////////////////////////////////////////////////////////////////////


@interface MMPopLabel ()

@property (nonatomic, assign) CGRect targetFrame;
@property (nonatomic, retain) MMLabel *label;
@property (nonatomic, assign) CGFloat tipSize;

@property (nonatomic, retain) NSMutableArray *buttons;
@property (nonatomic, assign) CGPoint viewCenter;
@property (nonatomic, assign) MMPopLabelArrowType arrowType;

@property (nonatomic, assign) BOOL animateTargetView;
@property (nonatomic, assign) BOOL animatePopLabel;

@end


///////////////////////////////////////////////////////////////////////////////
#pragma mark - Implementation
///////////////////////////////////////////////////////////////////////////////


@implementation MMPopLabel


+ (MMPopLabel *)popLabelWithText:(NSString *)text
{
    MMPopLabel *popLabel = [[MMPopLabel alloc] initWithText:text];

    return popLabel;
}


+ (MMPopLabel *)popLabelWithText:(NSString *)text options:(MMPopLabelAnimationOptions)options
{
    MMPopLabel *popLabel = [MMPopLabel popLabelWithText:text];

    if (options == MMPopLabelAnimationOptionPopViewAndLabel) {
        popLabel.animateTargetView = YES;
        popLabel.animatePopLabel = YES;
    } else if (options == MMPopLabelAnimationOptionPopViewOnly) {
        popLabel.animateTargetView = NO;
        popLabel.animatePopLabel = YES;
    } else {
        popLabel.animateTargetView = NO;
        popLabel.animatePopLabel = NO;
    }

    return popLabel;
}


- (id)initWithText:(NSString *)text
{
    if (self = [super initWithFrame:CGRectZero])
    {
        self.animateTargetView = YES;
        self.animatePopLabel = YES;

        self.buttons = [@[] mutableCopy];
        
        self.backgroundColor = [UIColor clearColor];
        self.hidden = YES;

        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            self.tipSize = 24;
        } else {
            self.tipSize = 12;
        }

        self.label = [[MMLabel alloc] initWithFrame:CGRectZero];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.text = text;
        self.label.backgroundColor = [UIColor clearColor];
        self.label.numberOfLines = 0;
        
        [self addSubview:self.label];
    }
    return self;
}


- (void)setupAppearance
{
    /* setup color and font properties */
    if (!_labelColor) {
        _labelColor = [UIColor blackColor];
    }
    
    if (!_labelTextColor) {
        _labelTextColor = [UIColor whiteColor];
    }
    
    if (!_labelTextHighlightColor) {
        _labelTextHighlightColor = [UIColor whiteColor];
    }
    
    if (!_labelFont) {
        _labelFont = [UIFont systemFontOfSize:_tipSize];
    }
    
    self.label.textColor = _labelTextColor;
    self.label.font = _labelFont;

    /* resize label and view */
    CGFloat maxWidth = [UIScreen mainScreen].applicationFrame.size.width * 0.80f;
    CGFloat maxHeight = [UIScreen mainScreen].applicationFrame.size.height * 0.80f;

    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:self.label.text
                                                                         attributes:@{NSFontAttributeName:_labelFont}];
    CGRect rect = [attributedText boundingRectWithSize:(CGSize){maxWidth, CGFLOAT_MAX}
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    CGFloat minWidth = MAX(rect.size.width, 180);
    CGFloat minHeight = MIN(rect.size.height, maxHeight);

    self.label.frame = CGRectMake(0, 0, minWidth, minHeight);
    [self.label sizeToFit];
    
    self.targetFrame = self.label.frame;
    self.frame = CGRectMake(_targetFrame.origin.x,
                            _targetFrame.origin.y,
                            minWidth,
                            _targetFrame.size.height + _tipSize * 4);
    self.label.frame = CGRectMake(_targetFrame.origin.x,
                                  _targetFrame.origin.y,
                                  minWidth, _targetFrame.size.height + _tipSize * 4);

    /* add buttons, if any */
    if (_buttons.count == 0) return;
    
    self.frame = CGRectMake(self.frame.origin.x,
                            self.frame.origin.y,
                            self.frame.size.width,
                            self.frame.size.height + 33);

    NSInteger index = 0;
    NSInteger buttonWidth = self.frame.size.width / _buttons.count;
    for (UIButton *b in _buttons) {
        b.tag = index;
        b.frame = CGRectMake(self.bounds.origin.x + (index * buttonWidth),
                             self.bounds.origin.y + self.bounds.size.height - 44,
                             buttonWidth, 33);

        if (_buttonFont) {
            b.titleLabel.font = _buttonFont;
        } else {
            b.titleLabel.font = [UIFont systemFontOfSize:_tipSize];
        }

        [b setTitleColor:_labelTextColor forState:UIControlStateNormal];
        [b setTitleColor:_labelTextHighlightColor forState:UIControlStateHighlighted];
        
        [b addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:b];
        index ++;
    }
}


- (void)addButton:(UIButton *)button
{
    [self.buttons addObject:button];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    [self setupAppearance];
}


- (void)popAtView:(UIView *)view
{
    if (self.hidden == NO) return;

    CGPoint center = view.center;
    if ([[view superview] superview] != self.window) {
        center = [self.window convertPoint:view.center fromView:view];
    }
    self.center = center;

    _arrowType = MMPopLabelTopArrow;

    CGPoint position = CGPointMake(center.x, center.y + self.frame.size.height / 2 + view.frame.size.height / 2 + kMMPopLabelViewPadding);

    if (position.x + (self.bounds.size.width / 2) > [UIScreen mainScreen].applicationFrame.size.width) {
        CGFloat diff = (self.bounds.size.width + self.frame.origin.x - [UIScreen mainScreen].applicationFrame.size.width) + kMMPopLabelSidePadding;
        position = CGPointMake(view.center.x - diff, position.y);
    } else if (self.frame.origin.x < 0) {
        CGFloat diff = - self.frame.origin.x + kMMPopLabelSidePadding;
        position = CGPointMake(center.x + diff, center.y + view.frame.size.height / 2);
    }

    if (self.frame.origin.y + self.frame.size.height + (self.buttons.count > 0 ? 44 : 0) > [UIScreen mainScreen].applicationFrame.size.height) {
        _arrowType = MMPopLabelBottomArrow;
        position = CGPointMake(position.x,
                               (self.frame.origin.y - view.frame.size.height / 2 - kMMPopLabelViewPadding));
    } else if (self.frame.origin.y < 0) {
        position = CGPointMake(position.x, center.y + self.frame.size.height / 2 + view.frame.size.height / 2 + kMMPopLabelViewPadding);
    }

     CGPoint centerPoint = CGPointMake(position.x, position.y);
    self.center = position;

    _viewCenter = CGPointMake(view.center.x - self.frame.origin.x - 8, view.center.y);

    NSInteger duration = 1.0f;
    NSInteger delay = 0.0f;

    self.alpha = 0.0f;
    self.hidden = NO;

    [self setNeedsDisplay];

    if (self.animatePopLabel) {
        self.transform = CGAffineTransformMakeScale(0, 0);
    }
    if (self.animateTargetView) {
        view.transform = CGAffineTransformMakeScale(0, 0);
    }
    [UIView animateKeyframesWithDuration:duration/6.0f delay:delay options:0 animations:^{
        self.center = centerPoint;
        self.alpha = 1.0f;
        if (self.animatePopLabel) {
            self.transform = CGAffineTransformMakeScale(1.2, 1.2);
        }
        if (self.animateTargetView) {
            view.transform = CGAffineTransformMakeScale(1.2, 1.2);
        }
    } completion:^(BOOL finished) {
        if (self.animateTargetView || self.animatePopLabel) {
            [UIView animateKeyframesWithDuration:duration/6.0f delay:0 options:0 animations:^{
                if (self.animatePopLabel) {
                    self.transform = CGAffineTransformMakeScale(0.9, 0.9);
                }
                if (self.animateTargetView) {
                    view.transform = CGAffineTransformMakeScale(0.9, 0.9);
                }
            } completion:^(BOOL finished) {
                [UIView animateKeyframesWithDuration:duration/6.0f delay:0 options:0 animations:^{
                    if (self.animatePopLabel) {
                        self.transform = CGAffineTransformMakeScale(1, 1);
                    }
                    if (self.animateTargetView) {
                        view.transform = CGAffineTransformMakeScale(1, 1);
                    }
                } completion:^(BOOL finished) {
                    // completion block empty?
                }];
            }];
        }
    }];
}


- (void)popAtBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    UIView *view = [barButtonItem valueForKey:@"view"];
    NSAssert(view != nil, @"Unable to obtain UIBarButtonItem's View");

    if (view != nil) {
        [self popAtView:view];
    }
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self dismiss];
}


- (void)dismiss
{
    if (self.hidden == YES) return;

    [UIView animateWithDuration:0.15f animations:^{
        self.alpha = 0.0f;
    } completion:^(BOOL finished) {
        self.hidden = YES;
        [_delegate dismissedPopLabel:self];
    }];
}


- (void)drawRect:(CGRect)rect
{
    //// General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Tip Drawing
    CGContextSaveGState(context);
    if (_arrowType == MMPopLabelBottomArrow) {
        CGContextTranslateCTM(context, _viewCenter.x, rect.size.height - kMMPopLabelTipPadding);
    } else if (_arrowType == MMPopLabelTopArrow) {
        CGContextTranslateCTM(context, _viewCenter.x, kMMPopLabelTipPadding);
    }
    CGContextRotateCTM(context, -45 * M_PI / 180);
    
    UIBezierPath* tipPath = [UIBezierPath bezierPathWithRect: CGRectMake(0, 0, 11, 11)];
    [_labelColor setFill];
    [tipPath fill];
    
    CGContextRestoreGState(context);
    
    //// ViewBackground Drawing
    UIBezierPath* viewBackgroundPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(rect.origin.x,
                                                                                          rect.origin.y + kMMPopLabelTipPadding,
                                                                                          rect.size.width,
                                                                                          rect.size.height - kMMPopLabelTipPadding * 2)
                                                                  cornerRadius:kMMPopLabelCornerRadius];
    [_labelColor setFill];
    [viewBackgroundPath fill];
}


///////////////////////////////////////////////////////////////////////////////
#pragma mark - Button Handling
///////////////////////////////////////////////////////////////////////////////


- (void)buttonPressed:(id)sender
{
    UIButton *button = (UIButton *)sender;
    if (_delegate != nil) {
        [_delegate didPressButtonForPopLabel:self atIndex:button.tag];
    }
    [self dismiss];
}


@end
