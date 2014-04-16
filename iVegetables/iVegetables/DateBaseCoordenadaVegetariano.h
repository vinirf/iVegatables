//
//  DateBaseCoordenadaVegetariano.h
//  iVegetables
//
//  Created by VINICIUS RESENDE FIALHO on 15/04/14.
//  Copyright (c) 2014 Vinicius Resende Fialho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoordenadaVegetariano.h"

@interface DateBaseCoordenadaVegetariano : NSObject{
    
}

@property NSMutableArray *listaCoordenadasVegetarianos;

+(DateBaseCoordenadaVegetariano*)sharedManager;

-(void)AddCoordenada:(CoordenadaVegetariano *)coord;




@end
