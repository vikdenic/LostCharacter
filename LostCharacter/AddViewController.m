//
//  AddViewController.m
//  LostCharacter
//
//  Created by Vik Denic on 6/3/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "AddViewController.h"

@interface AddViewController ()
@property (weak, nonatomic) IBOutlet UITextField *actorNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *lostNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *hometownLabel;

@property (weak, nonatomic) IBOutlet UITextField *ageLabel;
@property (weak, nonatomic) IBOutlet UITextField *seatLabel;
@property (weak, nonatomic) IBOutlet UITextField *purposeLabel;

@end

@implementation AddViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)onAddButtonPressed:(id)sender {

    NSManagedObject *character = [NSEntityDescription insertNewObjectForEntityForName:@"Character" inManagedObjectContext:self.managedObjectContext];

    NSString *actor = self.actorNameLabel.text;
    NSString *passenger = self.lostNameLabel.text;
    NSString *hometown = self.hometownLabel.text;

    int ageInt = [self.ageLabel.text intValue];
    NSNumber *age = [NSNumber numberWithInt:ageInt];

    NSString *seat = self.seatLabel.text;
    NSString *purpose = self.purposeLabel.text;

    [character setValue:actor forKeyPath:@"actor"];
    [character setValue:passenger forKeyPath:@"passenger"];
    [character setValue:hometown forKeyPath:@"hometown"];
    [character setValue:age forKeyPath:@"age"];
    [character setValue:seat forKeyPath:@"seat"];
    [character setValue:purpose forKeyPath:@"purpose"];

    [self.actorNameLabel resignFirstResponder];
    [self.lostNameLabel resignFirstResponder];
    [self.hometownLabel resignFirstResponder];
    [self.ageLabel resignFirstResponder];
    [self.seatLabel resignFirstResponder];
    [self.purposeLabel resignFirstResponder];
}

@end
