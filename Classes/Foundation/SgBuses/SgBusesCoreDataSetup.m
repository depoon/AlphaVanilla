//
//  SgBusesCoreDataSetup.m
//  Freestyle
//
//  Created by Kenneth on 8/4/13.
//
//

#import "SgBusesCoreDataSetup.h"
#import "CoreDataManagerAction.h"
#import "SgBusesCoreDataManager.h"
#import "FileContentsReader.h"
#import "BusStopCoreData.h"
#import "StringCoordinatesParser.h"

NSString* const CoreDataModule = @"SgBuses";

@implementation SgBusesCoreDataSetup{

}

@synthesize sgBusesCoreDataUpdateUIActionDelegate;

-(void) dealloc{
    if (sgBusesCoreDataUpdateUIActionDelegate){
        [sgBusesCoreDataUpdateUIActionDelegate release];
        sgBusesCoreDataUpdateUIActionDelegate = nil;
    }
    [super dealloc];
}

-(BOOL) shouldResetupCoreData{
    SgBusesCoreDataManager* sgBusesCoreDataManager = [self generateSgBusesCoreDataManager];
    NSArray* busStopsArray = [sgBusesCoreDataManager getAllBusStops];
    
    
    if ([busStopsArray count]==0){
        return YES;
    }
    return NO;
}

-(SgBusesCoreDataManager*) generateSgBusesCoreDataManager{
    SgBusesCoreDataManager* sgBusesCoreDataManager = [[[SgBusesCoreDataManager alloc]init]autorelease];
    return sgBusesCoreDataManager;
}

-(FileContentsReader*) generateFileContentsReader{
    FileContentsReader* fileContentsReader = [[[FileContentsReader alloc]init]autorelease];
    return fileContentsReader;
}



- (float)updateProgress:(NSArray *)array currentProgressValue: (float)  currentProgressValue weightage: (int) weightage{
    float one = 1;
    float progressForBusStopSetupSegment = (one / [array count]) * weightage;
    currentProgressValue = currentProgressValue + progressForBusStopSetupSegment;
    return currentProgressValue;
}



-(void) setupCoreData{
    
    NSMutableDictionary* uniqueBusNumberDictionary = [NSMutableDictionary dictionary];
    NSMutableDictionary* uniqueBusStopDictionary = [NSMutableDictionary dictionary];
    
    SgBusesCoreDataManager* sgBusesCoreDataManager = [self generateSgBusesCoreDataManager];
    FileContentsReader* fileContentsReader = [self generateFileContentsReader];
    

    
    float progressValueOutOf100 = 0;
    

    if ([self shouldResetupCoreData]){

        NSLog(@"Nothing here");

        NSDictionary* busStopsJson = [fileContentsReader getJsonDictionaryValueFromFile:@"bus-stops.json"];
        NSDictionary* busStopsServicesJson = [fileContentsReader getJsonDictionaryValueFromFile:@"bus-stops-services.json"];

        
        NSArray* allKeys = [busStopsJson allKeys];
        
        StringCoordinatesParser* stringCoordinatesParser = [[StringCoordinatesParser alloc]init];
        for (NSString* busStopStringKey in allKeys){
            progressValueOutOf100 = [self updateProgress:allKeys currentProgressValue:progressValueOutOf100 weightage:50];
            if (sgBusesCoreDataUpdateUIActionDelegate!=nil){
                [sgBusesCoreDataUpdateUIActionDelegate performSelectorInBackground:@selector(updateProgress:) withObject:[NSNumber numberWithFloat:progressValueOutOf100]];

                NSLog(@"update top: %f", progressValueOutOf100);
            }
            
            
            NSDictionary* busStopDictionary = (NSDictionary*) [busStopsJson objectForKey:busStopStringKey];
            NSString* coordinatesString = (NSString*) [busStopDictionary objectForKey:@"coords"];
            NSString* busStopName = (NSString*) [busStopDictionary objectForKey:@"name"];
            NSArray* busStopsServicesArray = (NSArray*) [busStopsServicesJson objectForKey:busStopStringKey];
            

            CLLocationCoordinate2D generatedCoordinate = [stringCoordinatesParser generateCoordinateFromString:coordinatesString];

            
            ;

            BusStopCoreData* busStop = (BusStopCoreData*) [sgBusesCoreDataManager createBusStop:busStopStringKey busStopName:busStopName latitude:generatedCoordinate.latitude longitude:generatedCoordinate.longitude];
            [uniqueBusStopDictionary setObject:busStop forKey:busStop.busStopNumber];
            
            for (NSString* busStopService in busStopsServicesArray){
                BusNumberCoreData* existingObj = (BusNumberCoreData*) [uniqueBusNumberDictionary objectForKey:busStopService];
                if (existingObj == nil){
                    BusNumberCoreData* newObj = [sgBusesCoreDataManager createBusNumber:busStopService];
                    [uniqueBusNumberDictionary setObject:newObj forKey:busStopService];
                }
            }


        }
        [stringCoordinatesParser release];
        
        
        
        NSArray* busNumberKeys = [uniqueBusNumberDictionary allKeys];
        for (NSString* busNumberKey in busNumberKeys){
            progressValueOutOf100 = [self updateProgress:busNumberKeys currentProgressValue:progressValueOutOf100 weightage:50];
            if (sgBusesCoreDataUpdateUIActionDelegate!=nil){
                [sgBusesCoreDataUpdateUIActionDelegate performSelectorInBackground:@selector(updateProgress:) withObject:[NSNumber numberWithFloat:progressValueOutOf100]];

                NSLog(@"update bottom: %f", progressValueOutOf100);
            }

            NSString* fileName = [NSString stringWithFormat:@"%@.json", busNumberKey];
            
            BusNumberCoreData* busNumber = [uniqueBusNumberDictionary objectForKey:busNumberKey];
            
            [self setupBusRoute:1 fileName:fileName fileContentsReader:fileContentsReader sgBusesCoreDataManager:sgBusesCoreDataManager uniqueBusStopDictionary:uniqueBusStopDictionary busNumber:busNumber];
            [self setupBusRoute:2 fileName:fileName fileContentsReader:fileContentsReader sgBusesCoreDataManager:sgBusesCoreDataManager uniqueBusStopDictionary:uniqueBusStopDictionary busNumber:busNumber];
            
            
            
        }
        
        
        
        [sgBusesCoreDataManager saveContext];

        NSLog(@"completed");
        
        if (sgBusesCoreDataUpdateUIActionDelegate!=nil){
            [sgBusesCoreDataUpdateUIActionDelegate performSelectorInBackground:@selector(updateProgress:) withObject:[NSNumber numberWithFloat:100]];
            
        }



        
    }
}


- (void)setupBusRoute:(int)directionValue fileName:(NSString *)fileName fileContentsReader:(FileContentsReader *)fileContentsReader sgBusesCoreDataManager:(SgBusesCoreDataManager *)sgBusesCoreDataManager uniqueBusStopDictionary:(NSMutableDictionary *)uniqueBusStopDictionary busNumber:(BusNumberCoreData *)busNumber {
    NSNumber* directionNumber = [NSNumber numberWithInt:directionValue];
    NSDictionary* routeInfoDictionary = (NSDictionary*)[fileContentsReader getJsonDictionaryValueFromFile:fileName];
    if (routeInfoDictionary!=nil){
        
        BusDirectionCoreData* busDirection = [sgBusesCoreDataManager createBusDirection:directionNumber];
        busDirection.busNumber = busNumber;
        NSLog(@"busNumber: %@", busNumber.busNumber);
        
        NSDictionary* directionDictionary = (NSDictionary*) [routeInfoDictionary objectForKey:[directionNumber stringValue]];
        NSArray* stopsArray = (NSArray*) [directionDictionary objectForKey:@"stops"];
        for (int i=0; i<[stopsArray count]; i++){
            NSString* stop = [stopsArray objectAtIndex:i];
            
            BusStopCoreData* busStop = (BusStopCoreData*) [uniqueBusStopDictionary objectForKey:stop];
            
            BusRouteCoreData* busRoute = [sgBusesCoreDataManager createBusRoute:i];
            busRoute.busDirection = busDirection;
            busRoute.busStop = busStop;

        }
        
        
    }
}

-(void) deleteAllBusData{
    SgBusesCoreDataManager* sgBusesCoreDataManager = [self generateSgBusesCoreDataManager];
    [sgBusesCoreDataManager deleteAllDataViaCascade];
}
@end
