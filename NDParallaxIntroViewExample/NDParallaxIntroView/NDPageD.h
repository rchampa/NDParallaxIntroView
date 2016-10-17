//
//  NDIntroPageView.h
//  NDParallaxIntroView
//
//  Created by Simon Wicha on 17/04/2016.
//  Copyright © 2016 Simon Wicha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NextClickDelegate.h"

@interface NDPageD : UIView

@property (assign, nonatomic) id<NextClickDelegate> delegate;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *titlelabel;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;
- (IBAction)goToPreviousPage:(id)sender;
- (IBAction)goToLoginPage:(id)sender;

@end
