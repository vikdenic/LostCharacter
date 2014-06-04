//
//  DetailViewController.h
//  LostCharacter
//
//  Created by Vik Denic on 6/3/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
