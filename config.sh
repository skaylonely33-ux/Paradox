#!/system/bin/sh
# YouTube AdBlock Configuration Script

SKIPUNZIP=1

# Extract module files
unzip -o "$ZIPFILE" -x 'META-INF/*' -d $MODPATH >&2

# Set permissions
set_perm_recursive $MODPATH 0 0 0755 0644
set_perm $MODPATH/system/bin/youtube_adblock 0 0 0755
set_perm $MODPATH/system/etc/init.d/99youtube_adblock 0 0 0755

# Create necessary directories
mkdir -p $MODPATH/system/etc/permissions
mkdir -p $MODPATH/system/framework
mkdir -p $MODPATH/system/lib64
mkdir -p $MODPATH/system/app/YouTubeAdBlock

# Copy hosts file
cp $MODPATH/hosts $MODPATH/system/etc/hosts.youtube_adblock

ui_print "YouTube AdBlock Module installed successfully!"
ui_print "Please reboot your device and enable the module in Magisk Manager"