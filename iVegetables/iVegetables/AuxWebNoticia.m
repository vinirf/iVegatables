//
//  AuxWebNoticia.m
//  iVegetables
//
//  Created by VINICIUS RESENDE FIALHO on 17/04/14.
//  Copyright (c) 2014 Vinicius Resende Fialho. All rights reserved.
//

#import "AuxWebNoticia.h"

@implementation AuxWebNoticia

+(AuxWebNoticia*)sharedManager{
    static AuxWebNoticia *unicoDataCoord = nil;
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
