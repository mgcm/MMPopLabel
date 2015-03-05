# MMPopLabel

[![Version](https://img.shields.io/cocoapods/v/MMPopLabel.svg?style=flat)](http://cocoadocs.org/docsets/MMPopLabel)
[![License](https://img.shields.io/cocoapods/l/MMPopLabel.svg?style=flat)](http://cocoadocs.org/docsets/MMPopLabel)
[![Platform](https://img.shields.io/cocoapods/p/MMPopLabel.svg?style=flat)](http://cocoadocs.org/docsets/MMPopLabel)

## Usage

To run the example project; clone the repo, and run `pod install` from the Example directory first.

To use it in your view controller, with styles and buttons:

```objective-c
// set appearance style
[[MMPopLabel appearance] setLabelColor:[UIColor blueColor]];
[[MMPopLabel appearance] setLabelTextColor:[UIColor whiteColor]];
[[MMPopLabel appearance] setLabelTextHighlightColor:[UIColor greenColor]];
[[MMPopLabel appearance] setLabelFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:12.0f]];
[[MMPopLabel appearance] setButtonFont:[UIFont fontWithName:@"HelveticaNeue" size:12.0f]];

// _label is a view controller property
_label = [MMPopLabel popLabelWithText:
          @"Lorem Ipsum is simply dummy text of the printing and typesetting industry. "
          "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s."];

// add a couple of buttons
UIButton *skipButton = [[UIButton alloc] initWithFrame:CGRectZero];
[skipButton setTitle:NSLocalizedString(@"Skip Tutorial", @"Skip Tutorial Button") forState:UIControlStateNormal];
[_label addButton:skipButton];

UIButton *okButton = [[UIButton alloc] initWithFrame:CGRectZero];
[okButton setTitle:NSLocalizedString(@"OK, Got It!", @"Dismiss Button") forState:UIControlStateNormal];
[_label addButton:okButton];

// add it to your view
[self.view addSubview:_label];
```

To show the label, just add this code to a button action or some other type of event, passing in the view you wish to point to:

```objective-c
- (IBAction)showLabel:(id)sender
{
	UIView *view = (UIView *)sender;
	[_label popAtView:view];
}
```

MMPopLabel now also supports *UIBarButtonItem*:

```objective-c
- (IBAction)showLabel:(id)sender
{
	UIBarButtonItem *barButtonItem = (UIBarButtonItem *)sender;
	[_label popAtBarButtonItem:barButtonItem];
}
```

To receive the label events, just set your view controller as it's delegate and implement the *MMPopLabelDelegate* protocol:

```objective-c
- (void)dismissedPopLabel:(MMPopLabel *)popLabel;
- (void)didPressButtonForPopLabel:(MMPopLabel *)popLabel atIndex:(NSInteger)index;
```

To disable animations, use of the following option when setting up your label:

```objective-c
_label = [MMPopLabel popLabelWithText:
          @"Lorem Ipsum is simply dummy text of the printing and typesetting industry. "
          "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s." options:MMPopLabelAnimationOptionDontPop];
```

Check the *MMPopLabelAnimationOptions* enumeration for more options.

## Screenshots

![Screen #1](https://raw.githubusercontent.com/mgcm/MMPopLabel/master/Assets/MMPopLabel-1.png)
![Screen #2](https://raw.githubusercontent.com/mgcm/MMPopLabel/master/Assets/MMPopLabel-2.png)
![Screen #3](https://raw.githubusercontent.com/mgcm/MMPopLabel/master/Assets/MMPopLabel-3.png)

## Requirements

* iOS 7.0+ and XCode 5.1+

## Installation

MMPopLabel is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "MMPopLabel"

## Author

mgcm, miltonmoura@gmail.com

## License

MMPopLabel is available under the MIT license. See the LICENSE file for more info.

