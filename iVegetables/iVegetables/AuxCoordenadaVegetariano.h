//
//  AuxCoordenadaVegetariano.h
//  iVegetables
//
//  Created by EMERSON DE SOUZA BARROS on 24/04/14.
//  Copyright (c) 2014 Vinicius Resende Fialho. All rights reserved.
//

#import "CoordenadaVegetariano.h"
#import <Foundation/Foundation.h>

@interface AuxCoordenadaVegetariano : NSObject

+(AuxCoordenadaVegetariano*)sharedManager;

@property CoordenadaVegetariano *coordenada;


@end
