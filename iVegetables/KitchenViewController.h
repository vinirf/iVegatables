//
//  KitchenViewController.h
//  iVegetables
//
//  Created by VINICIUS RESENDE FIALHO on 16/04/14.
//  Copyright (c) 2014 Vinicius Resende Fialho. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KitchenViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *campBusca;
- (IBAction)botaoPesquisar:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *listRceitas;

@end
