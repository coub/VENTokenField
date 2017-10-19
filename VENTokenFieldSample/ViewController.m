//
//  ViewController.m
//  VENTokenFieldSample
//
//  Created by Ayaka Nonaka on 6/20/14.
//  Copyright (c) 2014 Venmo. All rights reserved.
//

#import "ViewController.h"
#import "VENTokenField.h"

@interface ViewController () <VENTokenFieldDelegate, VENTokenFieldDataSource>
@property (weak, nonatomic) IBOutlet VENTokenField *tokenField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tokenFieldHeight;
@property (strong, nonatomic) NSMutableArray *names;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.names = [NSMutableArray array];
    self.tokenField.delegate = self;
    self.tokenField.dataSource = self;
    self.tokenField.placeholderText = @"";
    self.tokenField.toLabelText = NSLocalizedString(@"To:", nil);
    self.tokenField.toLabelTextColor = [UIColor blackColor];
    self.tokenField.delimiters = @[@",", @";", @"--"];
    [self.tokenField becomeFirstResponder];
}

- (IBAction)didTapCollapseButton:(id)sender
{
    [self.tokenField collapse];
}

- (IBAction)didTapResignFirstResponderButton:(id)sender
{
    [self.tokenField resignFirstResponder];
}


#pragma mark - VENTokenFieldDelegate

- (void)tokenField:(VENTokenField *)tokenField didEnterText:(NSString *)text
{
    [self.names addObject:text];
    [self.tokenField reloadData];
}

- (void)tokenField:(VENTokenField *)tokenField didDeleteTokenAtIndex:(NSUInteger)index
{
    [self.names removeObjectAtIndex:index];
    [self.tokenField reloadData];
}


#pragma mark - VENTokenFieldDataSource

- (void)tokenField:(VENTokenField *)tokenField didChangeContentHeight:(CGFloat)height
{
    self.tokenFieldHeight.constant = height;
}

- (NSString *)tokenField:(VENTokenField *)tokenField titleForTokenAtIndex:(NSUInteger)index
{
    return self.names[index];
}

- (NSUInteger)numberOfTokensInTokenField:(VENTokenField *)tokenField
{
    return [self.names count];
}

- (NSString *)tokenFieldCollapsedText:(VENTokenField *)tokenField
{
    return [NSString stringWithFormat:@"%tu people", [self.names count]];
}

@end
