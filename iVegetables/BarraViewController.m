//
//  BarraViewController.m
//  iVegetables
//
//  Created by VINICIUS RESENDE FIALHO on 16/04/14.
//  Copyright (c) 2014 Vinicius Resende Fialho. All rights reserved.
//

#import "BarraViewController.h"
#import "ViewController.h"
#import "ContainerViewController.h"

@interface BarraViewController ()

@end

@implementation BarraViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)buttonMap:(id)sender {
    [self.containerViewController chamaMapaViewController];
}

- (IBAction)buttonFeed:(id)sender {
    [self.containerViewController chamaFeedViewController];
}

- (IBAction)buttonCozinha:(id)sender {
    [self.containerViewController chamaCozinhaViewController];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"embedContainer"]) {
        self.containerViewController = segue.destinationViewController;
    }
}



@end
