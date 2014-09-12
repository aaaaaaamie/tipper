//
//  TipViewController.m
//  TipCalculator
//
//  Created by Ying Yang on 9/12/14.
//  Copyright (c) 2014 Ying Yang. All rights reserved.
//

#import "TipViewController.h"
#import "SettingsViewController.h"

@interface TipViewController ()
@property (weak, nonatomic) IBOutlet UITextField *billAmountTxt;
@property (weak, nonatomic) IBOutlet UILabel *tipAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalAmountLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipPercentControl;
- (IBAction)onInputChange:(id)sender;

- (IBAction)onTapOnRestOfScreen:(id)sender;
- (IBAction)onTapTipControl:(id)sender;
@end

@implementation TipViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"YinYangTwin Tipper";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    // default set of tip percentages
    NSArray *tipPercentage = @[@(10), @(15), @(20)];
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"customPercentages"] != nil) {
        tipPercentage = [defaults objectForKey:@"customPercentages"];
    }
    
    for (int i = 0; i < tipPercentage.count; i++) {
        [self.tipPercentControl setTitle:[NSString stringWithFormat:@"%@%%", tipPercentage[i]] forSegmentAtIndex:i];
    }
    
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onTapSettingsButton)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// navigate to the settings view
- (void)onTapSettingsButton {
    [self.navigationController pushViewController:[[SettingsViewController alloc] init] animated:YES];
}

// immediately dismiss the keypad and update the tip and total amounts
- (IBAction)onTapTipControl:(id)sender {
    // calculation only happens when there's actual amount entered
    if ([self.billAmountTxt.text floatValue] != 0) {
        [self updateAmountLabels];
    }
}

- (IBAction)onInputChange:(id)sender {
    [self updateAmountLabels];
}


// for dismissing the keypad when user tap on anywhere on the screen except for the tip percentage control
- (IBAction)onTapOnRestOfScreen:(id)sender {
    [self.view endEditing:YES];
}

// actually implementation of the tip calculation
- (void)updateAmountLabels {
    //future implementation:
    // validate the bill amount
    float billAmount = [self.billAmountTxt.text floatValue];
    float tipPercentage = 0;
    
    if (self.tipPercentControl.selectedSegmentIndex != -1) {
        NSString *percentageString = [self.tipPercentControl titleForSegmentAtIndex:[self.tipPercentControl selectedSegmentIndex]];
        tipPercentage = [[percentageString substringToIndex:percentageString.length - 1] floatValue] / 100;
    }
    
    float tipAmount = billAmount * tipPercentage;
    self.tipAmountLabel.text = [NSString stringWithFormat:@"$%0.2f", tipAmount];
    self.totalAmountLabel.text = [NSString stringWithFormat:@"$%0.2f", billAmount + tipAmount];
}

@end
