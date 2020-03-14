//
//  TLNamedNode.m
//  treelike
//
//  Created by Leptos on 11/2/19.
//  Copyright © 2019 Leptos. All rights reserved.
//

#import "TLNamedNode.h"

@implementation TLNamedNode {
    NSMutableArray<TLNamedNode *> *_childeren;
}

- (instancetype)init {
    if (self = [super init]) {
        _childeren = [NSMutableArray array];
    }
    return self;
}
- (instancetype)initWithName:(NSString *)name parent:(TLNamedNode *)parent {
    if (self = [self init]) {
        _name = name;
        _parent = parent;
    }
    return self;
}
+ (instancetype)nodeNamed:(NSString *)name parent:(TLNamedNode *)parent {
    return [[self alloc] initWithName:name parent:parent];
}

- (NSString *)path {
    NSString *dir = self.parent.path;
    return dir ? [dir stringByAppendingPathComponent:self.name] : self.name;
}

- (BOOL)isLeaf {
    return _childeren.count == 0;
}

- (NSString *)treePrefix:(NSString *)prefix {
    NSMutableString *ret = [NSMutableString string];
    [ret appendString:self.name];
    [ret appendString:@"\n"];
    
    NSArray<TLNamedNode *> *nodes = _childeren;
    NSUInteger const lastIndx = nodes.count - 1;
    [nodes enumerateObjectsUsingBlock:^(TLNamedNode *node, NSUInteger idx, BOOL *stop) {
        BOOL last = (idx == lastIndx);
        [ret appendString:prefix];
        [ret appendString:last ? @"└" : @"├"];
        [ret appendString:@"── "];
        NSString *newfix = [(last ? @" " : @"│") stringByAppendingString:@"   "];
        [ret appendString:[node treePrefix:[prefix stringByAppendingString:newfix]]];
    }];
    return ret;
}

- (NSString *)htmlTreePrefix:(NSString *)prefix {
    static NSString *const indexName = @"index.html";
    static NSPredicate *indexFilterout;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        indexFilterout = [NSPredicate predicateWithBlock:^BOOL(TLNamedNode *node, id bindings) {
            return ![node.name isEqualToString:indexName];
        }];
    });
    
    NSArray<TLNamedNode *> *nodes = [_childeren filteredArrayUsingPredicate:indexFilterout];
    NSMutableString *ret = [NSMutableString string];
    BOOL const empty = self.leaf;
    if (empty || nodes.count != _childeren.count) {
        [ret appendFormat:@"<a href=\"%@%@\">%@</a>", self.path, empty ? @"" : @"/", self.name];
    } else {
        [ret appendString:self.name];
    }
    [ret appendString:@"<br>\n"];
    
    NSUInteger const lastIndx = nodes.count - 1;
    [nodes enumerateObjectsUsingBlock:^(TLNamedNode *node, NSUInteger idx, BOOL *stop) {
        BOOL last = (idx == lastIndx);
        [ret appendString:prefix];
        [ret appendString:last ? @"└" : @"├"];
        [ret appendString:@"── "];
        NSString *newfix = [(last ? @"&nbsp;" : @"│") stringByAppendingString:@"&nbsp;&nbsp; "];
        [ret appendString:[node htmlTreePrefix:[prefix stringByAppendingString:newfix]]];
    }];
    return ret;
}

- (TLNamedNode *)childNamed:(NSString *)name {
    for (TLNamedNode *node in _childeren) {
        if ([node.name isEqualToString:name]) {
            return node;
        }
    }
    TLNamedNode *ret = [TLNamedNode nodeNamed:name parent:self];
    [_childeren addObject:ret];
    return ret;
}

- (NSString *)description {
    return [self descriptionWithLocale:nil indent:0];
}

- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level {
    NSMutableString *ret = [NSMutableString string];
    [ret appendString:self.name];
    NSArray<TLNamedNode *> *nodes = _childeren;
    BOOL family = (nodes.count != 0);
    if (family) {
        [ret appendString:@" ("];
    }
    [ret appendString:@"\n"];
    
    level++;
    NSString *prefix = [@"" stringByPaddingToLength:level * 4 withString:@" " startingAtIndex:0];
    for (TLNamedNode *node in nodes) {
        [ret appendString:prefix];
        [ret appendString:[node descriptionWithLocale:locale indent:level]];
    }
    if (family) {
        level--;
        [ret appendString:[@"" stringByPaddingToLength:level * 4 withString:@" " startingAtIndex:0]];
        [ret appendString:@")\n"];
    }
    return ret;
}

@end
