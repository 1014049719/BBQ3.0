

#import "logging.h"

// const char* const log_level_names[] = {
//    "INFO", "WARNING", "ERROR", "FATAL" };

/*
static bool IsDebuggerPresent(void)
// Returns true if the current process is being debugged (either
// running under the debugger or has a debugger attached post facto).
{
    int                 junk;
    int                 mib[4];
    struct kinfo_proc   info;
    size_t              size;

    // Initialize the flags so that, if sysctl fails for some bizarre
    // reason, we get a predictable result.

    info.kp_proc.p_flag = 0;

    // Initialize mib, which tells sysctl the info we want, in this case
    // we're looking for information about a specific process ID.

    mib[0] = CTL_KERN;
    mib[1] = KERN_PROC;
    mib[2] = KERN_PROC_PID;
    mib[3] = getpid();

    // Call sysctl.

    size = sizeof(info);
    junk = sysctl(mib, sizeof(mib) / sizeof(*mib), &info, &size, NULL, 0);
    assert(junk == 0);

    // We're being debugged if the P_TRACED flag is set.

    return ( (info.kp_proc.p_flag & P_TRACED) != 0 );
}
*/

//对log文件设置不被iTune、iCloud备份

/*
static BOOL flag_logfile_skipbackup = NO;

BOOL addSkipBackupAttributeToItemAtURL(NSString* sPath)
{
        NSURL* URL = [NSURL fileURLWithPath:sPath isDirectory:NO];
    const char* filePath = [[URL path] fileSystemRepresentation];
    const char* attrName = "com.apple.MobileBackup";
    u_int8_t attrValue = 1;
    int result = setxattr(filePath, attrName, &attrValue, sizeof(attrValue), 0,
0);
    return result == 0;
}

//对log文件设置不被iTune、iCloud备份
int getSkipBackupAttributeToItemAtURL(NSString* sPath)
{
        NSURL* URL = [NSURL fileURLWithPath:sPath isDirectory:NO];
    const char* filePath = [[URL path] fileSystemRepresentation];
    const char* attrName = "com.apple.MobileBackup";
    u_int8_t attrValue = -1;
    getxattr(filePath, attrName, &attrValue, sizeof(attrValue), 0, 0);
    return attrValue;
}
*/

/*
void PrepareLogFile(NSString* filePath)
{
        NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:filePath])
        {
                return;
        }

        //未设置
        if (!flag_logfile_skipbackup &&
getSkipBackupAttributeToItemAtURL(filePath) != 1)
        {
                flag_logfile_skipbackup =
addSkipBackupAttributeToItemAtURL(filePath);
        }
        else
        {
                flag_logfile_skipbackup = YES;
        }

        NSError *err = nil;
        NSDictionary *fileAttributes = [fileManager
attributesOfItemAtPath:filePath error:&err];
    unsigned long long length = [fileAttributes fileSize];
        if (length < LOGFILE_SIZE_LIMIT)
        {
                return;
        }

        BOOL bRet = NO;

        //删除原备份
        NSString* backfilepath = [NSString stringWithFormat:@"%@.bak",
filePath];
    if (![fileManager fileExistsAtPath:backfilepath])
        {
                bRet = [fileManager removeItemAtPath:backfilepath error:&err];
        }
        //新建备份
        bRet = [fileManager copyItemAtPath:filePath toPath:backfilepath
error:&err];
        addSkipBackupAttributeToItemAtURL(backfilepath);

        //删除原文件
        bRet = [fileManager removeItemAtPath:filePath error:&err];
}
*/

void LogMessage(NSString *sClass, NSString *sMethd, const char *file, int line,
                int log_level, NSString *str) {
  /*
  time_t t = time(NULL);
  struct tm tm_time;
  localtime_r(&t, &tm_time);
  NSString *str_newline = [NSString stringWithFormat:@"[%d-%02d-%02d
  %02d:%02d:%02d] [%s] [%@:%@] [%@:%d] %@\r\n",
                                                       tm_time.tm_year, 1 +
  tm_time.tm_mon, tm_time.tm_mday, tm_time.tm_hour, tm_time.tm_min,
  tm_time.tm_sec,
                                                       log_level_names[log_level],
                                                       sClass, sMethd,
                                                       [[NSString
  stringWithUTF8String:file] lastPathComponent], line,
                                                       str];

      // Send to stderr
  fprintf(stderr, "%s", [str_newline
  cStringUsingEncoding:NSUTF8StringEncoding]);

  // Write to log file
      NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
  NSUserDomainMask, YES);
      NSString *documentsDirectoryPath = [paths objectAtIndex:0];
      NSString *filePath = [documentsDirectoryPath
  stringByAppendingPathComponent:@"jyex.log"];
      PrepareLogFile(filePath);

  // NSFileHandle won't create the file for us, so we need to check to make sure
  it exists
  NSFileManager *fileManager = [NSFileManager defaultManager];
  if (![fileManager fileExistsAtPath:filePath])
      {
      // the file doesn't exist yet, so we can just write out the text using the
      // NSString convenience method
      NSError *error = nil;
      BOOL success = [str_newline writeToFile:filePath atomically:YES
  encoding:NSUTF8StringEncoding error:&error];
      if (!success)
              {
          // handle the error
          //            NSLog(@"%@", error);
      }

              if( !flag_logfile_skipbackup &&
  addSkipBackupAttributeToItemAtURL(filePath) )
              {
                      flag_logfile_skipbackup = YES;
              }
  }
      else
      {
      // the file already exists, so we should append the text to the end
      // get a handle to the file
      NSFileHandle *fileHandle = [NSFileHandle
  fileHandleForWritingAtPath:filePath];

      // move to the end of the file
      [fileHandle seekToEndOfFile];
      // convert the string to an NSData object
      NSData *textData = [str_newline dataUsingEncoding:NSUTF8StringEncoding];
      // write the data to the end of the file
      [fileHandle writeData:textData];
      // clean up
      [fileHandle closeFile];
  }

  if (log_level == LOG_LEVEL_FATAL) {
      // display a message or break into the debugger on a fatal error
      if (::IsDebuggerPresent()) {
          // call raise(SIGTRAP); in macro, so debugger will break at correct
  code line.
          // raise(SIGTRAP);
      } else {
          // don't use the string with the newline, get a fresh version to send
  to
          // the debug message process
          exit(1);
      }
  }
  */
}
