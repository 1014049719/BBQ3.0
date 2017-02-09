//
//  Common.h
//  NoteBook
//
//  Created by wangsc on 10-9-16.
//  Copyright 2010 ND. All rights reserved.
//

#import "Common.h"


@interface CommonFunc (ForDirectory)
{
    
}

+ (BOOL)isImageFile:(NSString *)strExt;
+ (BOOL) isFileExisted:(NSString *)fileName; 

+ (BOOL) deleteFile: (NSString *) fileName;
+ (NSString *) getFullFileName: (NSString *) fileNameNoPath;
+ (NSString *) getFullDirectoryName: (BOOL)ifNotCreateIt : (BOOL)isTempDirectory : (NSString *) directoryName : (NSError **) error;
+ (NSString *) getFullDirectoryNameOnBaseDirectoryName: (BOOL) ifNotCreateIt : (NSString *) baseDirectoryName : (NSString *) directoryName : (NSError **) error;

+(NSString*) getDocumentDir;
+(BOOL) EnsureFilePathExist:(NSString*) fullPath;
+(BOOL) CopySouceToTarget:(NSString*) source Target:(NSString*) target ;

//获取文件的大小，以K为单位
+(long long)GetFileSize:(NSString *)strFilename;


//获取HTML文件body之间的内容
+(NSString *)getHTMLFileBody:(NSString *)strHTMLFile;
//替换HTML文件body之间的内容,strNewContent不含<body>标签, 如果文件不在，用模版文件
+(BOOL)replaceHTMLBody:(NSString *)strHTMLFile content:(NSString *)strNewContent;
//用新的内容替换HTML模版<tag id=content>之间的内容,如果内容为空，就不替换
+(NSString *)replaceDemoContent:(NSString *)strModelFile content:(NSString *)strContent;
//替换item的GUID
+(BOOL)replaceHTMLItemGuid:(NSString *)strHTMLFile oldguid:(NSArray *)arrOldItemGuid newguid:(NSArray *)arrNewItemGuid;
//获取一个HTML文件的正文
+(NSString *)getHTMLFileBodyText:(NSString *)strHTMLFile;


+ (void)checkUserDirectory:(NSString*)strUserName;


+ (NSString *)getNoteDataPath;
+ (NSString*)getUserDBDir:(NSString *)strUser;
+ (NSString*)getTempDir;
+ (NSString*)getTempDir:(NSString *)strUser;

+ (NSString*)getTempDownDir;
+ (NSString*)getDecryptDir;
+ (NSString*)getImgDir;
+ (NSString*)getStaticDir;
+ (NSString*)getJsDir;
+ (NSString*)getMobImgDir;
+ (NSString*)getMobV5;
+ (NSString*)getMobV5_css;
+ (NSString*)getMobV5_images;
+ (NSString*)getMobV5_images_ico;
+ (NSString*)getMobV5_js;
+ (NSString*)getMobV51;
+ (NSString*)getMobV51_css;
+ (NSString*)getMobV51_images;
+ (NSString*)getMobV51_images_ico;


//取编辑模版文件
+ (NSString *)getEditModelFile;
//取保存模版文件
+ (NSString *)getSaveModelFile;
//取随手画临时文件
+ (NSString *)getDrawTmpFile;
//录音临时文件
+ (NSString *)getRecordTmpFile;

//头像下载全路径文件
+ (NSString*)getAvatarDownloadPath;
//头像存放全路径文件
+ (NSString*)getAvatarPath;
+ (NSString*)getAvatarPath:(NSString *)strUserName;


+(void)moveDbFile_1_1;


#pragma mark -

//保存jyex图片
+(NSDictionary *)saveJYEXPic:(UIImage *)image fileguid:(NSString *)strFileGuid mode:(NSString *)strMode;

//从html文件中读取标签值
+(NSString *)getTagValueFromHtml:(NSString *)strHtmlFile tagname:(NSString *)strTagName;


@end
