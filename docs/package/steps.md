### Create a DMG
```
hdiutil create -volname "Weblet" -srcfolder /path/to/weblet.app -ov -format UDZO weblet.dmg
```

### Generate the SHA-256 Hash
```
shasum -a 256 /path/to/weblet.dmg
```