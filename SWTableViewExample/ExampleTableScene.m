//
//  ExampleTableScene.m
//
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//
//  Created by Martin Rehder on 06.05.13.
//
#import "HelloWorldLayer.h"
#import "ExampleTableScene.h"
#define isIPad UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad

#define SCREEN [[CCDirector sharedDirector] winSize]
#define DEVICESCALE (isIPad ? 2 : 1)


@implementation ExampleTableScene

+(id) scene
{
    CCScene *scene = [CCScene node];
	ExampleTableScene *layer = [ExampleTableScene node];
	[scene addChild: layer];
	return scene;
}

-(id) init
{
    if( (self=[super initWithColor:ccc4(42, 68, 148, 180)])) 
    {
      //  CGSize size = [[CCDirector sharedDirector] winSize];
        
        
        //add the powerups table
        
        exampleTable = [[ExampleTable alloc] init];

        CGSize tSize = CGSizeMake(SCREEN.width/2, SCREEN.height*0.7);
        myTable = [SWTableView viewWithDataSource:exampleTable size:tSize];
        myTable.position = ccp(SCREEN.width/2-tSize.width/2,SCREEN.height/2-tSize.height/2);
        myTable.delegate = exampleTable; //set if you need touch detection on cells.
        myTable.verticalFillOrder = SWTableViewFillTopDown;
        myTable.direction = SWScrollViewDirectionVertical;
        [self addChild:myTable];
        [myTable reloadData];

        
        //add the costume table
        
        characterTableData=[[CharacterTable alloc] init];
        
        characterTable = [SWTableView viewWithDataSource:characterTableData size:tSize];
        characterTable.position =ccp(SCREEN.width/2-tSize.width/2,SCREEN.height/2-tSize.height/2);
        characterTable.delegate = characterTableData; //set if you need touch detection on cells.
        characterTable.verticalFillOrder = SWTableViewFillTopDown;
        characterTable.direction = SWScrollViewDirectionVertical;
        [characterTable reloadData];
        [self addChild:characterTable];
                
        characterTable.visible=NO;
        
        //add the iap table
        
        iapTableData=[[IAPTable alloc] init];
        
        IAPtable = [SWTableView viewWithDataSource:iapTableData size:tSize];
        IAPtable.position =ccp(SCREEN.width/2-tSize.width/2,SCREEN.height/2-tSize.height/2);
        IAPtable.delegate = iapTableData; //set if you need touch detection on cells.
        IAPtable.verticalFillOrder = SWTableViewFillTopDown;
        IAPtable.direction = SWScrollViewDirectionVertical;
        [IAPtable reloadData];
        [self addChild:IAPtable];
        
        IAPtable.visible=NO;

        
        //the store can have tabs for different types of tables, you just make them visible/ invisible
 
        CCMenuItemLabel *IAP = [CCMenuItemFont itemWithString:@"Iap"  block:^(id sender){
            
            IAPtable.visible=YES;
            characterTable.visible=NO;
            myTable.visible=NO;
            
        }];
        
        CCMenuItemLabel *CHARACTER = [CCMenuItemFont itemWithString:@"Costumes" block:^(id sender){
            
        
           
            IAPtable.visible=NO;
            characterTable.visible=YES;
            myTable.visible=NO;
            
            
            
        }];
        
        CCMenuItemLabel *store = [CCMenuItemFont itemWithString:@"Powerups" block:^(id sender){
            
            
            
            IAPtable.visible=NO;
            characterTable.visible=NO;
            myTable.visible=YES;
            
            
            
        }];

        CCMenu *menu;

         menu = [CCMenu menuWithItems:store, CHARACTER,IAP, nil];
        [menu alignItemsHorizontallyWithPadding:20*DEVICESCALE];
        [menu setPosition:ccp(SCREEN.width/2, SCREEN.height-30)];
        [self addChild: menu z:1];
        
        
        
        
        CCMenuItemLabel *back = [CCMenuItemFont itemWithString:@"Back" block:^(id sender){
            
            
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[HelloWorldLayer scene]]];

            
            
        }];
        
        CCMenu *backMenu;
        
        backMenu = [CCMenu menuWithItems:back, nil];
        [backMenu setPosition:ccp(50,50)];
        [self addChild: backMenu z:1];

    

        
    }
    return self;
}

-(void)dealloc{
    
    CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);

    [characterTableData release];
    [iapTableData release];
    [exampleTable release];
    
    [super dealloc];
}

@end
