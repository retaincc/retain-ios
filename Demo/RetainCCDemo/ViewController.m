//
//  ViewController.m
//  RetainCCDemo
//
//  Created by b123400 on 13/10/14.
//  Copyright (c) 2014 oursky. All rights reserved.
//

#import "ViewController.h"
#import <RetainCC/RetainCC.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)orangeButtonTapped:(id)sender {
    [[RetainCC shared] logEventWithName:@"button_tapped" properties:@{
                                                                      @"color":@"orange"
                                                                      }];
}

- (IBAction)blueButtonTapped:(id)sender {
    [[RetainCC shared] logEventWithName:@"button_tapped" properties:@{
                                                                      @"color":@"blue"
                                                                      }];
}

@end
