//
//  NDIntroPageView.h
//  NDParallaxIntroView
//
//  Created by Simon Wicha on 17/04/2016.
//  Copyright © 2016 Simon Wicha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NextClickDelegate.h"

@interface NDPageC : UIView

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *titlelabel;
- (IBAction)goToBackPage:(id)sender;
- (IBAction)updateUserDetails:(id)sender;

@property (assign, nonatomic) id<NextClickDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextField *tf_email;
@property (weak, nonatomic) IBOutlet UITextField *tf_password;
@property (weak, nonatomic) IBOutlet UITextField *tf_name;
@property (weak, nonatomic) IBOutlet UITextField *tf_company;
@property (weak, nonatomic) IBOutlet UITextField *tf_telephone;

@end
