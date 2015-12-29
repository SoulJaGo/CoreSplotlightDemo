//
//  AppDelegate.m
//  CoreSpotlightDemo
//
//  Created by SoulJa on 15/12/29.
//  Copyright © 2015年 SoulJa. All rights reserved.
//

#import "AppDelegate.h"
#import <CoreSpotlight/CoreSpotlight.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self saveData];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray * _Nullable))restorationHandler {
    NSString *idetifier = userActivity.userInfo[@"kCSSearchableItemActivityIdentifier"];
    NSLog(@"%@",idetifier);
    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"ImageViewController"];
    [navigationController pushViewController:vc animated:YES];
    
    return YES;
}


- (void)saveData {
    NSMutableArray *searchableItems = [NSMutableArray array];
    CSSearchableItemAttributeSet *attributeSet = [[CSSearchableItemAttributeSet alloc] initWithItemContentType:@"views"];
    attributeSet.title = @"Image";
    attributeSet.contentDescription = @"A easy way to open Image";
    UIImage *image = [UIImage imageNamed:@"长泽雅美"];
    attributeSet.thumbnailData = UIImagePNGRepresentation(image);
    CSSearchableItem *item = [[CSSearchableItem alloc] initWithUniqueIdentifier:@"Image" domainIdentifier:@"com.meecaa.meecaasticktest" attributeSet:attributeSet];
    [searchableItems addObject:item];
    [[CSSearchableIndex defaultSearchableIndex] indexSearchableItems:searchableItems completionHandler:^(NSError * _Nullable error) {
        if (!error) {
            NSLog(@"%@",error.localizedDescription);
        } else {
            NSLog(@"%@",error);
        }
    }];
}
@end
