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

/// original js
/* //js
 var Graph = function(width, height) {
 this.width = width;
 this.height = height;
 this.cells = [];
 this.removedEdges = [];
 
 var self = this;
 
 this.getCellAt = function (x, y) {
 if(x >= this.width || y >= this.height || x < 0 || y < 0) {
 return null;
 }
 if(!this.cells[x]) {
 return null;
 }
 return this.cells[x][y];
 };
 
 this.getCellDistance = function (cell1, cell2) {
 var xDist = Math.abs(cell1.x - cell2.x);
 var yDist = Math.abs(cell1.y - cell2.y);
 return Math.sqrt(Math.pow(xDist, 2) + Math.pow(yDist, 2));
 },
 
 // Returns true if there is an edge between cell1 and cell2
 this.areConnected = function(cell1, cell2) {
 if(!cell1 || !cell2) {
 return false;
 }
 if(Math.abs(cell1.x - cell2.x) > 1 ||
 Math.abs(cell1.y - cell2.y) > 1) {
 return false;
 }
 
 var removedEdge = _.detect(this.removedEdges, function(edge) {
 return _.include(edge, cell1) && _.include(edge, cell2);
 });
 
 return removedEdge == undefined;
 };
 
 this.cellUnvisitedNeighbors = function(cell) {
 return _.select(this.cellConnectedNeighbors(cell), function(c) {
 return !c.visited;
 });
 };
 
 // Returns all neighbors of this cell that ARE separated by an edge (maze line)
 this.cellConnectedNeighbors = function(cell) {
 return _.select(this.cellNeighbors(cell), function(c) {
 return self.areConnected(cell, c);
 });
 };
 
 // Returns all neighbors of this cell that are NOT separated by an edge
 // This means there is a maze path between both cells.
 this.cellDisconnectedNeighbors = function (cell) {
 return _.reject(this.cellNeighbors(cell), function(c) {
 return self.areConnected(cell, c);
 });
 }
 
 // Returns all neighbors of this cell, regardless if they are connected or not.
 this.cellNeighbors = function (cell) {
 var neighbors = [];
 var topCell = this.getCellAt(cell.x, cell.y - 1);
 var rightCell = this.getCellAt(cell.x + 1, cell.y);
 var bottomCell = this.getCellAt(cell.x, cell.y + 1);
 var leftCell = this.getCellAt(cell.x - 1, cell.y);
 
 if(cell.y > 0 && topCell) {
 neighbors.push(topCell);
 }
 if(cell.x < this.width && rightCell) {
 neighbors.push(rightCell);
 }
 if(cell.y < this.height && bottomCell) {
 neighbors.push(bottomCell);
 }
 if(cell.x > 0 && leftCell) {
 neighbors.push(leftCell);
 }
 
 return neighbors;
 }
 
 this.removeEdgeBetween = function(cell1, cell2) {
 this.removedEdges.push([cell1, cell2]);
 };
 
 for(var i = 0; i < this.width; i++) {
 this.cells.push([]);
 row = this.cells[i];
 for(var j = 0; j < this.height; j++) {
 var cell = new Cell(i, j, this);
 row.push(cell);
 }
 }
 };
 */

@end