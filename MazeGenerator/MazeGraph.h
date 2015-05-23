//
//  MazeGraph.h
//  SpeedMaze
//
//  Created by littlebeef on 11/21/14.
//  Copyright (c) 2014 beefSama. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MazeCell.h"
@interface MazeGraph : NSObject

/**
 *  width is x, height is y. Use x-y coordination, it means x is the x-th column.
 *  so width is not row, width is column. e.g. 5 units of width is 5 columns.
 */
@property(assign,nonatomic) int width;
@property(assign,nonatomic) int height;
@property(strong,nonatomic) NSMutableArray *cells;
@property(strong,nonatomic) NSMutableArray *removedEdges; //unordered pairs (use sets?)

/**
 *  default init for functional MazeGraph. NOTE! it doesn't intialize the object
 *  inside the array. Which means this[widht][height] maybe an id instead of
 *  a MazeCell
 *
 *  @param width  width
 *  @param height height
 *
 *  @return instancetype
 */
-(instancetype)initWithWidth:(int)width height:(int)height;


/**
 *  as it said
 *
 *  @param x width,column
 *  @param y height,row
 *
 *  @return MazeCell at (x,y)
 */
-(MazeCell *)getCellAtX:(int)x y:(int)y;

/**
 *  "hook ass theory"
 */
-(double)getCellDistanceBetween:(MazeCell *)cellA and:(MazeCell *)cellB;

/**
 *  Returns true if there is an edge between cell1 and cell2
 *
 *  @param cellFrom doesn't matter which is from or to
 *  @param cellTo   see above
 *
 *  @return boolean
 */
-(BOOL)areConnectedBetween:(MazeCell *)cellA and:(MazeCell *)cellB;


/**
 *  as it said
 *
 *  @param cell as it said
 *
 *  @return as it said
 */
-(NSArray *)cellUnvisitedNeighbors:(MazeCell *)cell;

/**
 *  Returns all neighbors of this cell that ARE separated by an edge (maze line)
 *
 *  @param cell cell
 *
 *  @return as it said
 */
-(NSArray *)cellConnectedNeighbors:(MazeCell *)cell;

/**
 *  Returns all neighbors of this cell that are NOT separated by an edge
 *  This means there is a maze path between both cells.
 *
 *  @param cell cell
 *
 *  @return as the name said
 */
-(NSArray *)cellDisconnectedNeighbors:(MazeCell *)cell;

/**
 *  Returns all neighbors of this cell, regardless if they are connected or not.
 *
 *  @param cell cell
 *
 *  @return neightbors(e.g. if cell is at corner, neighbors.count is 2)
 */
-(NSArray *)cellNeighbors:(MazeCell *)cell;

/**
 *  as it said, also push the removed egde(s) to self.removedEdges
 *
 *  @param cellA a
 *  @param cellB b
 */
-(void)removeEdgeBetween:(MazeCell *)cellA and:(MazeCell *)cellB;

@end