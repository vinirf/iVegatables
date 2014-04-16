//
//  CoordenadaVegetariano.h
//  iVegetables
//
//  Created by VINICIUS RESENDE FIALHO on 15/04/14.
//  Copyright (c) 2014 Vinicius Resende Fialho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface CoordenadaVegetariano : MKPointAnnotation {
    
}

@property NSString *nomeLugar;
@property NSString *telefone;
@property NSString *rua;
@property NSString *ruaComplemento;
@property float pontoLatitude;
@property float pontoLongitude;
@property NSString *distancia;
@property NSString *cep;
@property NSString *siglaPais;
@property NSString *cidade;
@property NSString *estado;
@property NSString *pais;
@property NSString *site;
@property NSString *numeroChecking;
@property NSString *totalFrequentadores;
@property NSString *estadoPreco;
@property NSString *qtEstadoPreco;
@property NSString *nota;
@property NSString *nomeUsuario;
@property NSString *comentario;
@property NSString *icone;
@property NSString *horarioFuncionamento;


@end
