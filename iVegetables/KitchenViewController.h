//
//  KitchenViewController.h
//  iVegetables
//
//  Created by VINICIUS RESENDE FIALHO on 16/04/14.
//  Copyright (c) 2014 Vinicius Resende Fialho. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KitchenViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate> {
    UIImageView *imgView ;
    UILabel *fromLabel;
}

@property (weak, nonatomic) IBOutlet UITextField *campBusca;
- (IBAction)botaoPesquisar:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *listRceitas;

@property NSString *stringDeBusca;
@property int auxStringBusca;

@property float valorDeslocamento;
@property (weak, nonatomic) IBOutlet UIImageView *imgColher;

@end
