//
//  AuxWebNoticia.h
//  iVegetables
//
//  Created by VINICIUS RESENDE FIALHO on 17/04/14.
//  Copyright (c) 2014 Vinicius Resende Fialho. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AuxWebNoticia : NSObject

+(AuxWebNoticia*)sharedManager;

@property NSString *link;

@end
