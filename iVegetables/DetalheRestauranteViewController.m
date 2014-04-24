//
//  DetalheRestauranteViewController.m
//  iVegetables
//
//  Created by EMERSON DE SOUZA BARROS on 17/04/14.
//  Copyright (c) 2014 Vinicius Resende Fialho. All rights reserved.
//


#import "DetalheRestauranteViewController.h"
#import "AuxCoordenadaVegetariano.h"

@interface DetalheRestauranteViewController ()

@end

@implementation DetalheRestauranteViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.coordenadaShared = [AuxCoordenadaVegetariano sharedManager].coordenada;
   
    self.lblNota.text = [NSString stringWithFormat:@"%.1f", [self.coordenadaShared.nota doubleValue]];
    self.lblNome.text = self.coordenadaShared.nomeLugar;
    self.lblRua.text = self.coordenadaShared.rua;
    self.lblTelefone.text = self.coordenadaShared.telefone;
    self.lblSite.text = self.coordenadaShared.site;
    
    
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
