//
//  NDIntroPageView.h
//  NDParallaxIntroView
//
//  Created by Simon Wicha on 17/04/2016.
//  Copyright © 2016 Simon Wicha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NextClickDelegate.h"

@interface NDPageA : UIView

@property (assign, nonatomic) id<NextClickDelegate> delegate;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *titlelabel;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;
- (IBAction)onClickNext:(id)sender;
- (IBAction)goToExit:(id)sender;

@end
