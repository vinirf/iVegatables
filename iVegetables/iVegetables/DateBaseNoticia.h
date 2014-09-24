//
//  DateBaseNoticia.h
//  iVegetables
//
//  Created by VINICIUS RESENDE FIALHO on 16/04/14.
//  Copyright (c) 2014 Vinicius Resende Fialho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Noticia.h"

@interface DateBaseNoticia : NSObject

@property NSMutableArray *listaNoticias;

+(DateBaseNoticia*)sharedManager;

-(void)AddNoticia:(Noticia *)news;



@end
