//
//  InicialViewController.m
//  iVegetables
//
//  Created by Vinicius Resende Fialho on 29/04/14.
//  Copyright (c) 2014 Vinicius Resende Fialho. All rights reserved.
//

#import "InicialViewController.h"
#import "ContainerViewController.h"
#import "BarraViewController.h"

@interface InicialViewController ()

@end

@implementation InicialViewController

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
    
    CABasicAnimation* fadeAnim = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeAnim.fromValue = [NSNumber numberWithFloat:0.0];
    fadeAnim.toValue = [NSNumber numberWithFloat:1.0];
    fadeAnim.duration = 3.0;
    [self.view.layer addAnimation:fadeAnim forKey:@"opacity"];
    
//    UIStoryboard *storyboard = self.storyboard;
//    BarraViewController *svc = [storyboard instantiateViewControllerWithIdentifier:@"embedInicial"];
//    [self presentViewController:svc animated:YES completion:nil];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"BarraViewController" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"embedInicial"];
    [[[[UIApplication sharedApplication] delegate] window] setRootViewController:vc];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
   
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
