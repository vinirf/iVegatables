//
//  DataBaseReceita.h
//  iVegetables
//
//  Created by VINICIUS RESENDE FIALHO on 24/04/14.
//  Copyright (c) 2014 Vinicius Resende Fialho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Receita.h"


@interface DataBaseReceita : NSObject

@property NSMutableArray *listaReceitas;

+(DataBaseReceita*)sharedManager;

-(void)AddReceita:(Receita *)rect;




@end
