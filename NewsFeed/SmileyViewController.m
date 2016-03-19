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
@property (nonatomic, weak) IBOutlet UILabel *lblSmiley;
@end

@implementation SmileyViewController
#pragma mark - UpdateUI
- (void) updateUI {
    self.title = @"Smiley";
    //We can get more smileys. ctrl + command + space shortcut.
    self.lblSmiley.text = @"😄😄😄😄😄";
}

#pragma mark - View Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self updateUI];
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