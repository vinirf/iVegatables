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
   
    NSLog(@"string");
    
    CABasicAnimation* fadeAnim = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeAnim.fromValue = [NSNumber numberWithFloat:0.0];
    fadeAnim.toValue = [NSNumber numberWithFloat:1.0];
    fadeAnim.duration = 3.0;
    [self.view.layer addAnimation:fadeAnim forKey:@"opacity"];
    
    [NSTimer scheduledTimerWithTimeInterval:8.0 target:self selector:@selector(fadeOut) userInfo:nil repeats:NO];
    
}

-(void)tiraTelaInicial{
    self.viewInicial.hidden = YES;
}

-(void)fadeOut{
    CABasicAnimation* fadeAnim = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeAnim.fromValue = [NSNumber numberWithFloat:1.0];
    fadeAnim.toValue = [NSNumber numberWithFloat:0.0];
    fadeAnim.duration = 3.0;
    [self.view.layer addAnimation:fadeAnim forKey:@"opacity"];
    
    [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(tiraTelaInicial) userInfo:nil repeats:NO];
    
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
