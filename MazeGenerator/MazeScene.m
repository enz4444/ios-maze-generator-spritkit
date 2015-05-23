//
//  MazeScene.m
//  SpeedMaze
//
//  Created by Enlan Zhou on 12/7/14.
//  Copyright (c) 2014 beefSama. All rights reserved.
//

#import "MazeScene.h"

@interface MazeScene ()

/**
 *  draw the grid of maze
 */
-(void)drawAllWallsAsOneNode;


/**
 *  simple method to paint/draw the solution path
 */
-(void)drawSolutionPath;

@end

@implementation MazeScene

static float squareLength;
static float squareWallThickness;

-(void)didMoveToView:(SKView *)view{
    NSLog(@"didMoveToView: %f, %f, %f, %f",self.frame.origin.x,self.frame.origin.y,self.frame.size.width,self.frame.size.height);
    NSLog(@"square length and thickness: %f, %f", squareLength, squareWallThickness);
    
    [self drawAllWallsAsOneNode];
    [self drawSolutionPath];
    
    //print solution path
    if (ZenDebug) {
        for (MazeCell *step in self.theMaze.path) {
            NSLog(@"(%i,%i)",step.x,step.y);
            
        }
    }
    
    //ASCII maze no right,bottom walls // ⅃
    if (ZenDebug) {
        for (int j = 0; j < 9; j++) {
            NSString *row = @"";
            for (int i = 0; i < 9; i++) {
                if(![self.theMaze.mazeGraph areConnectedBetween:((MazeCell *)self.theMaze.mazeGraph.cells[i][j]) and:((MazeCell *)self.theMaze.mazeGraph.cells[i+1][j])]){
                    if(![self.theMaze.mazeGraph areConnectedBetween:((MazeCell *)self.theMaze.mazeGraph.cells[i][j]) and:((MazeCell *)self.theMaze.mazeGraph.cells[i][j+1])]){
                        row=[row stringByAppendingString:@" "];
                    }
                    else{
                        row=[row stringByAppendingString:@"_"];
                    }
                }
                else{
                    if(![self.theMaze.mazeGraph areConnectedBetween:((MazeCell *)self.theMaze.mazeGraph.cells[i][j]) and:((MazeCell *)self.theMaze.mazeGraph.cells[i][j+1])]){
                        row=[row stringByAppendingString:@"|"];
                    }
                    else{
                        row=[row stringByAppendingString:@">"];
                    }
                }
            }
            NSLog(@"%@",row);
        }
    }
    
    

    
}

-(void)drawAllWallsAsOneNode{
    SKShapeNode *square = [SKShapeNode node];
    UIBezierPath* wallPath = [[UIBezierPath alloc] init];
    //from origin point, draw bottom line
    [wallPath moveToPoint:CGPointMake(0.0, 0.0)];
    for (int row = 0; row < self.theMaze.mazeGraph.height; row++) {
        for (int col = 0; col < self.theMaze.mazeGraph.width; col++) {
            [wallPath moveToPoint:CGPointMake(squareLength*col, squareLength*row)];
            MazeCell *cell =[self.theMaze.mazeGraph getCellAtX:col y:row];
            
            /**
             *  draw bottom wall, skip the drawing of entrance
             */
            if ((cell.wallOpenBitMask & BottomWallOpen) || (col == 0 && row == 0)){
                [wallPath moveToPoint:CGPointMake(squareLength*col + squareLength ,squareLength*row)];
            }
            else{
                [wallPath addLineToPoint:CGPointMake(squareLength*col + squareLength ,squareLength*row)];
            }
            
            /**
             *  draw right wall, skip the drawing of exit
             */
            if ((cell.wallOpenBitMask & RightWallOpen) || (col == self.theMaze.mazeGraph.width -1 && row == self.theMaze.mazeGraph.height-1)) {
                [wallPath moveToPoint:CGPointMake(squareLength*col + squareLength ,squareLength*row + squareLength)];
            }
            else{
                [wallPath addLineToPoint:CGPointMake(squareLength*col + squareLength ,squareLength*row + squareLength)];
            }
            
            /**
             *  draw top wall,skip the drawing of exist
             */
            if ((cell.wallOpenBitMask & TopWallOpen) || (col == self.theMaze.mazeGraph.width -1 && row == self.theMaze.mazeGraph.height-1)) {
                [wallPath moveToPoint:CGPointMake(squareLength*col,squareLength*row + squareLength)];
            }
            else{
                [wallPath addLineToPoint:CGPointMake(squareLength*col,squareLength*row + squareLength)];
            }
            
            /**
             *  draw left wall,skip the drawing of entrance
             */
            if ((cell.wallOpenBitMask & LeftWallOpen) || (col == 0 && row == 0)) {
                [wallPath moveToPoint:CGPointMake(squareLength*col,squareLength*row)];
            }
            else{
                [wallPath addLineToPoint:CGPointMake(squareLength*col,squareLength*row)];
            }

            
        }
    }
    square.path = [wallPath CGPath];
    square.lineWidth = squareLength / 10.0;
    square.strokeColor = [SKColor blueColor];
    square.fillColor = [SKColor clearColor];
    [self addChild:square];
    NSLog(@"drawAllWallsAsOneNode: %f, %f, %f, %f",square.frame.origin.x,square.frame.origin.y,square.frame.size.width,square.frame.size.height);
}

-(UIBezierPath *)drawWallWithCell:(MazeCell *)cell withSquareLength:(float)squareLength{
    UIBezierPath* wallPath = [[UIBezierPath alloc] init];
    //from origin point, draw bottom line
    [wallPath moveToPoint:CGPointMake(0.0, 0.0)];
    [wallPath addLineToPoint:CGPointMake(30.0,30.0)];
    [wallPath moveToPoint:CGPointMake(100.0, 100.0)];
    [wallPath addLineToPoint:CGPointMake(130.0,130.0)];

    if (cell.wallOpenBitMask & BottomWallOpen) {
        NSLog(@"bootom wall open at %d,%d",cell.x,cell.y);
        
    }
    /*
    //from origin point, draw bottom line
    [wallPath moveToPoint:CGPointMake(0.0, 0.0)];
    if (cell.wallOpenBitMask & BottomWallOpen) {
        [wallPath addLineToPoint:CGPointMake(0.0,squareLength)];
    }
    
    //from origin point, draw bottom line
    [wallPath moveToPoint:CGPointMake(0.0, 0.0)];
    if (cell.wallOpenBitMask & BottomWallOpen) {
        [wallPath addLineToPoint:CGPointMake(0.0,squareLength)];
    }
    
    //from origin point, draw bottom line
    [wallPath moveToPoint:CGPointMake(0.0, 0.0)];
    if (cell.wallOpenBitMask & BottomWallOpen) {
        [wallPath addLineToPoint:CGPointMake(0.0,squareLength)];
    }
    
     */
    
    

    return wallPath;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

}

-(instancetype)initWithMaze:(MazeGenerator *)maze andScreenSize:(CGSize)screenSize{
    self = [super initWithSize:screenSize];
    if(self == nil){
        return nil;
    }
    self.theMaze = maze;
    squareLength = self.size.width / self.theMaze.mazeGraph.width;
    squareWallThickness = squareLength / 10.0;
    return self;
}


-(void)drawWallsWithTubeWallShapeTypeWithColumn:(int)col andRow:(int)row{
    SKShapeNode *square = [SKShapeNode shapeNodeWithRect:CGRectMake(col*squareLength,row*squareLength,squareLength,squareLength)];
    //square.lineWidth = 5;
    //square.strokeColor = [SKColor redColor];
    square.fillColor = UIColorFromRGBA(0xa9e0e7, 0.5);
    [self addChild:square];
    if (ZenDebug) {
        NSLog(@"TubeWall: %f, %f, %f, %f",square.frame.origin.x,square.frame.origin.y,square.frame.size.width,square.frame.size.height);
    }
}

-(void)drawSolutionPath{
    SKShapeNode *solutionPath = [SKShapeNode node];
    UIBezierPath* wallPath = [[UIBezierPath alloc] init];
    //move to the center of (0,0)
    [wallPath moveToPoint:CGPointMake(squareLength / 2, squareLength / 2)];
    for (MazeCell *step in self.theMaze.path) {
        CGRect thisNode = CGRectMake(step.x*squareLength,step.y*squareLength,squareLength,squareLength);
        [wallPath addLineToPoint:CGPointMake(CGRectGetMidX(thisNode), CGRectGetMidY(thisNode))];
        
        if (ZenDebug) {
            NSString *B = (step.wallOpenBitMask & BottomWallOpen) ? @"Y" :@"N";
            NSString *R = (step.wallOpenBitMask & RightWallOpen) ? @"Y" :@"N";
            NSString *T = (step.wallOpenBitMask & TopWallOpen) ? @"Y" :@"N";
            NSString *L = (step.wallOpenBitMask & LeftWallOpen) ? @"Y" :@"N";
            NSLog(@"solutionPath: (%i, %i), OpenWall: B:%@ R:%@ T:%@ L:%@",step.x,step.y,B,R,T,L);
        }
    }
    solutionPath.path = [wallPath CGPath];
    solutionPath.lineWidth = squareLength * 8 / 10;
    solutionPath.strokeColor = [SKColor redColor];
    [self addChild:solutionPath];
}

-(void)update:(NSTimeInterval)currentTime{
    
}

@end