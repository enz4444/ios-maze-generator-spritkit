//
//  MazeCell.h
//  speed-maze
//
//  Created by Enlan Zhou on 11/19/14.
//  Copyright (c) 2014 beefSama. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <Foundation/Foundation.h>

@interface MazeCell:NSObject

@property (assign, nonatomic) int x;
@property (assign, nonatomic) int y;
@property (assign, nonatomic) BOOL visited;
@property (strong, nonatomic) MazeCell *parent;
@property (assign, nonatomic) int discorver;

-(instancetype)init;


/**
 *  default inti
 *
 *  @param x x of width
 *  @param y y of height
 *
 *  @return self
 */
-(instancetype)initWithX:(int)x Y:(int)y;

/**
 *  mark this cell as visited
 */
-(void)visit;

/**
 *  find how many steps from here(included) to origin
 *
 *  @return step(s)
 */
-(int)score;

/**
 *  an array of MazeCells also is a path from here(included) to origin
 *  bottom, the index 0 is the origin, the tail is here
 *
 *  @return array of MazeCells
 */
-(NSArray *)pathToOrigin;

/**
 *  original js
 */
/*
 var Cell = function(x, y) {
 this.x = x;
 this.y = y;
 this.visited = false;
 
 // When solving the maze, this represents
 // the previous node in the navigated path.
 this.parent = null;
 
 this.discorver = 0;
 
 this.visit = function () {
 this.visited = true;
 };
 
 this.score = function () {
 var total = 0;
 var p = this.parent;
 
 while(p) {
 ++total;
 p = p.parent;
 }
 return total;
 };
 
 this.pathToOrigin = function () {
 var path = [this];
 var p = this.parent;
 
 while(p) {
 path.push(p);
 p = p.parent;
 }
 path.reverse();
 
 return path;
 };
 };
 */
@end