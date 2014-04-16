//
//  DateBaseCoordenadaVegetariano.m
//  iVegetables
//
//  Created by VINICIUS RESENDE FIALHO on 15/04/14.
//  Copyright (c) 2014 Vinicius Resende Fialho. All rights reserved.
//

#import "DateBaseCoordenadaVegetariano.h"

@implementation DateBaseCoordenadaVegetariano

+(DateBaseCoordenadaVegetariano*)sharedManager{
    static DateBaseCoordenadaVegetariano *unicoDataCoord = nil;
    if(!unicoDataCoord){
        unicoDataCoord = [[super allocWithZone:nil]init];
    }
    return unicoDataCoord;
}

-(id)init{
    self = [super init];
    if(self){
        self.listaCoordenadasVegetarianos= [[NSMutableArray alloc]init];
        
    }
    return self;
}

+(id)allocWithZone:(struct _NSZone *)zone{
    return [self sharedManager];
}

-(void)AddCoordenada:(CoordenadaVegetariano *)coord{
    [[[DateBaseCoordenadaVegetariano sharedManager] listaCoordenadasVegetarianos]addObject:coord];
    
}

@end
