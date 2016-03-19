//
//  SmileyViewController.m
//  NewsFeed
//
//  Created by Hemang Shah on 19/03/16.
//  Copyright (c) 2016 Hemang Shah. All rights reserved.
//

#import "SmileyViewController.h"

@interface SmileyViewController ()
- (IBAction)actionDismiss:(id)sender;
@end

@implementation SmileyViewController
#pragma mark - View Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions
- (IBAction)actionDismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end