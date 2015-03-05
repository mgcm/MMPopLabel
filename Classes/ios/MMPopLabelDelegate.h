
#import <Foundation/Foundation.h>

@class MMPopLabel;

@protocol MMPopLabelDelegate <NSObject>

@optional
- (void)dismissedPopLabel:(MMPopLabel *)popLabel;
- (void)didPressButtonForPopLabel:(MMPopLabel *)popLabel atIndex:(NSInteger)index;

@end
