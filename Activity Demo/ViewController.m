//
//  ViewController.m
//  Activity Demo
//
//  Created by Jay Versluis on 17/10/2015.
//  Copyright © 2015 Pinkstone Pictures LLC. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIStackView *stackView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // hide left bar button item if we're on an iPhone
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
        self.navigationItem.leftBarButtonItem = nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createButtons {
    
    // image sharing button
    
}

# pragma mark - Sharing Methods

- (IBAction)shareImageDefault:(id)sender {
    
    // grab an item we want to share
    UIImage *image = [UIImage imageNamed:@"three"];
    NSArray *items = @[image];
    
    // build an activity view controller
    UIActivityViewController *controller = [[UIActivityViewController alloc]initWithActivityItems:items applicationActivities:nil];
    
    // and present it
    [self presentActivityController:controller];
}

- (IBAction)shareImageExcludeSocial:(id)sender {
    
    // grab an item we want to share
    UIImage *image = [UIImage imageNamed:@"three"];
    NSArray *items = @[image];
    
    // build an activity view controller
    UIActivityViewController *controller = [[UIActivityViewController alloc]initWithActivityItems:items applicationActivities:nil];
    
    // exclude several items (for example, Facepuke and Shitter)
    NSArray *excluded = @[UIActivityTypePostToFacebook, UIActivityTypePostToTwitter];
    controller.excludedActivityTypes = excluded;
    
    // and present it
    [self presentActivityController:controller];
}

- (IBAction)shareExcludeActions:(id)sender {
    
    // grab an item we want to share
    UIImage *image = [UIImage imageNamed:@"three"];
    NSArray *items = @[image];
    
    // build an activity view controller
    UIActivityViewController *controller = [[UIActivityViewController alloc]initWithActivityItems:items applicationActivities:nil];
    
    // exclude several items (for example, Facepuke and Shitter)
    NSArray *excluded = @[UIActivityTypePrint, UIActivityTypeSaveToCameraRoll, UIActivityTypeAirDrop, UIActivityTypeAddToReadingList];
    controller.excludedActivityTypes = excluded;
    
    // and present it
    [self presentActivityController:controller];
}

- (IBAction)shareText:(id)sender {
    
    // create a message
    NSString *theMessage = @"Some text we're sharing with an activity controller";
    NSArray *items = @[theMessage];
    
    // build an activity view controller
    UIActivityViewController *controller = [[UIActivityViewController alloc]initWithActivityItems:items applicationActivities:nil];
    
    // and present it
    [self presentActivityController:controller];
}

- (void)presentActivityController:(UIActivityViewController *)controller {
    
    // for iPad: make the presentation a Popover
    controller.modalPresentationStyle = UIModalPresentationPopover;
    [self presentViewController:controller animated:YES completion:nil];
    
    UIPopoverPresentationController *popController = [controller popoverPresentationController];
    popController.permittedArrowDirections = UIPopoverArrowDirectionAny;
    popController.barButtonItem = self.navigationItem.leftBarButtonItem;
    
    // access the completion handler
    controller.completionWithItemsHandler = ^(NSString *activityType,
                                              BOOL completed,
                                              NSArray *returnedItems,
                                              NSError *error){
        // react to the completion
        if (completed) {
            
            // user shared an item
            NSLog(@"We used activity type%@", activityType);
            
        } else {
            
            // user cancelled
            NSLog(@"We didn't want to share anything after all.");
        }
        
        if (error) {
            NSLog(@"An Error occured: %@, %@", error.localizedDescription, error.localizedFailureReason);
        }
    };
}

@end
