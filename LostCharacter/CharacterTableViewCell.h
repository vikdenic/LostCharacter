//
//  CharacterTableViewCell.h
//  LostCharacter
//
//  Created by Vik Denic on 6/3/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CharacterTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *actorCellLabel;
@property (weak, nonatomic) IBOutlet UILabel *passengerCellLabel;
@property (weak, nonatomic) IBOutlet UILabel *hometownCellLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageCellLabel;
@property (weak, nonatomic) IBOutlet UILabel *seatCellLabel;
@property (weak, nonatomic) IBOutlet UILabel *purposeCellLabel;

@end
