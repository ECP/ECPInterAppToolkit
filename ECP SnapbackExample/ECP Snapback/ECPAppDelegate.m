//
//  ECPAppDelegate.m
//  ECP Snapback
//
//  Created by Steve Troppoli on 12/12/13.
//  Copyright (c) 2013 East Coast Pixels, Inc. All rights reserved.
//

#import "ECPAppDelegate.h"
#import "ECPTestViewController.h"
#import "IACManager.h"

@implementation ECPAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [IACManager sharedManager].callbackURLScheme = @"ecpsnapback-x-callback";	// this must match a registered callback in your info.plist

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
	self.window.rootViewController = [[ECPTestViewController alloc] initWithNibName:nil bundle:nil];
    [self.window makeKeyAndVisible];
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [[IACManager sharedManager] handleOpenURL:url];
}

@end
