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

### Theme

```
./install.sh -o normal -c Dark -a normal -m -t all -l -N stable -HD --shell -i apple -b default -p --black --dialog
```