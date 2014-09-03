//
//  LoginViewController.m
//  PitStop
//
//  Created by Hriday Kemburu on 9/2/14.
//  Copyright (c) 2014 Hriday Kemburu. All rights reserved.
//

#import "LoginViewController.h"
#import "MapSearchViewController.h"

@interface LoginViewController () <CommsDelegate>

@end

@implementation LoginViewController

@synthesize loginButton = _loginButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [PFUser logOut];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    _loginButton.layer.cornerRadius = 10; // this value vary as per your desire
    _loginButton.clipsToBounds = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)login:(id)sender {
    // Disable the Login button to prevent multiple touches
    [_loginButton setEnabled:NO];
    
    // Do the login
    [Comms login:self];
}

- (void) commsDidLogin:(BOOL)loggedIn {
    // Re-enable the Login button
    [_loginButton setEnabled:YES];
    
    // Did we login successfully ?
    if (loggedIn) {
        // Seque to the Image Wall
        MapSearchViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"mapSearchViewControllerID" ];
        [self.navigationController pushViewController:vc animated:YES];
        //[self performSegueWithIdentifier:@"LoginSuccessful" sender:self];
    } else {
        // Show error alert
        [[[UIAlertView alloc] initWithTitle:@"Login Failed"
                                    message:@"Facebook Login failed. Please try again"
                                   delegate:nil
                          cancelButtonTitle:@"Ok"
                          otherButtonTitles:nil] show];
    }
}

@end
