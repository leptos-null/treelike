//
//  TLNamedNode.h
//  treelike
//
//  Created by Leptos on 11/2/19.
//  Copyright © 2019 Leptos. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TLNamedNode : NSObject

/// The node that has this node as a child.
/// The root node will have a @c nil parent.
@property (weak, nonatomic, nullable, readonly) TLNamedNode *parent;
/// The name of the node
@property (strong, nonatomic, nonnull, readonly) NSString *name;
/// The names of this node's parents concatenated with "/"
@property (strong, nonatomic, nonnull, readonly) NSString *path;
/// @c YES if this node does not have childeren,
/// @c NO if this node does have childeren.
@property (nonatomic, readonly, getter=isLeaf) BOOL leaf;

/// Create a node with a name and a parent.
+ (nonnull instancetype)nodeNamed:(nonnull NSString *)name parent:(nullable TLNamedNode *)parent;

/// Find the node of @c name that's directly a child of this node,
/// otherwise create a node with @c name and this node as the parent.
- (nonnull TLNamedNode *)childNamed:(nonnull NSString *)name;

/// A graphical tree using unicode as branches
- (nonnull NSString *)treePrefix:(nonnull NSString *)prefix;
/// A graphical tree using unicode and HTML escapes as branches.
/// Leafs or nodes with a child named "index.html" are attributed with references to the node.
- (nonnull NSString *)htmlTreePrefix:(nonnull NSString *)prefix;

@end
