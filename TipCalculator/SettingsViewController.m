//
//  SettingsViewController.m
//  TipCalculator
//
//  Created by Ying Yang on 9/12/14.
//  Copyright (c) 2014 Ying Yang. All rights reserved.
//

#import "SettingsViewController.h"
#import "TipViewController.h"

@interface SettingsViewController ()
- (IBAction)onTapScreen:(id)sender;

@property (weak, nonatomic) IBOutlet UIStepper *Stepper1Outlet;
@property (weak, nonatomic) IBOutlet UILabel *Stepper1Label;
- (IBAction)Stepper1OnClick:(id)sender;

@property (weak, nonatomic) IBOutlet UIStepper *Stepper2Outlet;
@property (weak, nonatomic) IBOutlet UILabel *Stepper2Label;
- (IBAction)Stepper2OnClick:(id)sender;

@property (weak, nonatomic) IBOutlet UIStepper *Stepper3Outlet;
@property (weak, nonatomic) IBOutlet UILabel *Stepper3Label;
- (IBAction)Stepper3OnClick:(id)sender;
@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Tipper Settings";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *tipPercentage = @[@(10), @(15), @(20)];
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"customPercentages"] != nil) {
        tipPercentage = [defaults objectForKey:@"customPercentages"];
    }
    
    self.Stepper1Outlet.value = [tipPercentage[0] floatValue];
    self.Stepper1Label.text = [NSString stringWithFormat:@"%0.0f", self.Stepper1Outlet.value];
    
    
    self.Stepper2Outlet.value = [tipPercentage[1] floatValue];
    self.Stepper2Label.text = [NSString stringWithFormat:@"%0.0f", self.Stepper2Outlet.value];
    
    
    self.Stepper3Outlet.value = [tipPercentage[2] floatValue];
    self.Stepper3Label.text = [NSString stringWithFormat:@"%0.0f", self.Stepper3Outlet.value];
    
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(onTapDoneButton)];
}


// navigate back to the tip calculator view
- (void)onTapDoneButton {
    NSArray *tipPercentage = @[@([self.Stepper1Label.text floatValue]), @([self.Stepper2Label.text floatValue]), @([self.Stepper3Label.text floatValue])];
    
    // save the custom default tip percentage
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:tipPercentage forKey:@"customPercentages"];
    [defaults synchronize];
    
    [self.navigationController pushViewController:[[TipViewController alloc] init] animated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTapScreen:(id)sender {
    [self.view endEditing:YES];
}

// future task: find a way to get rid of the redundancy
- (IBAction)Stepper1OnClick:(id)sender {
    self.Stepper1Label.text = [NSString stringWithFormat:@"%0.0f",self.Stepper1Outlet.value];
}

- (IBAction)Stepper2OnClick:(id)sender {
    self.Stepper2Label.text = [NSString stringWithFormat:@"%0.0f",self.Stepper2Outlet.value];
}

- (IBAction)Stepper3OnClick:(id)sender {
    self.Stepper3Label.text = [NSString stringWithFormat:@"%0.0f",self.Stepper3Outlet.value];
}
@end
;