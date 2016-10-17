//
//  NDIntroPageView.m
//  NDParallaxIntroView
//
//  Created by Simon Wicha on 17/04/2016.
//  Copyright © 2016 Simon Wicha. All rights reserved.
//

#import "NDPageB.h"

@implementation NDPageB
{
    UIView* activeField;
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
- (void)initialize{
    self.backgroundColor = [UIColor clearColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    [self.textfieldCode setDelegate:self];
    [self.inputUser setDelegate:self];
    


}
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your app might not need or want this behavior.
    CGRect aRect = self.frame;
    aRect.size.height -= kbSize.height;
    if (!activeField && !CGRectContainsPoint(aRect, activeField.frame.origin) ) {
        [self.scrollView scrollRectToVisible:activeField.frame animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    activeField = textField;
}
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}



- (IBAction)onClick:(id)sender {
    
    [NSThread sleepForTimeInterval:2.0f];
    //[self makeVisible:self.buttonNext];
    [self makeVisible:self.textfieldCode];
    [self.descriptionLabel setText:@"Check your email!"];
    
    if(self.delegate){
        //[self.delegate onClickValidateInput];
    }
    else{
        NSLog(@"Your delegate is null");
    }
}


- (IBAction)goPreviousPage:(id)sender {
    [self.delegate goToPreviousPage];
}

- (IBAction)validateCode:(id)sender {
    if([self.textfieldCode.text length]!=0){
        [self.delegate updateNumPages:3];
        [self.delegate goToNextPage];
    }
}

- (void)makeVisible:(UIView *)view {
    view.alpha = 0;
    view.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        view.alpha = 1;
    }];
}

- (void)makeInvisible:(UIView *)view{
    [UIView animateWithDuration:0.3 animations:^{
        view.alpha = 0;
    } completion: ^(BOOL finished) {//creates a variable (BOOL) called "finished" that is set to *YES* when animation IS completed.
        view.hidden = finished;//if animation is finished ("finished" == *YES*), then hidden = "finished" ... (aka hidden = *YES*)
    }];
}

@end
