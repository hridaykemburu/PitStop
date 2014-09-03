//
//  LoginViewController.h
//  PitStop
//
//  Created by Hriday Kemburu on 9/2/14.
//  Copyright (c) 2014 Hriday Kemburu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *loginButton;
- (IBAction)login:(id)sender;
//@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *activityLogin;
//@property (weak, nonatomic) IBOutlet FBLoginView *fbLoginOutlet;
@end
