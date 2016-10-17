//
//  NDIntroPageView.m
//  NDParallaxIntroView
//
//  Created by Simon Wicha on 17/04/2016.
//  Copyright © 2016 Simon Wicha. All rights reserved.
//

#import "NDPageC.h"

@implementation NDPageC

- (void)initialize{
    self.backgroundColor = [UIColor clearColor];
}

- (id)initWithCoder:(NSCoder *)aCoder{
    if(self = [super initWithCoder:aCoder]){
        [self initialize];
    }
    return self;
}

- (id)initWithFrame:(CGRect)rect{
    if(self = [super initWithFrame:rect]){
        [self initialize];
    }
    return self;
}

- (IBAction)goToBackPage:(id)sender {
    [self.delegate goToPreviousPage];
}

- (IBAction)updateUserDetails:(id)sender {
    if(self.tf_name.text.length!=0){
        [self.delegate updateNumPages:4];
        [self.delegate goToNextPage];
    }
}
@end
