//
//  MazeGraph.m
//  SpeedMaze
//
//  Created by littlebeef on 11/21/14.
//  Copyright (c) 2014 beefSama. All rights reserved.
//

#import "MazeGraph.h"

@interface MazeGraph()


@end

@implementation MazeGraph

-(instancetype)initWithWidth:(int)width height:(int)height{
    self = [super init];
    if (self == nil) {
        return nil;
    }
    self.width = width;
    self.height = height;
    self.cells = [[NSMutableArray alloc] initWithCapacity:width];
    for (int i = 0; i < width; i++) {
        self.cells[i] = [[NSMutableArray alloc] initWithCapacity:height];
        for (int j = 0; j < height; j++) {
            self.cells[i][j] = [[MazeCell alloc]initWithX:i Y:j];
        }
    }
    self.removedEdges = [[NSMutableArray alloc] init];
    return self;
}

-(MazeCell *)getCellAtX:(int)x y:(int)y{
    if (x >= self.width || y >= self.height || x < 0 || y < 0) {
        return nil;
    }
    if (!self.cells[x]) {
        return nil;
    }
    return self.cells[x][y];
}

-(double)getCellDistanceBetween:(MazeCell *)cellA and:(MazeCell *)cellB{
    double xDist = ABS(cellA.x - cellB.x);
    double yDist = ABS(cellA.y - cellB.y);
    return sqrt(pow(xDist, 2) + pow(yDist, 2));
}

-(BOOL)areConnectedBetween:(MazeCell *)cellA and:(MazeCell *)cellB{
    if (!cellA || !cellB) {
        return NO;
    }
    // see if they are next B each other
    if (abs(cellA.x - cellB.x) > 1 || abs(cellA.y - cellB.y) > 1) {
        return NO;
    }
    
    for(NSSet *cellPair in self.removedEdges){
        if ([cellPair containsObject:cellA] && [cellPair containsObject:cellB]){
            return NO;
        }
    }
    
    return YES;
}

-(NSArray *)cellUnvisitedNeighbors:(MazeCell *)cell{
    NSMutableArray *unvistedNeighbors = [NSMutableArray array];
    for(MazeCell *unvistedCell in [self cellConnectedNeighbors:cell]){
        //NSLog(@"in unvistedNeighbors for loop");
        if (unvistedCell.visited == NO) {
            //NSLog(@"not visited");
            [unvistedNeighbors addObject:unvistedCell];
        }
    }
    //NSLog(@"at cellUnvisitedNeighbors, count:%lu",unvistedNeighbors.count);
    return unvistedNeighbors;
}

-(NSArray *)cellConnectedNeighbors:(MazeCell *)cell{
    NSMutableArray *connectedNeighbors = [NSMutableArray array];
    for(MazeCell *tempCell in [self cellNeighbors:cell]){
        //NSLog(@"in for loop, there is a temp cell");
        if ([self areConnectedBetween:cell and:tempCell]) {
            //NSLog(@"it is connected");
            [connectedNeighbors addObject:tempCell];
        }
    }
    return connectedNeighbors;
}

-(NSArray *)cellDisconnectedNeighbors:(MazeCell *)cell{
    NSMutableArray *disconnectedNeighbors = [NSMutableArray array];
    for(MazeCell *tempCell in [self cellNeighbors:cell]){
        if (![self areConnectedBetween:cell and:tempCell]) {
            [disconnectedNeighbors addObject:tempCell];
        }
    }
    return disconnectedNeighbors;}

-(NSArray *)cellNeighbors:(MazeCell *)cell{
    NSMutableArray *neighbors = [NSMutableArray array];
    MazeCell *topCell =    [self getCellAtX:cell.x       y:(cell.y + 1)];
    MazeCell *rightCell =  [self getCellAtX:(cell.x + 1) y:cell.y];
    MazeCell *bottomCell = [self getCellAtX:cell.x       y:(cell.y - 1)];
    MazeCell *leftCell =   [self getCellAtX:(cell.x - 1) y:cell.y];

    if(cell.y < self.height && topCell) {
        [neighbors addObject:topCell];
    }
    if(cell.x < self.width && rightCell) {
        [neighbors addObject:rightCell];
    }
    if(cell.y > 0 && bottomCell) {
        [neighbors addObject:bottomCell];
    }
    if(cell.x > 0 && leftCell) {
        [neighbors addObject:leftCell];
    }
    //NSLog(@"at cellNeighbors, count:%lu",neighbors.count);
    return neighbors;
}

-(void)removeEdgeBetween:(MazeCell *)cellA and:(MazeCell *)cellB{
    NSSet *edgePair = [[NSSet alloc] initWithObjects:cellA,cellB,nil];
    [self.removedEdges addObject:edgePair];
    // add switch to mark the wallMask in both of the cell
    int xDelta = cellA.x - cellB.x;
    int yDelta = cellA.y - cellB.y;
    //same column, because x is the same, either top or bottom, assume
    if (xDelta == 0) {
        // positive y means A is top, B is under A
        if (yDelta < 0) {
            // B is at A's top
            cellA.wallOpenBitMask = cellA.wallOpenBitMask | TopWallOpen ;
            cellB.wallOpenBitMask = cellB.wallOpenBitMask | BottomWallOpen;
        }
        else{
            // B is at A's bottome
            cellA.wallOpenBitMask = cellA.wallOpenBitMask | BottomWallOpen ;
            cellB.wallOpenBitMask = cellB.wallOpenBitMask | TopWallOpen;
        }
    }
    else{
        if (xDelta > 0 ) {
            // B is at A's left
            cellA.wallOpenBitMask = cellA.wallOpenBitMask | LeftWallOpen ;
            cellB.wallOpenBitMask = cellB.wallOpenBitMask | RightWallOpen;
        }
        else{
            // B is at A's right
            cellA.wallOpenBitMask = cellA.wallOpenBitMask | RightWallOpen ;
            cellB.wallOpenBitMask = cellB.wallOpenBitMask | LeftWallOpen;
        }
    }
    
}


@end