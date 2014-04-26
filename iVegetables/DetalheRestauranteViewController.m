//
//  DetalheRestauranteViewController.m
//  iVegetables
//
//  Created by EMERSON DE SOUZA BARROS on 17/04/14.
//  Copyright (c) 2014 Vinicius Resende Fialho. All rights reserved.
//


#import "DetalheRestauranteViewController.h"
#import "AuxCoordenadaVegetariano.h"

@interface DetalheRestauranteViewController ()

@end

@implementation DetalheRestauranteViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self.mapaDetalhes setDelegate:self];
    self.mapaDetalhes.showsUserLocation = YES;
    
    self.coordenadaShared = [AuxCoordenadaVegetariano sharedManager].coordenada;
   
    NSURL *url = [NSURL URLWithString:self.coordenadaShared.linkImagem];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *img = [[UIImage alloc] initWithData:data];
    self.imgLugar.image = img;
    
    self.lblNota.text = [NSString stringWithFormat:@"%.1f", [self.coordenadaShared.nota doubleValue]];
    self.lblNome.text = self.coordenadaShared.nomeLugar;
    self.lblRua.text = self.coordenadaShared.rua;
    self.lblTelefone.text = self.coordenadaShared.telefone;
    self.lblSite.text = self.coordenadaShared.site;
    self.lblRuaComplemento.text = self.coordenadaShared.ruaComplemento;
    self.lblDistancia.text = [NSString stringWithFormat:@"Distância até o local %0.2f Km", [self.coordenadaShared.distancia floatValue]/1000];
    self.lblComentario.text = self.coordenadaShared.comentario;
    self.lblAutor.text = self.coordenadaShared.nomeUsuario;
    self.lblEstadoPreco.text = self.coordenadaShared.estadoPreco;
    
    //self.lblNumeroCheck.text = self.coordenadaShared.numeroChecking;
    //self.lblFreq.text = self.coordenadaShared.totalFrequentadores;
    
    NSString *descricaoEndereco = [NSString stringWithFormat:@"%@ - %@, %@",self.coordenadaShared.cidade,self.coordenadaShared.estado,self.coordenadaShared.cep];
    self.lblDescricaoLugar.text = descricaoEndereco;
    
    
    //Notas
    UIImageView *alface1 = (UIImageView *)[self.view viewWithTag: 1];
    UIImageView *alface2 = (UIImageView *)[self.view viewWithTag: 2];
    UIImageView *alface3 = (UIImageView *)[self.view viewWithTag: 3];
    UIImageView *alface4 = (UIImageView *)[self.view viewWithTag: 4];
    
   
    
    switch ([self.coordenadaShared.qtEstadoPreco integerValue]) {
        case 1:
            alface1.alpha = 1;
            break;
        case 2:
            alface1.alpha = 1;
            alface2.alpha = 1;
            break;
        case 3:
            alface1.alpha = 1;
            alface2.alpha = 1;
            alface3.alpha = 1;
            break;
        case 4:
            alface1.alpha = 1;
            alface2.alpha = 1;
            alface3.alpha = 1;
            alface4.alpha = 1;
            break;
            
        default:
            break;
    }

    
    MKPointAnnotation *ponto = [[MKPointAnnotation alloc] init];
    CLLocationCoordinate2D localizacao;
    float latitude = self.coordenadaShared.pontoLatitude;
    float longitude = self.coordenadaShared.pontoLongitude;
    localizacao.latitude = latitude ;
    localizacao.longitude = longitude;
    ponto.coordinate = localizacao;
    [[self mapaDetalhes] addAnnotation:ponto];
    [self zoomToUserRegion];
    
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    [[self mapaDetalhes] setCenterCoordinate: userLocation.location.coordinate];
}

-(void)zoomToUserRegion {
    MKCoordinateRegion region;
    region.center.latitude = self.mapaDetalhes.userLocation.coordinate.latitude;
    region.center.longitude = self.mapaDetalhes.userLocation.coordinate.longitude;
    region.span.latitudeDelta = 0.1;
    region.span.longitudeDelta = 0.1;
    [self.mapaDetalhes setRegion:region];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    static NSString *annotationIdentifier = @"annotationIdentifier";
    MKPinAnnotationView *pinView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:annotationIdentifier];
    
    
    if (pinView.annotation == mapView.userLocation) {
        return nil;
        
    }else{
        [pinView setImage:[UIImage imageNamed:@"pino.png"]];
    }
    
    
    pinView.canShowCallout = YES;
    pinView.animatesDrop = YES;
    pinView.selected = YES;
    
    return pinView;
}

@end
