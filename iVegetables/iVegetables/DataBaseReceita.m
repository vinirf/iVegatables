//
//  DataBaseReceita.m
//  iVegetables
//
//  Created by VINICIUS RESENDE FIALHO on 24/04/14.
//  Copyright (c) 2014 Vinicius Resende Fialho. All rights reserved.
//

#import "DataBaseReceita.h"

@implementation DataBaseReceita

+(DataBaseReceita*)sharedManager{
    static DataBaseReceita *unicoDataCoord = nil;
    if(!unicoDataCoord){
        unicoDataCoord = [[super allocWithZone:nil]init];
    }
    return unicoDataCoord;
}

-(id)init{
    self = [super init];
    if(self){
        self.listaReceitas= [[NSMutableArray alloc]init];
        
    }
    return self;
}

+(id)allocWithZone:(struct _NSZone *)zone{
    return [self sharedManager];
}

-(void)AddReceita:(Receita *)rect{
    [[[DataBaseReceita sharedManager]listaReceitas]addObject:rect];
    
}


@end
