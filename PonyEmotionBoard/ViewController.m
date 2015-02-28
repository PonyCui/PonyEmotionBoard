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
    [self.keyboardViewController setIsPresenting:YES];
    [self.textField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    self.outputLabel.text = self.textField.text;
    NSAttributedString *biggerText = [[NSAttributedString alloc]
                                      initWithString:self.textField.text
                                      attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:21.0]}];
    self.outputLabel.attributedText = [[PEBApplication sharedInstance]
                                       emotionAttributedStringWithAttributedString:biggerText];
//Try this
//    self.outputLabel.attributedText = [[PEBApplication sharedInstance]
//                                       emotionAttributedStringWithString:self.textField.text
//                                       referenceFont:self.textField.font];
    self.textField.text = @"";
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self.keyboardViewController setIsPresenting:NO];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
}

@end
