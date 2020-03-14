//
//  main.m
//  treelike
//
//  Created by Leptos on 11/1/19.
//  Copyright © 2019 Leptos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <getopt.h>
#import "TLNamedNode.h"

int main(int argc, char *argv[]) {
    int htmlOutput = 0;
    
    if (isatty(STDIN_FILENO)) {
        fprintf(stderr, "%s expects a line-break delimited list of file names\n", argv[0]);
        return 1;
    }
    
    struct option const opts[] = {
        { "html", no_argument, &htmlOutput, 1 },
        { NULL, 0, NULL, 0 }
    };
    
    int ch;
    while ((ch = getopt_long(argc, argv, "h", opts, NULL)) != -1) {
        switch (ch) {
                /* process options */
            default:
                break;
        }
    }
    
    NSData *data = [[NSFileHandle fileHandleWithStandardInput] readDataToEndOfFile];
    NSString *inStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSArray<NSString *> *lines = [inStr componentsSeparatedByString:@"\n"];
    // this program intentionally ignores any real underlying file system
    TLNamedNode *const root = [TLNamedNode nodeNamed:@"." parent:nil];
    for (NSString *line in lines) {
        TLNamedNode *current = root;
        for (NSString *pathComponent in line.pathComponents) {
            if ([pathComponent isEqualToString:@"."]) {
                continue;
            }
            current = [current childNamed:pathComponent];
        }
    }
    
    NSString *outStr = htmlOutput ? [root htmlTreePrefix:@""] : [root treePrefix:@""];
    [[NSFileHandle fileHandleWithStandardOutput] writeData:[outStr dataUsingEncoding:NSUTF8StringEncoding]];
}
