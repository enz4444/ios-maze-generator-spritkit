//
//  MazeGenerator.h
//  speed-maze
//
//  Created by Enlan Zhou on 11/19/14.
//  Copyright (c) 2014 beefSama. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MazeCell.h"
#import "MazeGraph.h"


@interface MazeGenerator : NSObject

@property(strong,nonatomic) MazeGraph *mazeGraph;
@property(strong,nonatomic) NSArray *path;


-(instancetype)initMazeWithWidth:(int)width height:(int)height;

-(void)defaultRecusiveGrowMaze:(MazeCell *)mazeCell;

/**
 *  as it said
 */
-(void)defaultSolveMaze;

/**
 *  after default init, invoke this to default grow maze from (0,0)
 */
-(void)defaultGenerateMaze;


/* //js
 var MazeGenerator = function(rows, cols) {
	this.graph = new Graph(rows, cols);
	this.cellStack = [];
 
	var self = this;
	var recurse = function(cell) {
 cell.visit();
 var neighbors = self.graph.cellUnvisitedNeighbors(cell);
 if(neighbors.length > 0) {
 var randomNeighbor = neighbors[Math.floor(Math.random() * neighbors.length)];
 self.cellStack.push(cell);
 self.graph.removeEdgeBetween(cell, randomNeighbor);
 recurse(randomNeighbor);
 }
 else {
 var waitingCell = self.cellStack.pop();
 if(waitingCell) {
 recurse(waitingCell);
 }
 }
 };
 
 this.solve = function() {
 var closedSet = [];
 var startCell = this.graph.getCellAt(0, 0); // top left cell
 var targetCell = this.graph.getCellAt(this.graph.width - 1, this.graph.height - 1); // bottom right cell
 var openSet = [startCell];
 var searchCell = startCell;
 
 while(openSet.length > 0) {
 var neighbors = this.graph.cellDisconnectedNeighbors(searchCell);
 for(var i = 0; i < neighbors.length; i ++) {
 var neighbor = neighbors[i];
 if(neighbor == targetCell) {
 neighbor.parent = searchCell;
 this.path = neighbor.pathToOrigin();
 openSet = [];
 return;
 }
 if(!_.include(closedSet, neighbor)) {
 if(!_.include(openSet, neighbor)) {
 openSet.push(neighbor);
 neighbor.parent = searchCell;
 neighbor.heuristic = neighbor.score() + this.graph.getCellDistance(neighbor, targetCell);
 }
 }
 }
 closedSet.push(searchCell);
 openSet.remove(_.indexOf(openSet, searchCell));
 searchCell = null
 ;
 
 _.each(openSet, function(cell) {
 if(!searchCell) {
 searchCell = cell;
 }
 else if(searchCell.heuristic > cell.heuristic) {
 searchCell = cell;
 }
 });
 }
 };
 
	this.generate = function() {
 
 var initialCell = this.graph.getCellAt(0, 0);
 recurse(initialCell);
	};
 };
 */

 
@end

