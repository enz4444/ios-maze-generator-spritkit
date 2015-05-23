//
//  MazeScene.h
//  SpeedMaze
//
//  Created by Enlan Zhou on 12/7/14.
//  Copyright (c) 2014 beefSama. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <Foundation/Foundation.h>
#import "MazeGenerator.h"

@interface MazeScene : SKScene

//@property (strong, nonatomic) NSMutableArray * twoDSKNodes;
@property (strong,nonatomic) MazeGenerator *theMaze;

/**
 *  default init, need to pass in the screen size to calculate some static vaules at 
 *  the beginning.
 *
 *  @param maze       maze
 *  @param screenSize parent screen size, or whatever size
 *
 *  @return SKScene with whatever method invoked at the end of didMoveToView
 */
-(instancetype)initWithMaze:(MazeGenerator *)maze andScreenSize:(CGSize)screenSize;

@end
