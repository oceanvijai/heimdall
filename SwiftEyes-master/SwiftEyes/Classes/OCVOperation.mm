//
//  OCVOperation.m
//  LegoCV
//
//  Created by Dal Rupnik on 23/01/2017.
//  Copyright © 2017 Unified Sense. All rights reserved.
//

#import <opencv2/core/core.hpp>
#import <opencv2/imgproc/imgproc.hpp>

#import "OCVGeometry+Private.h"

#import "OCVInputArray+Private.h"
#import "OCVOutputArray+Private.h"
#import "OCVInputOutputArray+Private.h"

#import "OCVMatDataAllocator+Private.h"

#import "OCVOperation.h"

@implementation OCVOperation

+ (void)convertColorFromSource:(id<OCVInputArrayable>)source toDestination:(id<OCVOutputArrayable>)destination withType:(OCVColorConversionType)type {
    [self convertColorFromSource:source toDestination:destination withType:type withDestinationCn:0];
}

+ (void)convertColorFromSource:(id<OCVInputArrayable>)source toDestination:(id<OCVOutputArrayable>)destination withType:(OCVColorConversionType)type withDestinationCn:(NSInteger)destinationCn {
    
    cv::cvtColor(*source.input._input, *destination.output._output, (int)type, (int)destinationCn);
}

+ (void)equalizeHistogramFromSource:(id<OCVInputArrayable>)source toDestination:(id<OCVOutputArrayable>)destination {
    cv::equalizeHist(*source.input._input, *destination.output._output);
}

+ (void)resizeFromSource:(id<OCVInputArrayable>)source toDestination:(id<OCVOutputArrayable>)destination size:(OCVSize)size fx:(double)fx fy:(double)fy interpolation:(OCVInterpolationType)interpolation {
    cv::resize(*source.input._input, *destination.output._output, convertSize(size), fx, fy, (int)interpolation);
}

#pragma mark - Drawing

+ (void)rectangleOnSource:(id<OCVInputOutputArrayable>)source fromPoint:(OCVPoint)point1 toPoint:(OCVPoint)point2 withColor:(OCVScalar)color thickness:(NSInteger)thickness lineType:(NSInteger)lineType shift:(NSInteger)shift {
    cv::rectangle(*source.inputOutput._inputOutput, convertPoint(point1), convertPoint(point2), convertScalar(color), (int)thickness, (int)lineType, (int)shift);
}

+ (void)rectangleOnSource:(id<OCVInputOutputArrayable>)source fromRect:(OCVRect)rect withColor:(OCVScalar)color thickness:(NSInteger)thickness lineType:(NSInteger)lineType shift:(NSInteger)shift {
    
    OCVPoint point1;
    point1.x = rect.origin.x;
    point1.y = rect.origin.y;
    
    OCVPoint point2;
    point2.x = rect.origin.x + rect.size.width;
    point2.y = rect.origin.y + rect.size.height;
    
    cv::rectangle(*source.inputOutput._inputOutput, convertPoint(point1), convertPoint(point2), convertScalar(color), (int)thickness, (int)lineType, (int)shift);
}


#pragma mark - Core


+ (void)absoluteDifferenceOnFirstSource:(id<OCVInputArrayable>)firstSource andSecondSource:(id<OCVInputArrayable>)secondSource toDestination:(id<OCVOutputArrayable>)destination {



    cv::absdiff(*firstSource.input._input, *secondSource.input._input, *destination.output._output);
}


#pragma mark - Image Processing

+ (void)blurOnSource:(id<OCVInputArrayable>)source toDestination:(id<OCVOutputArrayable>)destination withSize:(OCVSize)size{

    cv::blur(*source.input._input, *destination.output._output, cv::Size((int)size.width,(int)size.height));
}


+ (void)thresholdOnSource:(id<OCVInputArrayable>)source toDestination:(id<OCVOutputArrayable>)destination withThresh:(double)thresh withMaxValue:(double)maxval withType:(OCVThresholdType)type {

    cv::threshold(*source.input._input, *destination.output._output, thresh, maxval, type);
}



+ (void)findContoursOnSource:(id<OCVInputOutputArrayable>)source toContours:(id<OCVOutputArrayable>)contours withHierarchy:(id<OCVOutputArrayable>)hierarchy withMode:(OCVContourRetrievalMode)mode withMethod:(OCVContourApproximationMethod)method {

    cv::findContours(*source.inputOutput._inputOutput, *contours.output._output, *hierarchy.output._output, (int)mode, (int)method);

}

@end
