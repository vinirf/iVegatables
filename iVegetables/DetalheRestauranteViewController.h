//
//  DetalheRestauranteViewController.h
//  iVegetables
//
//  Created by EMERSON DE SOUZA BARROS on 17/04/14.
//  Copyright (c) 2014 Vinicius Resende Fialho. All rights reserved.
//

#import "CoordenadaVegetariano.h"
#import <UIKit/UIKit.h>

@interface DetalheRestauranteViewController : UIViewController

@property CoordenadaVegetariano *coordenadaShared;

@property (weak, nonatomic) IBOutlet UILabel *lblNota;
@property (weak, nonatomic) IBOutlet UILabel *lblNome;
@property (weak, nonatomic) IBOutlet UILabel *lblRua;
@property (weak, nonatomic) IBOutlet UILabel *lblTelefone;
@property (weak, nonatomic) IBOutlet UILabel *lblSite;


@end
