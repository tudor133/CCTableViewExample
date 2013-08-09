//
//  ExampleTableView.m
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

#import "IAPTable.h"
#import "ExampleCell.h"
#import "CommonValues.h"

@implementation IAPTable

//provide data to your table
//telling cell size to the table
-(Class)cellClassForTable:(SWTableView *)table {
    return [ExampleCell class];
}

-(CGSize)cellSizeForTable:(SWTableView *)table
{
    return [ExampleCell cellSize];
}

//providing CCNode object for a cell at a given index
-(SWTableViewCell *)table:(SWTableView *)table cellAtIndex:(NSUInteger)idx {
    SWTableViewCell *cell;
    cell = [table dequeueCell];

    
    if (!cell)
    { //there is no recycled cells in the table
        cell = [[ExampleCell new] autorelease]; // create a new one
        cell.anchorPoint = CGPointZero;
        
    }else{
        
        [cell.children removeAllObjects];

    }

    //configure the sprite.. do all kinds of super cool things you can do with cocos2d.
    CCSprite *temp = [CCSprite node];
    GLubyte *buffer = malloc(sizeof(GLubyte)*4);
    for (int i=0;i<4;i++) {buffer[i]=255;}
    CGSize size = [ExampleCell cellSize];
    CCTexture2D *tex = [[CCTexture2D alloc] initWithData:buffer pixelFormat:kCCTexture2DPixelFormat_RGBA8888 pixelsWide:1 pixelsHigh:1 contentSize:size];
    [temp setTexture:tex];
    free(buffer);
    
    temp.color = ccc3(random_range(10, 100), random_range(10, 100), random_range(10, 100));
    temp.textureRect = CGRectMake(0, 0, size.width, size.height);
    temp.opacity = 255;
    
    NSString *cellString = [NSString stringWithFormat:@"IAP %d", idx];
    CCLabelTTF *label = [CCLabelTTF labelWithString:cellString fontName:@"Palatino-Bold" fontSize:21];
    label.position = ccp(size.width/2, size.height/2);
    [temp addChild:label z:0 tag:0];

    temp.anchorPoint = CGPointZero;
    [cell addChild:temp];
    
    return cell;
}
-(NSUInteger)numberOfCellsInTableView:(SWTableView *)table {
    //return a number
    return 16;
}
//touch detection here
-(void)table:(SWTableView *)table cellTouched:(SWTableViewCell *)cell
{
        NSLog(@"IAP touched at index %d",cell.idx);
    
  
}

-(void)dealloc{
    CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);

    
    [super dealloc];
    
}

@end
