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

/**
 *  solution path, array of MazeCell
 */
@property(strong,nonatomic) NSArray *path;



-(instancetype)initMazeWithWidth:(int)width height:(int)height;

/**
 *  do all the necessary steps to build a maze;
 */
-(void)defaultMaze;

/**
 *  after default init, invoke this to default grow maze from (0,0)
 */
-(void)defaultGenerateMaze;


/**
 *  as it said
 */
-(void)defaultSolveMaze;



@end

