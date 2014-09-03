//
//  SettingsViewController.h
//  PitStop
//
//  Created by Hriday Kemburu on 9/2/14.
//  Copyright (c) 2014 Hriday Kemburu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UIButton *fbLogoutButton;
- (IBAction)logout:(id)sender;


@end
