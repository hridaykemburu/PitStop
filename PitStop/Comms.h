//
//  Comms.h
//  PitStop
//
//  Created by Hriday Kemburu on 9/2/14.
//  Copyright (c) 2014 Hriday Kemburu. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CommsDelegate <NSObject>
@optional
- (void) commsDidLogin:(BOOL)loggedIn;
@end

@interface Comms : NSObject
+ (void) login:(id<CommsDelegate>)delegate;
@end
