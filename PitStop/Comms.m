//
//  Comms.m
//  PitStop
//
//  Created by Hriday Kemburu on 9/2/14.
//  Copyright (c) 2014 Hriday Kemburu. All rights reserved.
//

#import "Comms.h"

@implementation Comms

+ (void) login:(id<CommsDelegate>)delegate
{
    // Basic User information and your friends are part of the standard permissions
    // so there is no reason to ask for additional permissions
    [PFFacebookUtils logInWithPermissions:nil block:^(PFUser *user, NSError *error) {
        // Was login successful ?
        if (!user) {
            if (!error) {
                NSLog(@"The user cancelled the Facebook login.");
            } else {
                NSLog(@"An error occurred: %@", error.localizedDescription);
            }
            
            // Callback - login failed
            if ([delegate respondsToSelector:@selector(commsDidLogin:)]) {
                [delegate commsDidLogin:NO];
            }
        } else {
            if (user.isNew) {
                NSLog(@"User signed up and logged in through Facebook!");
            } else {
                NSLog(@"User logged in through Facebook!");
            }
            
            // Callback - login successful
            [FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                if (!error) {
                    NSDictionary<FBGraphUser> *me = (NSDictionary<FBGraphUser> *)result;
                    // Store the Facebook Id
                    [[PFUser currentUser] setObject:me.id forKey:@"fbId"];
                    [[PFUser currentUser] saveInBackground];
                }
                
                // Callback - login successful
                if ([delegate respondsToSelector:@selector(commsDidLogin:)]) {
                    [delegate commsDidLogin:YES];
                }
            }];
        }
    }];
}

@end
