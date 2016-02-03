//
//  DBHelper.m
//
//
//  Created by wan on 13-2-27.
//
//

#import "DBHelper.h"
#import "MyLog.h"

@interface DBHelper()



- (NSURL *)applicationDocumentsDirectory;

@end

static DBHelper * dbHelper = nil;
//static NSManagedObjectContext *context = nil;

@implementation DBHelper

@synthesize managedObjectContext;


bool DEBUG_DBHelper = true;

//#define STOREPATH [NSHomeDirectory() stringByAppendingString:@"/Documents/sciener.sqlite"]



+(DBHelper *) sharedInstance {
    
	if (!dbHelper) {
        
		dbHelper = [[DBHelper alloc] init];
	}
    
	return dbHelper;
    
}

//+ (void)initialize
//{
//    
//    
//    [super initialize];
//    NSError *error;
//	NSURL *url = [NSURL fileURLWithPath:STOREPATH];
//	
//	// Init the model, coordinator, context
//	NSManagedObjectModel *managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
//	NSPersistentStoreCoordinator *persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel];
//	if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:&error])
//		NSLog(@"ERROR:INIT COREDATA...Error: %@", [error localizedDescription]);
//	else
//	{
//        
//		context = [[NSManagedObjectContext alloc] init];
//		[context setPersistentStoreCoordinator:persistentStoreCoordinator];
//    }
//	[persistentStoreCoordinator release];
//}


-(TimePS*) fetchLastTimePs4LockNamed:(NSString*)lockName
{
    
    @synchronized(self){
        
        __block NSMutableArray *timePSs;
        
        [self.managedObjectContext performBlockAndWait:^(){
            
            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
            [fetchRequest setEntity:[NSEntityDescription entityForName:@"TimePS" inManagedObjectContext:self.managedObjectContext]];
            // Add a sort descriptor
            //	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"time" ascending:YES selector:nil];
            //	NSArray *descriptors = [NSArray arrayWithObject:sortDescriptor];
            
            [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"(lockname = %@)",lockName]];
            
            //初始化排序对象
            NSSortDescriptor *sort_group = [[NSSortDescriptor alloc] initWithKey:@"group" ascending:NO];
            //初始化第二个排序对象
            NSSortDescriptor *sort_index = [[NSSortDescriptor alloc] initWithKey:@"index" ascending:NO];
            //定义排序数据
            NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sort_index, nil];
            [fetchRequest setSortDescriptors:sortDescriptors];
            
            // Init the fetched results controller
            NSError *error;
            fetcher = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                          managedObjectContext:self.managedObjectContext
                                                            sectionNameKeyPath:nil
                                                                     cacheName:nil];
            fetcher.delegate = self;
            if (![fetcher performFetch:&error])
                NSLog(@"ERROR:FETCH KEYS...Error: %@", [error localizedDescription]);
            
            
            timePSs = [NSMutableArray arrayWithArray:fetcher.fetchedObjects];
            
            
        }];
        
        if (timePSs) {
            return [timePSs lastObject];
        }
        return Nil;
    }
}

-(NSMutableArray*) fetchAllTimePassword
{
    
    @synchronized(self){
        
        __block NSMutableArray *timePSs;
        
        [self.managedObjectContext performBlockAndWait:^(){
            
            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
            [fetchRequest setEntity:[NSEntityDescription entityForName:@"TimePS" inManagedObjectContext:self.managedObjectContext]];
            // Add a sort descriptor
            //	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"time" ascending:YES selector:nil];
            //	NSArray *descriptors = [NSArray arrayWithObject:sortDescriptor];
            
            //            [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"(lockname = %@) and (group = %@)",lockname,group]];
            
            //初始化排序对象
            //            NSSortDescriptor *sort_group = [[NSSortDescriptor alloc] initWithKey:@"group" ascending:NO];
            //            //初始化第二个排序对象
            //            NSSortDescriptor *sort_index = [[NSSortDescriptor alloc] initWithKey:@"index" ascending:NO];
            //            //定义排序数据
            //            NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sort_index, nil];
            //            //    fetchRequest.sortDescriptors = sortDescriptors;//设置查询请求的排序条件
            //            [fetchRequest setSortDescriptors:sortDescriptors];
            //
            //            //            [sort_group release];
            //            [sort_index release];
            //            [sortDescriptors release];
            
            // Init the fetched results controller
            NSError *error;
            fetcher = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                          managedObjectContext:self.managedObjectContext
                                                            sectionNameKeyPath:nil
                                                                     cacheName:nil];
            fetcher.delegate = self;
            if (![fetcher performFetch:&error])
                NSLog(@"ERROR:FETCH KEYS...Error: %@", [error localizedDescription]);
            
            
            timePSs = [NSMutableArray arrayWithArray:fetcher.fetchedObjects];
            
            
            
        }];
        
        return timePSs;
    }
    
}

-(TimePS*) fetchTimePasswordWithGroup:(TimePsGroup)group index:(int)index lockname:(NSString *)lockname
{
    
    [MyLog log:[NSString stringWithFormat:@"group:%i,index:%i,lockname:%@",group,index,lockname] isdebug:DEBUG_DBHelper];
    
    @synchronized(self){
        
        __block NSMutableArray *timePSs;
        
        [self.managedObjectContext performBlockAndWait:^(){
            
            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
            [fetchRequest setEntity:[NSEntityDescription entityForName:@"TimePS" inManagedObjectContext:self.managedObjectContext]];
            // Add a sort descriptor
            //	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"time" ascending:YES selector:nil];
            //	NSArray *descriptors = [NSArray arrayWithObject:sortDescriptor];
            
            [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"(index = %i) and (group = %i) and (lockname = %@)",index,group,lockname]];
            
            //初始化排序对象
            //            NSSortDescriptor *sort_group = [[NSSortDescriptor alloc] initWithKey:@"group" ascending:NO];
            //初始化第二个排序对象
            NSSortDescriptor *sort_index = [[NSSortDescriptor alloc] initWithKey:@"index" ascending:NO];
            //定义排序数据
            NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sort_index, nil];
            //    fetchRequest.sortDescriptors = sortDescriptors;//设置查询请求的排序条件
            [fetchRequest setSortDescriptors:sortDescriptors];
            
            
            // Init the fetched results controller
            NSError *error;
            fetcher = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                          managedObjectContext:self.managedObjectContext
                                                            sectionNameKeyPath:nil
                                                                     cacheName:nil];
            fetcher.delegate = self;
            if (![fetcher performFetch:&error])
                NSLog(@"ERROR:FETCH KEYS...Error: %@", [error localizedDescription]);
            
            
            timePSs = [NSMutableArray arrayWithArray:fetcher.fetchedObjects];
            
            
            
        }];
        
        if (timePSs && timePSs.count>0 ) {
            
            return [timePSs objectAtIndex:0];
        }
        return Nil;
    }
}

-(NSMutableArray*) fetchTimePasswordWithLock:(NSString*)lockname group:(TimePsGroup)group
{
    
    @synchronized(self){
        
        __block NSMutableArray *timePSs;
        
        [self.managedObjectContext performBlockAndWait:^(){
            
            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
            [fetchRequest setEntity:[NSEntityDescription entityForName:@"TimePS" inManagedObjectContext:self.managedObjectContext]];
            // Add a sort descriptor
            //	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"time" ascending:YES selector:nil];
            //	NSArray *descriptors = [NSArray arrayWithObject:sortDescriptor];
            
            [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"(lockname = %@) and (group = %i)",lockname,group]];
            
            //初始化排序对象
            //            NSSortDescriptor *sort_group = [[NSSortDescriptor alloc] initWithKey:@"group" ascending:NO];
            //初始化第二个排序对象
            NSSortDescriptor *sort_index = [[NSSortDescriptor alloc] initWithKey:@"index" ascending:YES];
            //定义排序数据
            NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sort_index, nil];
            //    fetchRequest.sortDescriptors = sortDescriptors;//设置查询请求的排序条件
            [fetchRequest setSortDescriptors:sortDescriptors];
            
            
            // Init the fetched results controller
            NSError *error;
            fetcher = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                          managedObjectContext:self.managedObjectContext
                                                            sectionNameKeyPath:nil
                                                                     cacheName:nil];
            fetcher.delegate = self;
            if (![fetcher performFetch:&error])
                NSLog(@"ERROR:FETCH KEYS...Error: %@", [error localizedDescription]);
            
            
            timePSs = [NSMutableArray arrayWithArray:fetcher.fetchedObjects];
            
            
        }];
        
        return timePSs;
    }
}

-(NSMutableArray*) fetchTimePasswordWithLock:(NSString*)lockname
{
    
    @synchronized(self){
        
        __block NSMutableArray *timePSs;
        
        [self.managedObjectContext performBlockAndWait:^(){
            
            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
            [fetchRequest setEntity:[NSEntityDescription entityForName:@"TimePS" inManagedObjectContext:self.managedObjectContext]];
            // Add a sort descriptor
            //	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"time" ascending:YES selector:nil];
            //	NSArray *descriptors = [NSArray arrayWithObject:sortDescriptor];
            
            [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"(lockname = %@)",lockname]];
            
            //初始化排序对象
            NSSortDescriptor *sort_group = [[NSSortDescriptor alloc] initWithKey:@"group" ascending:NO];
            //初始化第二个排序对象
            NSSortDescriptor *sort_index = [[NSSortDescriptor alloc] initWithKey:@"index" ascending:NO];
            //定义排序数据
            NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sort_group,sort_index, nil];
            //    fetchRequest.sortDescriptors = sortDescriptors;//设置查询请求的排序条件
            [fetchRequest setSortDescriptors:sortDescriptors];
            
            
            // Init the fetched results controller
            NSError *error;
            fetcher = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                          managedObjectContext:self.managedObjectContext
                                                            sectionNameKeyPath:nil
                                                                     cacheName:nil];
            fetcher.delegate = self;
            if (![fetcher performFetch:&error])
                NSLog(@"ERROR:FETCH KEYS...Error: %@", [error localizedDescription]);
            
            
            timePSs = [NSMutableArray arrayWithArray:fetcher.fetchedObjects];
            
            
        }];
        
        return timePSs;
    }
}

-(BOOL)saveTimePsWithlockName:(NSString*)lockName content:(NSString*)content group:(TimePsGroup)group index:(int16_t)index
{
    
    __block BOOL success = FALSE;
    
    @synchronized(self){
        
        [self.managedObjectContext performBlockAndWait:^(){
            
            // Insert timeps
            TimePS *msgInstance = (TimePS*)[NSEntityDescription insertNewObjectForEntityForName:@"TimePS"
                                                                         inManagedObjectContext:self.managedObjectContext];
            
            msgInstance.lockname = lockName;
            msgInstance.content = content;
            msgInstance.group = group;
            msgInstance.index = index;
            
            // Save the data
            NSError *error = nil;
            if (![self.managedObjectContext save:&error]){
                
                NSLog(@"ERROR:INSERT KEY FAIL...Error LOG: %@", [error localizedDescription]);
                success =  NO;
            }else{
                
                success = YES;
            }
        }];
    }
    
    return success;
}



-(void)clearAllTimePassword
{
    
    NSMutableArray * array = [self fetchAllTimePassword];
    for (TimePS * ps in array) {
        
        [self deleteTimePS:ps];
    }
    
}

-(void)clearTimePasswordWithLockName:(NSString *)lockName
{
    
    NSMutableArray * array = [self fetchTimePasswordWithLock:lockName];
    for (TimePS * ps in array) {
        
        [self deleteTimePS:ps];
    }
    
}

-(void)deleteTimePS : (TimePS *)timePS
{
    
    @synchronized(self){
        
        [self.managedObjectContext performBlockAndWait:^(){
            
            [self.managedObjectContext deleteObject:timePS];
            NSError* error = nil;
            if (![self.managedObjectContext save:&error])
                NSLog(@"ERROR:DELETE KEY FAIL...Error LOG: %@", [error localizedDescription]);
        }];
    }
    
}

- (NSMutableArray*) fetchAdminKeys
{
    @synchronized(self){
        __block NSMutableArray *keys;
        [self.managedObjectContext performBlockAndWait:^(){
            
            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
            [fetchRequest setEntity:[NSEntityDescription entityForName:@"Key" inManagedObjectContext:self.managedObjectContext]];
            // Add a sort descriptor
            //	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"time" ascending:YES selector:nil];
            //	NSArray *descriptors = [NSArray arrayWithObject:sortDescriptor];
            
            //    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"(from = %@)or(to = %@)",buddySelected.uid,buddySelected.uid]];
            [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"isAdmin = %i",1]];
            
            //初始化排序对象
            NSSortDescriptor *sort_doorName = [[NSSortDescriptor alloc] initWithKey:@"doorName" ascending:YES];
            //初始化第二个排序对象
            //    NSSortDescriptor *sort_isAdmin = [[NSSortDescriptor alloc] initWithKey:@"isAdmin" ascending:NO];
            //定义排序数据
            NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sort_doorName, nil];
            //    fetchRequest.sortDescriptors = sortDescriptors;//设置查询请求的排序条件
            [fetchRequest setSortDescriptors:sortDescriptors];
            
            
            // Init the fetched results controller
            NSError *error;
            fetcher = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                          managedObjectContext:self.managedObjectContext
                                                            sectionNameKeyPath:nil
                                                                     cacheName:nil];
            fetcher.delegate = self;
            if (![fetcher performFetch:&error])
                NSLog(@"ERROR:FETCH KEYS...Error: %@", [error localizedDescription]);
            
            
            keys = [NSMutableArray arrayWithArray:fetcher.fetchedObjects];
            [MyLog log:@"fetch key" isdebug:DEBUG_DBHelper];
            
            
            fetcher = nil;
            fetchRequest = nil;
        }];
        
        
        return keys;
    }
   
}

- (NSMutableArray*) fetchKeys
{
    @synchronized(self){
        __block NSMutableArray *keys;
        [MyLog log:@"fetch keys" isdebug:DEBUG_DBHelper];
        [self.managedObjectContext performBlockAndWait:^(){
            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
            [fetchRequest setEntity:[NSEntityDescription entityForName:@"Key" inManagedObjectContext:self.managedObjectContext]];
            // Add a sort descriptor
            //	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"time" ascending:YES selector:nil];
            //	NSArray *descriptors = [NSArray arrayWithObject:sortDescriptor];
            
            //    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"(from = %@)or(to = %@)",buddySelected.uid,buddySelected.uid]];
            
            //初始化排序对象
            NSSortDescriptor *sort_doorName = [[NSSortDescriptor alloc] initWithKey:@"doorName" ascending:YES];
            //初始化第二个排序对象
            //    NSSortDescriptor *sort_isAdmin = [[NSSortDescriptor alloc] initWithKey:@"isAdmin" ascending:NO];
            //定义排序数据
            NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sort_doorName, nil];
            //    fetchRequest.sortDescriptors = sortDescriptors;//设置查询请求的排序条件
            [fetchRequest setSortDescriptors:sortDescriptors];
            // Init the fetched results controller
            NSError *error;
            fetcher = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                          managedObjectContext:self.managedObjectContext
                                                            sectionNameKeyPath:nil
                                                                     cacheName:nil];
            fetcher.delegate = self;
            if (![fetcher performFetch:&error])
                NSLog(@"ERROR:FETCH KEYS...Error: %@", [error localizedDescription]);
            
            
            keys = [NSMutableArray arrayWithArray:fetcher.fetchedObjects];
            
            [MyLog log:@"fetch key" isdebug:DEBUG_DBHelper];
            
            
            fetcher = nil;
            fetchRequest = nil;
        }];
       
        
        return keys;
    }
    
}

- (NSMutableArray*) fetchAllKeysWithScienerAccount:(NSString*)userName
{
    @synchronized(self){
        __block NSMutableArray *keys;
        [self.managedObjectContext performBlockAndWait:^(){
            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
            [fetchRequest setEntity:[NSEntityDescription entityForName:@"Key" inManagedObjectContext:self.managedObjectContext]];
            // Add a sort descriptor
            //	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"time" ascending:YES selector:nil];
            //	NSArray *descriptors = [NSArray arrayWithObject:sortDescriptor];
            
            [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"scienerAccount = %@ and isAdmin = %i",userName,1]];
            
            //初始化排序对象
            NSSortDescriptor *sort_doorName = [[NSSortDescriptor alloc] initWithKey:@"doorName" ascending:YES];
            //初始化第二个排序对象
            //    NSSortDescriptor *sort_isAdmin = [[NSSortDescriptor alloc] initWithKey:@"isAdmin" ascending:NO];
            //定义排序数据
            NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sort_doorName, nil];
            //    fetchRequest.sortDescriptors = sortDescriptors;//设置查询请求的排序条件
            [fetchRequest setSortDescriptors:sortDescriptors];
            
            // Init the fetched results controller
            NSError *error;
            fetcher = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                          managedObjectContext:self.managedObjectContext
                                                            sectionNameKeyPath:nil
                                                                     cacheName:nil];
            fetcher.delegate = self;
            
            
            if (![fetcher performFetch:&error])
                NSLog(@"ERROR:FETCH KEYS...Error: %@", [error localizedDescription]);
            
            keys = [NSMutableArray arrayWithArray:fetcher.fetchedObjects];
            
            
            fetcher = nil;
            fetchRequest = nil;
        }];
        
        
        return keys;
    }
    
}

- (NSMutableArray*) fetchAllKeysWithLockName:(NSString*)lockmacname
{
    
    @synchronized(self){
        
        __block NSMutableArray *keys;
        
        [self.managedObjectContext performBlockAndWait:^(){
            
            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
            [fetchRequest setEntity:[NSEntityDescription entityForName:@"Key" inManagedObjectContext:self.managedObjectContext]];
            // Add a sort descriptor
            //	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"time" ascending:YES selector:nil];
            //	NSArray *descriptors = [NSArray arrayWithObject:sortDescriptor];
            
            [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"lockName = %@",lockmacname]];
            
            
            //初始化排序对象
            NSSortDescriptor *sort_doorName = [[NSSortDescriptor alloc] initWithKey:@"doorName" ascending:YES];
            //初始化第二个排序对象
            //    NSSortDescriptor *sort_isAdmin = [[NSSortDescriptor alloc] initWithKey:@"isAdmin" ascending:NO];
            //定义排序数据
            NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sort_doorName, nil];
            //    fetchRequest.sortDescriptors = sortDescriptors;//设置查询请求的排序条件
            [fetchRequest setSortDescriptors:sortDescriptors];
            
            
            
            
            // Init the fetched results controller
            NSError *error;
            fetcher = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                          managedObjectContext:self.managedObjectContext
                                                            sectionNameKeyPath:nil
                                                                     cacheName:nil];
            fetcher.delegate = self;
            
            
            if (![fetcher performFetch:&error])
                NSLog(@"ERROR:FETCH KEYS...Error: %@", [error localizedDescription]);
            keys = [NSMutableArray arrayWithArray:fetcher.fetchedObjects];
            fetcher = nil;
            fetchRequest = nil;
        }];
       
        
        return keys;
    }
    
}

- (Key*) fetchKeyWithLockName:(NSString*)lockname
{
    
    @synchronized(self){
        
        __block NSMutableArray *keys=nil;
        
        [self.managedObjectContext performBlockAndWait:^(){

            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
            [fetchRequest setEntity:[NSEntityDescription entityForName:@"Key" inManagedObjectContext:self.managedObjectContext]];
            // Add a sort descriptor
            //	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"time" ascending:YES selector:nil];
            //	NSArray *descriptors = [NSArray arrayWithObject:sortDescriptor];
            
            [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"lockName = %@",lockname]];
            
            
            //初始化排序对象
            NSSortDescriptor *sort_doorName = [[NSSortDescriptor alloc] initWithKey:@"doorName" ascending:YES];
            //初始化第二个排序对象
            //    NSSortDescriptor *sort_isAdmin = [[NSSortDescriptor alloc] initWithKey:@"isAdmin" ascending:NO];
            //定义排序数据
            NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sort_doorName, nil];
            //    fetchRequest.sortDescriptors = sortDescriptors;//设置查询请求的排序条件
            [fetchRequest setSortDescriptors:sortDescriptors];
            
            
            
            
            // Init the fetched results controller
            NSError *error;
            fetcher = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                          managedObjectContext:self.managedObjectContext
                                                            sectionNameKeyPath:nil
                                                                     cacheName:nil];
            fetcher.delegate = self;
            
            
            if (![fetcher performFetch:&error])
                NSLog(@"ERROR:FETCH KEYS...Error: %@", [error localizedDescription]);
            
            keys = [NSMutableArray arrayWithArray:fetcher.fetchedObjects];
            
            
            fetcher = nil;
            fetchRequest = nil;
        }];
       
        
        if ([keys count]>0) {
            
            return [keys objectAtIndex:0];
        }else{
            
            return nil;
        }
    }
}

- (Key*) fetchKeyWithLockMac:(NSString*)lockmac
{
    
    @synchronized(self){
        
        __block NSMutableArray *keys=nil;
        
        [self.managedObjectContext performBlockAndWait:^(){
            
            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
            [fetchRequest setEntity:[NSEntityDescription entityForName:@"Key" inManagedObjectContext:self.managedObjectContext]];
            // Add a sort descriptor
            //	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"time" ascending:YES selector:nil];
            //	NSArray *descriptors = [NSArray arrayWithObject:sortDescriptor];
            
            [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"lockmac = %@",lockmac]];
            
            
            //初始化排序对象
            NSSortDescriptor *sort_doorName = [[NSSortDescriptor alloc] initWithKey:@"doorName" ascending:YES];
            //初始化第二个排序对象
            //    NSSortDescriptor *sort_isAdmin = [[NSSortDescriptor alloc] initWithKey:@"isAdmin" ascending:NO];
            //定义排序数据
            NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sort_doorName, nil];
            //    fetchRequest.sortDescriptors = sortDescriptors;//设置查询请求的排序条件
            [fetchRequest setSortDescriptors:sortDescriptors];
            
            
            
            
            // Init the fetched results controller
            NSError *error;
            fetcher = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                          managedObjectContext:self.managedObjectContext
                                                            sectionNameKeyPath:nil
                                                                     cacheName:nil];
            fetcher.delegate = self;
            
            
            if (![fetcher performFetch:&error])
                NSLog(@"ERROR:FETCH KEYS...Error: %@", [error localizedDescription]);
            
            keys = [NSMutableArray arrayWithArray:fetcher.fetchedObjects];
            
            
            fetcher = nil;
            fetchRequest = nil;
        }];
        
        
        if ([keys count]>0) {
            
            return [keys objectAtIndex:0];
        }else{
            
            return nil;
        }
    }
}

-(void)saveKey : (KeyModel *)key
{
    
    @synchronized(self){
        
        [self.managedObjectContext performBlockAndWait:^(){
            
            // Insert key
            Key *keyInstance = (Key*)[NSEntityDescription insertNewObjectForEntityForName:@"Key"
                                                                   inManagedObjectContext:self.managedObjectContext];
            
            
            keyInstance.day1PsIndex = key.day1PsIndex;
            keyInstance.day2PsIndex = key.day2PsIndex;
            keyInstance.day3PsIndex = key.day3PsIndex;
            keyInstance.day4PsIndex = key.day4PsIndex;
            keyInstance.day5PsIndex = key.day5PsIndex;
            keyInstance.day6PsIndex = key.day6PsIndex;
            keyInstance.day7PsIndex = key.day7PsIndex;
            keyInstance.day10mPsIndex = key.day10mPsIndex;
            keyInstance.deletePs = key.deletePs;
            keyInstance.deletePsTmp = key.deletePsTmp;
            keyInstance.desc = key.desc;
            keyInstance.doorName = key.doorName;
            keyInstance.key = key.key;
            keyInstance.endDate = key.endDate;
            keyInstance.hasbackup = key.hasbackup;
            keyInstance.unlockFlag = key.unlockFlag;
            keyInstance.isAdmin = key.isAdmin;
            keyInstance.isShared = key.isShared;
            keyInstance.kid = key.kid;
            keyInstance.lockmac = key.lockmac;
            keyInstance.lockName = key.lockName;
            keyInstance.adminKeyboardPs = key.adminKeyboardPs;
            keyInstance.adminKeyboardPsTmp = key.adminKeyboardPsTmp;
            keyInstance.password = key.password;
            keyInstance.startDate = key.startDate;
            keyInstance.username = key.username;
            keyInstance.version = key.version;
            keyInstance.roomid = key.roomid;
            keyInstance.date = key.date;
            keyInstance.aseKey = key.aseKey;
            keyInstance.mac = key.mac;
            
            
            // Save the data
            NSError *error = nil;
            if (![self.managedObjectContext save:&error])
                NSLog(@"ERROR:INSERT KEY FAIL...Error LOG: %@", [error localizedDescription]);
            
        }];
       
    }
    
    
    
}

//-(void)updateKey
//{
//
//    
//    [self.managedObjectContext performBlockAndWait:^(){
//        
//        NSError *error = nil;
//        if (![self.managedObjectContext save:&error])
//            NSLog(@"ERROR:INSERT KEY FAIL...Error LOG: %@", [error localizedDescription]);
//    }];
//}

-(void)deleteKey : (Key *)key
{
    
    [self.managedObjectContext performBlockAndWait:^(){
         
         if (key!=nil) {
             
             [self.managedObjectContext deleteObject:key];
             
             NSError* error = nil;
             
             if (![self.managedObjectContext save:&error])
                 NSLog(@"ERROR:DELETE KEY FAIL...Error LOG: %@", [error localizedDescription]);
             
         }
         
     }];
    
}

-(void)update
{
    
    [self.managedObjectContext performBlockAndWait:^(){
        
        NSError *error = nil;
        if (![self.managedObjectContext save:&error])
            NSLog(@"ERROR:INSERT KEY FAIL...Error LOG: %@", [error localizedDescription]);
    }];
}

//-(void)clearKeys
//{
//    
//    [context deletedObjects];
//    NSError* error;
//    if (![context save:&error])
//        NSLog(@"ERROR:CLEAR KEYS FAIL...Error LOG: %@", [error localizedDescription]);
//    
//}



#pragma mark - Core Data stack

/*
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *) managedObjectContext
{

//    [MyLog log:@"升级数据库" isdebug:YES];
    if (managedObjectContext !=nil) {
        
        return managedObjectContext;
    }

    
//    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"sciener" withExtension:@"sqlite"];
//    NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];

    NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"sciener.sqlite"];
    
    /*
     Set up the store.
     For the sake of illustration, provide a pre-populated default store.
     */
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // If the expected store doesn't exist, copy the default store.
    if (![fileManager fileExistsAtPath:[storeURL path]]) {
        
        NSLog(@"NSPersistentStoreCoordinator copy");
        
        NSURL *defaultStoreURL = [[NSBundle mainBundle] URLForResource:@"sciener" withExtension:@"sqlite"];
        
        if (defaultStoreURL) {
            
            [fileManager copyItemAtURL:defaultStoreURL toURL:storeURL error:NULL];
        }
        
    }
    
    
    
    NSPersistentStoreCoordinator *persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: model];
    
    NSError *error;
    
//    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
//        NSLog(@"ERROR:INIT COREDATA...Error: %@", [error localizedDescription]);
//    }else{
//        
//        managedObjectContext = [[NSManagedObjectContext alloc]
//                   initWithConcurrencyType:NSPrivateQueueConcurrencyType];
////		managedObjectContext = [[NSManagedObjectContext alloc] init];
//		[managedObjectContext setPersistentStoreCoordinator:persistentStoreCoordinator];
//    }

    
    
    
    
        
        
    //TODO 数据库升级用这个，这个NSMigratePersistentStoresAutomaticallyOption和NSInferMappingModelAutomaticallyOption都为yes，就是自动升级，也就是轻量级的数据库迁移。为no的话，就是手动升级，另外一种数据库迁移方法，针对复杂的数据库升级
    
    //自动升级
    NSDictionary *options = @{NSMigratePersistentStoresAutomaticallyOption: @YES, NSInferMappingModelAutomaticallyOption: @YES};
    
    //手动升级
//    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES],
//                                       NSMigratePersistentStoresAutomaticallyOption,
//                                       [NSNumber numberWithBool:NO],
//                                       NSInferMappingModelAutomaticallyOption,
//                                       nil];
    
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        
        
        abort();
    }else{
        
        managedObjectContext = [[NSManagedObjectContext alloc]
                                initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        //		managedObjectContext = [[NSManagedObjectContext alloc] init];
		[managedObjectContext setPersistentStoreCoordinator:persistentStoreCoordinator];
    }
    
    
    
    return managedObjectContext;
    
}




/*
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
//- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
//{
//    if (persistentStoreCoordinator != nil) {
//        return persistentStoreCoordinator;
//    }
//    
//    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"sciener.sqlite"];
//
//    /*
//     Set up the store.
//     For the sake of illustration, provide a pre-populated default store.
//     */
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    // If the expected store doesn't exist, copy the default store.
//    if (![fileManager fileExistsAtPath:[storeURL path]]) {
//
//        
//        NSURL *defaultStoreURL = [[NSBundle mainBundle] URLForResource:@"sciener" withExtension:@"sqlite"];
//        if (defaultStoreURL) {
//            [fileManager copyItemAtURL:defaultStoreURL toURL:storeURL error:NULL];
//        }
//    }
//    
//    NSDictionary *options = @{NSMigratePersistentStoresAutomaticallyOption: @YES, NSInferMappingModelAutomaticallyOption: @YES};
//    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: [self managedObjectModel]];
//
//    NSError *error;
//
//    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
//        NSLog(@"ERROR:INIT COREDATA...Error: %@", [error localizedDescription]);
//    }
//    
//    //数据库更新的时候使用
//    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
//        /*
//         Replace this implementation with code to handle the error appropriately.
//         
//         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//         
//         Typical reasons for an error here include:
//         * The persistent store is not accessible;
//         * The schema for the persistent store is incompatible with current managed object model.
//         Check the error message to determine what the actual problem was.
//         
//         
//         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
//         
//         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
//         * Simply deleting the existing store:
//         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
//         
//         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
//         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
//         
//         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
//         
//         */
//        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
//        abort();
//    }
//
//    return persistentStoreCoordinator;
//}


#pragma mark - Application's documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
