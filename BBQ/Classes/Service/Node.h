//
//  Node.h
//  ThreadTest
//
//  Created by BIBHAS BHATTACHARYA on 5/21/12.
//  Copyright (c) 2012 Self. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Node : NSObject

@property (strong, nonatomic) id data;
@property (strong, nonatomic) Node* next;

@end
