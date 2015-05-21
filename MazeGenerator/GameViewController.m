//
//  GameViewController.m
//  SpeedMaze
//
//  Created by littlebeef on 11/20/14.
//  Copyright (c) 2014 beefSama. All rights reserved.
//

#import "GameViewController.h"
#import "GameScene.h"
#import "MazeGenerator.h"


@implementation SKScene (Unarchive)

+ (instancetype)unarchiveFromFile:(NSString *)file {
    /* Retrieve scene file path from the application bundle */
    NSString *nodePath = [[NSBundle mainBundle] pathForResource:file ofType:@"sks"];
    /* Unarchive the file to an SKScene object */
    NSData *data = [NSData dataWithContentsOfFile:nodePath
                                          options:NSDataReadingMappedIfSafe
                                            error:nil];
    NSKeyedUnarchiver *arch = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    [arch setClass:self forClassName:@"SKScene"];
    SKScene *scene = [arch decodeObjectForKey:NSKeyedArchiveRootObjectKey];
    [arch finishDecoding];
    
    return scene;
}

@end

@implementation GameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    /*
    for (int i = 0; i < 100; i++) {
        NSLog(@"int: %u",arc4random_uniform(10));
    }
     */
    /*
    NSNumber *one = [NSNumber numberWithInt:1];
    NSNumber *pointToOne = one;
    NSLog(@"first: %@, %@", [one stringValue],[pointToOne stringValue]);//1,1
    one = [NSNumber numberWithInt:2];
    NSLog(@"second: %@, %@", [one stringValue],[pointToOne stringValue]);//2,1
    */
    /*
    NSMutableArray *strings = [NSMutableArray arrayWithObjects:@"1",@"2", nil];
    NSMutableArray *pointer = strings;
    [strings addObject:@"3"];
    NSLog(@"%@",pointer);//1,2,3
     */
    MazeGenerator *testMaze = [[MazeGenerator alloc] initMazeWithWidth:10 height:10];
    [testMaze defaultGenerateMaze];
    [testMaze defaultSolveMaze];
    NSLog(@"%lu",testMaze.path.count);
    for (MazeCell *step in testMaze.path) {
        NSLog(@"(%i,%i)",step.x,step.y);

    }
    // ⅃
    /*
     //whole maze
    for (int i = 0; i < 5; i++) {
        for (int j = 0; j < 5; j++) {
           NSLog(@"(%i,%i)",((MazeCell *)testMaze.mazeGraph.cells[i][j]).x,((MazeCell *)testMaze.mazeGraph.cells[i][j]).y);
        }
    }
    */
    //NSLog(@"(%i,%i)",((MazeCell *)testMaze.mazeGraph.cells[i][j]),((MazeCell *)testMaze.mazeGraph.cells[i][j]));

    for (int j = 0; j < 9; j++) {
        
        NSString *row = @"";
        for (int i = 0; i < 9; i++) {
            if(![testMaze.mazeGraph areConnectedBetween:((MazeCell *)testMaze.mazeGraph.cells[i][j]) and:((MazeCell *)testMaze.mazeGraph.cells[i+1][j])]){
                if(![testMaze.mazeGraph areConnectedBetween:((MazeCell *)testMaze.mazeGraph.cells[i][j]) and:((MazeCell *)testMaze.mazeGraph.cells[i][j+1])]){
                    row=[row stringByAppendingString:@" "];
                }
                else{
                    row=[row stringByAppendingString:@"_"];
                }
            }
            else{
                if(![testMaze.mazeGraph areConnectedBetween:((MazeCell *)testMaze.mazeGraph.cells[i][j]) and:((MazeCell *)testMaze.mazeGraph.cells[i][j+1])]){
                    row=[row stringByAppendingString:@"|"];
                }
                else{
                    row=[row stringByAppendingString:@">"];
                }
            }
        }
        NSLog(@"%@",row);
    }

    
    
    
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    /* Sprite Kit applies additional optimizations to improve rendering performance */
    skView.ignoresSiblingOrder = YES;
    
    // Create and configure the scene.
    GameScene *scene = [GameScene unarchiveFromFile:@"GameScene"];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:scene];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
