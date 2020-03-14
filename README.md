## treelike

A simple version of `tree(1)` that fit my uses more closely.
The HTML generation only creates references for files, or for directories that contain an `index.html`, and doesn't show any index files directly.

Sample output:

```txt
.
├── README.md
├── src
│   ├── TLNamedNode.h
│   ├── TLNamedNode.m
│   └── main.m
└── treelike.xcodeproj
    ├── project.pbxproj
    └── project.xcworkspace
        ├── contents.xcworkspacedata
        └── xcshareddata
            └── IDEWorkspaceChecks.plist
```

Sample output with `--html`:

```html
.<br>
├── <a href="./README.md">README.md</a><br>
├── src<br>
│&nbsp;&nbsp; ├── <a href="./src/TLNamedNode.h">TLNamedNode.h</a><br>
│&nbsp;&nbsp; ├── <a href="./src/TLNamedNode.m">TLNamedNode.m</a><br>
│&nbsp;&nbsp; └── <a href="./src/main.m">main.m</a><br>
└── treelike.xcodeproj<br>
&nbsp;&nbsp;&nbsp; ├── <a href="./treelike.xcodeproj/project.pbxproj">project.pbxproj</a><br>
&nbsp;&nbsp;&nbsp; └── project.xcworkspace<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ├── <a href="./treelike.xcodeproj/project.xcworkspace/contents.xcworkspacedata">contents.xcworkspacedata</a><br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; └── xcshareddata<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; └── <a href="./treelike.xcodeproj/project.xcworkspace/xcshareddata/IDEWorkspaceChecks.plist">IDEWorkspaceChecks.plist</a><br>
```
