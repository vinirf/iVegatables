//
//  FeedViewController.h
//  iVegetables
//
//  Created by VINICIUS RESENDE FIALHO on 16/04/14.
//  Copyright (c) 2014 Vinicius Resende Fialho. All rights reserved.
//

#import "ViewController.h"

@interface FeedViewController : ViewController <UITableViewDataSource, UITableViewDelegate> {
    UIImageView *recipeImageView;
}


@property (weak, nonatomic) IBOutlet UITableView *newsTable;
@property BOOL estadoRepetir;


@end
