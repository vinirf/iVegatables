//
//  AuxCoordenadaVegetariano.m
//  iVegetables
//
//  Created by EMERSON DE SOUZA BARROS on 24/04/14.
//  Copyright (c) 2014 Vinicius Resende Fialho. All rights reserved.
//

#import "AuxCoordenadaVegetariano.h"

@implementation AuxCoordenadaVegetariano

+(AuxCoordenadaVegetariano*)sharedManager{
    static AuxCoordenadaVegetariano *unicoDataCoord = nil;
    if(!unicoDataCoord){
        unicoDataCoord = [[super allocWithZone:nil]init];
    }
    return unicoDataCoord;
}

-(id)init{
    self = [super init];
    if(self){
        
    }
    return self;
}

+(id)allocWithZone:(struct _NSZone *)zone{
    return [self sharedManager];
}


@end
