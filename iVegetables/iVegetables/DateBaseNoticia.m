//
//  DateBaseNoticia.m
//  iVegetables
//
//  Created by VINICIUS RESENDE FIALHO on 16/04/14.
//  Copyright (c) 2014 Vinicius Resende Fialho. All rights reserved.
//

#import "DateBaseNoticia.h"

@implementation DateBaseNoticia

+(DateBaseNoticia*)sharedManager{
    static DateBaseNoticia *unicoDataCoord = nil;
    if(!unicoDataCoord){
        unicoDataCoord = [[super allocWithZone:nil]init];
    }
    return unicoDataCoord;
}

-(id)init{
    self = [super init];
    if(self){
        self.listaNoticias= [[NSMutableArray alloc]init];
        
    }
    return self;
}

+(id)allocWithZone:(struct _NSZone *)zone{
    return [self sharedManager];
}

-(void)AddNoticia:(Noticia *)news{
    [[[DateBaseNoticia sharedManager] listaNoticias]addObject:news];
    
}

@end
