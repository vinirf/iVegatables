//
//  DetalheRestauranteViewController.h
//  iVegetables
//
//  Created by EMERSON DE SOUZA BARROS on 17/04/14.
//  Copyright (c) 2014 Vinicius Resende Fialho. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "CoordenadaVegetariano.h"
#import <MapKit/MapKit.h>

@interface DetalheRestauranteViewController : UIViewController <MKMapViewDelegate>

@property CoordenadaVegetariano *coordenadaShared;

@property (weak, nonatomic) IBOutlet UIImageView *imgLugar;
@property (weak, nonatomic) IBOutlet UILabel *lblNota;
@property (weak, nonatomic) IBOutlet UILabel *lblNome;
@property (weak, nonatomic) IBOutlet UILabel *lblRua;
@property (weak, nonatomic) IBOutlet UILabel *lblTelefone;
@property (weak, nonatomic) IBOutlet UILabel *lblSite;
@property (weak, nonatomic) IBOutlet UILabel *lblDistancia;
@property (weak, nonatomic) IBOutlet UILabel *lblRuaComplemento;
@property (weak, nonatomic) IBOutlet UILabel *lblDescricaoLugar;
@property (weak, nonatomic) IBOutlet UILabel *lblNumeroCheck;
@property (weak, nonatomic) IBOutlet UILabel *lblFreq;
@property (weak, nonatomic) IBOutlet UILabel *lblComentario;
@property (weak, nonatomic) IBOutlet UILabel *lblAutor;
@property (weak, nonatomic) IBOutlet UILabel *lblEstadoPreco;
@property (weak, nonatomic) IBOutlet UILabel *lblHorario;


@property (weak, nonatomic) IBOutlet MKMapView *mapaDetalhes;

@end
