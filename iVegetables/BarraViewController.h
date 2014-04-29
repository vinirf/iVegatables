//
//  BarraViewController.h
//  iVegetables
//
//  Created by VINICIUS RESENDE FIALHO on 16/04/14.
//  Copyright (c) 2014 Vinicius Resende Fialho. All rights reserved.
//

#import "ViewController.h"
#import "ContainerViewController.h"

@interface BarraViewController : ViewController {
    
}

@property (weak, nonatomic) IBOutlet UIView *viewInicial;


@property (weak, nonatomic) IBOutlet UIView *containerViews;

@property ContainerViewController *containerViewController;

- (IBAction)buttonMap:(id)sender;
- (IBAction)buttonFeed:(id)sender;
- (IBAction)buttonCozinha:(id)sender;

@end
