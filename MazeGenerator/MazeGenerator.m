//
//  MazeGenerator.m
//  speed-maze
//
//  Created by littlebeef on 11/19/14.
//  Copyright (c) 2014 beefSama. All rights reserved.
//

#import "MazeGenerator.h"

@interface MazeGenerator()

@property(strong,nonatomic) NSMutableArray *cellStack;


@end

@implementation MazeGenerator

-(instancetype)init{
    self = [super init];
    if (self == nil) {
        return nil;
    }
    self.cellStack = [[NSMutableArray alloc] init];
    return self;
}

-(instancetype)initMazeWithWidth:(int)width height:(int)height{
    self = [super init];
    if (self == nil) {
        return nil;
    }
    self.cellStack = [[NSMutableArray alloc] init];
    self.mazeGraph = [[MazeGraph alloc] initWithWidth:width height:height];
    return self;
}

/**
 *  do all the necessary steps to build a maze;
 */
-(void)defaultMaze{
    [self defaultGenerateMaze];
    [self defaultSolveMaze];
}

-(void)defaultRecusiveGrowMaze:(MazeCell *)mazeCell{
    //NSLog(@"recursive at (%i,%i)",mazeCell.x,mazeCell.y);
    [mazeCell visit];
    NSArray *neighbor = [self.mazeGraph cellUnvisitedNeighbors:mazeCell];
    //NSLog(@"cellUnvisitedNeighbors: %lu", neighbor.count);
    if (neighbor.count && neighbor.count > 0) {
        MazeCell *randomNeighbor = neighbor[arc4random_uniform((int)neighbor.count)];
        [self.cellStack addObject:mazeCell];
        [self.mazeGraph removeEdgeBetween:mazeCell and:randomNeighbor];
        [self defaultRecusiveGrowMaze:randomNeighbor];
    }
    else{
        if (self.cellStack.count) {
            MazeCell *waitingCell = self.cellStack.lastObject;
            [self.cellStack removeLastObject];
            [self defaultRecusiveGrowMaze:waitingCell];
        }
        
    }
}

-(void)defaultSolveMaze{
    NSMutableArray *closedCells = [NSMutableArray array];
    MazeCell *startCell = [self.mazeGraph getCellAtX:0 y:0];
    MazeCell *endCell = [self.mazeGraph getCellAtX:(self.mazeGraph.width - 1) y:(self.mazeGraph.height - 1)];
    NSMutableArray *openCells = [NSMutableArray arrayWithObject:startCell];
    MazeCell *searchCell = startCell;
    while (openCells.count) {
        NSMutableArray *neighbors = [NSMutableArray arrayWithArray:[self.mazeGraph cellDisconnectedNeighbors:searchCell]];
        for (int i = 0; i < neighbors.count; i++) {
            MazeCell *neighbor = neighbors[i];
            if (neighbor == endCell) {
                neighbor.parent = searchCell;
                self.path = neighbor.pathToOrigin;
                [openCells removeAllObjects];
                return;
            }
            if (![closedCells containsObject:neighbor]) {
                if (![openCells containsObject:neighbor]) {
                    [openCells addObject:neighbor];
                    neighbor.parent = searchCell;
                    neighbor.discorver = [neighbor score] + [self.mazeGraph getCellDistanceBetween:neighbor and:endCell];
                }
            }
        }
        [closedCells addObject:searchCell];
        [openCells removeObject:searchCell];
        searchCell = nil;
        
        for(MazeCell *tempCell in openCells){
            if (!searchCell) {
                searchCell = tempCell;
            }
            else if (searchCell.discorver > tempCell.discorver){
                searchCell = tempCell;
            }
        }
        
    }
}

/**
 *  default(original) method to grow a maze from a maze cell
 *
 *  @param mazeCell mazeCell at (0,0)
 */

-(void)defaultGenerateMaze{
    //NSLog(@"defaultGernerateMaze");
    [self defaultRecusiveGrowMaze:[[self mazeGraph] getCellAtX:0 y:0]];
}


@end