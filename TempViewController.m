//
//  TempViewController.m
//  its-getting-hot-in-here
//
//  Created by Jerry Reptak on 1/12/14.
//  Copyright (c) 2014 Jerry Reptak. All rights reserved.
//

#import "TempViewController.h"

@interface TempViewController ()

@property (weak, nonatomic) IBOutlet UITextField *fahrTextField;
@property (weak, nonatomic) IBOutlet UITextField *celcTextField;

- (IBAction)onTempChange:(id)sender;

@end

@implementation TempViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSNumber*)fahrToCelc:(NSNumber *)fahrTemp {
    float fahr = [fahrTemp floatValue];
    return @((fahr - 32) * 5 / 9);
}

- (NSNumber*)celcToFahr:(NSNumber *)celcTemp {
    float celc = [celcTemp floatValue];
    return @((celc * 9 / 5) + 32);
}

- (IBAction)onTempChange:(id)sender {
    NSNumberFormatter * nf = [[NSNumberFormatter alloc] init];
    [nf setNumberStyle:NSNumberFormatterDecimalStyle];
    
    SEL conversionSelector;
    
    UITextField *fromField, *toField;
    
    if (sender == self.fahrTextField) {
        conversionSelector = NSSelectorFromString(@"fahrToCelc:");
        fromField = self.fahrTextField;
        toField = self.celcTextField;
    } else if (sender == self.celcTextField) {
        conversionSelector = NSSelectorFromString(@"celcToFahr:");
        fromField = self.celcTextField;
        toField = self.fahrTextField;
    } else {
        return;
    }
    
    NSNumber *convTemp = [self performSelector:conversionSelector withObject:[nf numberFromString:fromField.text]];
    
    [nf setMaximumFractionDigits:2];
    
    toField.text = [nf stringFromNumber:convTemp];
}
@end
