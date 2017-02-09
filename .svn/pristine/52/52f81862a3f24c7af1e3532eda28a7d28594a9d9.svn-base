#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


// (acher): these code was borrowed from Chromium project.
// to be continued...
typedef enum {
    LOG_LEVEL_INFO = 0,
    LOG_LEVEL_WARNING = 1,
    LOG_LEVEL_ERROR = 2,
    LOG_LEVEL_FATAL = 3,
} LOG_LEVEL;

#define LOGFILE_SIZE_LIMIT 1*1024*1024

// use these four macros to log message, the usage is same as NSLog().
// only LOG_ERROR and LOG_FATAL work in distribution.
#define LOG_ERROR(format, ...)      LOG(LOG_LEVEL_ERROR, format, ##__VA_ARGS__)
#define LOG_FATAL(format, ...)      LOG(LOG_LEVEL_FATAL, format, ##__VA_ARGS__)
#define LOG_DEBUG	LOG_INFO

#define CHECK(condition) \
do { if (!(condition)) { \
    LogMessage(NSStringFromClass([self class]), NSStringFromSelector(_cmd), __FILE__, __LINE__, LOG_LEVEL_FATAL, @"Check failed: " #condition ". "); \
    raise(SIGTRAP); \
}} while (0)

#define LOG(log_level, format, ...)  { \
    LogMessage(NSStringFromClass([self class]), NSStringFromSelector(_cmd), __FILE__, __LINE__, log_level, [NSString stringWithFormat: format, ##__VA_ARGS__]); \
}

//FOUNDATION_EXPORT void LogMessage(const char *file, int line, int log_level, NSString *str);
void LogMessage(NSString* sClass, NSString* sMethd, const char *file, int line, int log_level, NSString *str); 

// cause of Xcode doesn't has the macro like DEBUG/NDEBUG, we use this one.
#ifdef __OPTIMIZE__

#define LOG_INFO(format, ...)       ((void) 0)
#define LOG_WARNING(format, ...)    ((void) 0)

#define NSLog(...)                  ((void) 0)
#define DCHECK(...)                 ((void) 0)

#else

#define LOG_INFO(format, ...)       LOG(LOG_LEVEL_INFO, format, ##__VA_ARGS__)
#define LOG_WARNING(format, ...)    LOG(LOG_LEVEL_WARNING, format, ##__VA_ARGS__)

//#define NSLog   LOG_INFO
#define DCHECK  CHECK

#endif

