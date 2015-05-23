//
//  MazeCell.h
//  speed-maze
//
//  Created by Enlan Zhou on 11/19/14.
//  Copyright (c) 2014 beefSama. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <Foundation/Foundation.h>


typedef NS_ENUM(uint32_t, openWallType)
{
    TopWallOpen       = 0x1 << 0,
    LeftWallOpen     = 0x1 << 1,
    BottomWallOpen     = 0x1 << 2,
    RightWallOpen    = 0x1 << 3,
    AllWallsOepn     = TopWallOpen|LeftWallOpen|BottomWallOpen|RightWallOpen,
    AllwallsClose    = 0x0
};

@interface MazeCell:NSObject

@property (assign, nonatomic) int x;
@property (assign, nonatomic) int y;
@property (assign, nonatomic) BOOL visited;
@property (strong, nonatomic) MazeCell *parent;
@property (assign, nonatomic) int discorver;
@property (assign, nonatomic) openWallType wallOpenBitMask; //N,W,S,E or U,L,D,R

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

@end