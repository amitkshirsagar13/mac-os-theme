# mac-os-theme
### Add User to sudoer
```
echo "$USER ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/$USER
```

### Update macos theme on Ubuntu
```
tar -xjvf blob.tar.bz2
./installTheme.sh
```

### Compress for archive
```
tar -cjvf blob.tar.bz2 blob
```