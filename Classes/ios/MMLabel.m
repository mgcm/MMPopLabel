
#import "MMLabel.h"

@implementation MMLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // nothing to see here
    }
    return self;
}

- (void) drawTextInRect:(CGRect)rect
{
    UIEdgeInsets insets = {5,5,5,5};
    
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}

@end
