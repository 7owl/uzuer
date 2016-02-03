//
//  DBHelper.h
//      
//
//  Created by wan on 13-2-27.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Key.h"
#import "KeyModel.h"
#import "TimePS.h"
#import "Define.h"

@interface DBHelper : NSObject<NSFetchedResultsControllerDelegate>
{

    NSFetchedResultsController *fetcher;
}

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

//@property (nonatomic, strong, readonly) NSManagedObjectModel *managedObjectModel;
//@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;
//@property (nonatomic, strong, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
//@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

+(DBHelper *) sharedInstance;

//key
-(NSMutableArray*) fetchAdminKeys;
-(NSMutableArray*)fetchKeys;
- (NSMutableArray*) fetchAllKeysWithScienerAccount:(NSString*)userName;
-(NSMutableArray*) fetchAllKeysWithLockName:(NSString*)lockmacname;
-(Key*) fetchKeyWithLockName:(NSString*)lock;

- (Key*) fetchKeyWithLockMac:(NSString*)lockmac;
-(void)saveKey : (KeyModel *)key;
//-(void)updateKey;
-(void)update;
-(void)deleteKey : (Key *)key;



//Timeps
-(void)deleteTimePS : (TimePS *)timePS;
-(void)clearTimePasswordWithLockName:(NSString *)lockName;
-(void)clearAllTimePassword;
-(TimePS*) fetchLastTimePs4LockNamed:(NSString*)lockName;
-(NSMutableArray*) fetchAllTimePassword;
/**
 *如果出了mac地址版本的，需要通过mac读取
 */
-(TimePS*) fetchTimePasswordWithGroup:(TimePsGroup)group index:(int)index lockname:(NSString *)lockname;
/**
 *如果出了mac地址版本的，需要通过mac读取
 */
-(NSMutableArray*) fetchTimePasswordWithLock:(NSString*)lockName group:(TimePsGroup)group;
/**
 *如果出了mac地址版本的，需要通过mac读取
 */
-(NSMutableArray*) fetchTimePasswordWithLock:(NSString*)lockname;
-(BOOL)saveTimePsWithlockName:(NSString*)lockName content:(NSString*)content group:(TimePsGroup)group index:(int16_t)
index;

@end
