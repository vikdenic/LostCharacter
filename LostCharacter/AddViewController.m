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

    [character setValue:actor forKeyPath:@"actor"];
    [character setValue:passenger forKeyPath:@"passenger"];
}

@end
