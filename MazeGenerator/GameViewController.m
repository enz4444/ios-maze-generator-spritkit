//
//  GameViewController.m
//  SpeedMaze
//
//  Created by littlebeef on 11/20/14.
//  Copyright (c) 2014 beefSama. All rights reserved.
//

#import "GameViewController.h"


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
    MazeGenerator *testMaze;
    @try {
        int mazeWidth = 10;
        int mazeHeight = 10;
        testMaze = [[MazeGenerator alloc] initMazeWithWidth:mazeWidth height:mazeHeight];
        [testMaze defaultMaze];
        //print solution path
        if (ZenDebug) {
            for (MazeCell *step in testMaze.path) {
                NSLog(@"(%i,%i)",step.x,step.y);
                
            }
        }
        
        //ASCII maze no right,bottom walls // ⅃
        if (ZenDebug) {
            for (int j = 0; j < mazeHeight-1; j++) {
                NSString *row = @"";
                for (int i = 0; i < mazeWidth-1; i++) {
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
        }
        

    }
    @catch (NSException *exception) {
        NSLog(@"Error: failure to generate default maze. \nDescription: %@", exception.description);

    }
    @finally {
        
    }
    
    if (testMaze) {
        SKView * mazeSKView = [[SKView alloc] initWithFrame:CGRectMake(0, 0, ZenSW, ZenSW)];
        SKView * skView = (SKView *)self.view;
        // Configure the view.

        MazeScene *mazeScene = [[MazeScene alloc] initWithMaze:testMaze andScreenSize:CGSizeMake(skView.frame.size.width, skView.frame.size.width)];
        mazeScene.scaleMode = SKSceneScaleModeAspectFit;
        mazeScene.backgroundColor = [UIColor whiteColor];
        //mazeScene.position = CGPointMake(ZenSW / 2, ZenSW / 2);
        //mazeScene.frame = CGRectMake(0, 0, skView.frame.size.width, skView.frame.size.width);
        NSLog(@"casted skView: %f, %f, %f, %f",skView.frame.origin.x,skView.frame.origin.y,skView.frame.size.width,skView.frame.size.height);
        mazeSKView.showsFPS = YES;
        mazeSKView.showsDrawCount = YES;
        mazeSKView.showsQuadCount = YES;
        mazeSKView.showsPhysics = YES;
        mazeSKView.showsFields = YES;
        mazeSKView.showsNodeCount = YES;
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = YES;
        mazeSKView.ignoresSiblingOrder = YES;
        // otherwise the game view is in center, can't set its position nor frame
        [skView addSubview:mazeSKView];
        // Present the scene.
        [mazeSKView presentScene:mazeScene];
    }
    else{
        // Configure the view.
        SKView * skView = (SKView *)self.view;
        skView.showsFPS = YES;
        skView.showsDrawCount = YES;
        skView.showsQuadCount = YES;
        skView.showsPhysics = YES;
        skView.showsFields = YES;
        skView.showsNodeCount = YES;
        skView.ignoresSiblingOrder = YES;
        
        // Create and configure the scene.
        GameScene *scene = [GameScene unarchiveFromFile:@"GameScene"];
        scene.scaleMode = SKSceneScaleModeAspectFill;
        
        // Present the scene.
        [skView presentScene:scene];
    }
    
    
    
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
