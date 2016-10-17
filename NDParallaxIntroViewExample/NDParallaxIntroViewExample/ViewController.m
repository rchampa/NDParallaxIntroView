//
//  ViewController.m
//  NDParallaxIntroViewExample
//
//  Created by Simon Wicha on 17/04/2016.
//  Copyright © 2016 Simon Wicha. All rights reserved.
//

#import "ViewController.h"
#import "NDIntroView.h"

@interface ViewController () <NDIntroViewDelegate>
{
    UIGestureRecognizer *tapper;
}

@property (strong, nonatomic) NDIntroView *introView;
@property (weak, nonatomic) IBOutlet UIButton *restartButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.restartButton setBackgroundColor:[UIColor colorWithRed:70.f/255.f green:130.f/255.f blue:180.f/255.f alpha:1.f]];
    self.restartButton.layer.cornerRadius = 5.f;
    
    tapper = [[UITapGestureRecognizer alloc]
              initWithTarget:self action:@selector(handleSingleTap:)];
    tapper.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapper];
    
    [self startIntro];
}
- (void)handleSingleTap:(UITapGestureRecognizer *) sender{
    [self.view endEditing:YES];
}

- (IBAction)restartIntroViewButtonPressed:(id)sender {
    [self startIntro];
}


#pragma mark - NDIntroView methods

-(void)startIntro {
    NSArray *pageContentArray;
    self.introView = [[NDIntroView alloc] initWithFrame:self.view.frame
                                          parallaxImage:[UIImage imageNamed:@"parallaxBgImage"]
                                                andData:pageContentArray
                                           withNumPages:2
                                        showPageControl:NO
                      ];
    self.introView.delegate = self;
    [self.view addSubview:self.introView];
}

-(void)launchAppButtonPressed {
//    [UIView animateWithDuration:0.7f animations:^{
//        self.introView.alpha = 0;
//    } completion:^(BOOL finished) {
//        [self.introView removeFromSuperview];
//    }];
    
    [self.introView updatePages:5];
    
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

@end
