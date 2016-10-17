//
//  NDIntroPageView.m
//  NDParallaxIntroView
//
//  Created by Simon Wicha on 17/04/2016.
//  Copyright © 2016 Simon Wicha. All rights reserved.
//

#import "NDPageA.h"

@implementation NDPageA

- (void)initialize{
    self.backgroundColor = [UIColor clearColor];
    UIView *blueCover = [[UIView alloc] initWithFrame: self.imageView.frame];
    blueCover.backgroundColor = [UIColor blueColor];
    blueCover.layer.opacity = 0.5f;
    [self addSubview:blueCover];
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

- (IBAction)onClickNext:(id)sender {
    [self.delegate goToNextPage];
}

- (IBAction)goToExit:(id)sender {
    [self.delegate goToPreviousPage];
}
@end
