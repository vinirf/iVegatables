//
//  ReceitaGuardada.h
//  iVegetables
//
//  Created by Vinicius Resende Fialho on 29/04/14.
//  Copyright (c) 2014 Vinicius Resende Fialho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ReceitaGuardada : NSManagedObject

@property (nonatomic, retain) NSString * img;
@property (nonatomic, retain) NSString * nome;
@property (nonatomic, retain) NSString * subLink;
@property (nonatomic, retain) NSString * img2x;
@property (nonatomic, retain) NSString * tempoPreparo;
@property (nonatomic, retain) NSString * tempoCozimento;
@property (nonatomic, retain) NSString * nivel;
@property (nonatomic, retain) NSString * rendimento;
@property (nonatomic, retain) NSString * htmlModoPreparo;

@end
