
//get ptm ratio
#define isIPad UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad
#define PTM_RATIO (isIPad ? 64 : 32)
#define DEVICESCALE (isIPad ? 2 : 1)

//convenience measurements
#define SCREEN [[CCDirector sharedDirector] winSize]
#define CURTIME CACurrentMediaTime()

//convenience functions
#define random_range(low,high) (arc4random()%(high-low+1))+low
#define frandom (float)arc4random()/UINT64_C(0x100000000)
#define frandom_range(low,high) ((high-low)*frandom)+low




