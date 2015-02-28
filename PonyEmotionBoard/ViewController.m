//
//  ViewController.m
//  PonyEmotionBoard
//
//  Created by 崔 明辉 on 15-2-23.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "ViewController.h"
#import "PEBApplication.h"

@interface ViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) IBOutlet UILabel *outputLabel;

@property (nonatomic, strong) PEBKeyboardViewController *keyboardViewController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.keyboardViewController = [[PEBApplication sharedInstance] addKeyboardViewControllerToViewController:self
                                                                                               withTextField:self.textField];
    self.textField.delegate = self;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)handleEmotionButtonTapped:(id)sender {
    [self.textField resignFirstResponder];
    [self.keyboardViewController setIsPresenting:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    self.outputLabel.text = self.textField.text;
    self.outputLabel.attributedText = [[PEBApplication sharedInstance]
                                       emotionAttributedStringWithString:self.textField.text];
    self.textField.text = @"";
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self.keyboardViewController setIsPresenting:NO];
}

@end
