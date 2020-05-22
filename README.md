# Base Flutter Template

Base Project Flutter

## Getting Started

Clone this project from git, example with new name is
```
git clone https://github.com/rcdevgames/base_flutter.git new_name
```

Run this on terminal
```
$ flutter packages get
```
or on vscode command(MacOS)/ctrl(windows or linux)+shift+p search 'flutter get packages'

for specific organization you can rebuild with
```
$ flutter create --org net.rcdevgames .
```

if you want to change this to your project
1. change name in pubspec.yaml
2. make sure your file dart in lib reference to package as name in pubspec
3. make sure AndroidManifest.xml in debug, main, profile has same package name