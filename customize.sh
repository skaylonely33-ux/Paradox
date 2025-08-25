#!/system/bin/sh
SKIPUNZIP=1

# Module information
MODULE_NAME="YouTube & YouTube Music AdBlock"
MODULE_VERSION="v1.0.0"

# Print module info
ui_print "********************************"
ui_print "* $MODULE_NAME *"
ui_print "* $MODULE_VERSION *"
ui_print "********************************"
ui_print ""

# Extract files
ui_print "- Extracting module files"
unzip -o "$ZIPFILE" -x 'META-INF/*' -d $MODPATH >&2

# Create necessary directories
ui_print "- Creating directories"
mkdir -p $MODPATH/system/etc
mkdir -p $MODPATH/system/bin
mkdir -p $MODPATH/system/etc/init.d

# Copy hosts file
ui_print "- Installing hosts file"
cp $MODPATH/hosts $MODPATH/system/etc/hosts

# Copy system properties
ui_print "- Installing system properties"
cp $MODPATH/system.prop $MODPATH/system.prop

# Copy ad blocking script
ui_print "- Installing ad blocking script"
cp $MODPATH/system/bin/youtube_adblock $MODPATH/system/bin/youtube_adblock

# Create init.d script for automatic execution
ui_print "- Creating init.d script"
cat > $MODPATH/system/etc/init.d/99youtube_adblock << 'EOF'
#!/system/bin/sh
# YouTube & YouTube Music AdBlock Init Script
# This script runs on boot to ensure ad blocking is active

# Wait for system to be ready
sleep 10

# Run ad blocking script
/system/bin/youtube_adblock

# Set system properties
setprop youtube.adblock.enabled 1
setprop youtube.music.adblock.enabled 1
setprop net.adblock.enabled 1

# Flush DNS cache
ndc resolver flushdefaultif 2>/dev/null || true
ndc resolver clearnetdns 2>/dev/null || true

# Kill YouTube and YouTube Music to apply changes
am force-stop com.google.android.youtube 2>/dev/null || true
am force-stop com.google.android.apps.youtube.music 2>/dev/null || true

exit 0
EOF

# Set permissions
ui_print "- Setting permissions"
set_perm_recursive $MODPATH 0 0 0755 0644
set_perm $MODPATH/system/bin/youtube_adblock 0 0 0755
set_perm $MODPATH/system/etc/hosts 0 0 0644
set_perm $MODPATH/system/etc/init.d/99youtube_adblock 0 0 0755

# Create post-fs-data script for Magisk
ui_print "- Creating post-fs-data script"
cat > $MODPATH/post-fs-data.sh << 'EOF'
#!/system/bin/sh
# Post-fs-data script for YouTube AdBlock module

# Wait for system to be ready
sleep 5

# Run ad blocking script
/system/bin/youtube_adblock

# Set system properties
setprop youtube.adblock.enabled 1
setprop youtube.music.adblock.enabled 1
setprop net.adblock.enabled 1

exit 0
EOF

# Create service.sh script for Magisk
ui_print "- Creating service script"
cat > $MODPATH/service.sh << 'EOF'
#!/system/bin/sh
# Service script for YouTube AdBlock module

# Wait for system to be ready
sleep 15

# Run ad blocking script
/system/bin/youtube_adblock

# Set system properties
setprop youtube.adblock.enabled 1
setprop youtube.music.adblock.enabled 1
setprop net.adblock.enabled 1

# Flush DNS cache
ndc resolver flushdefaultif 2>/dev/null || true
ndc resolver clearnetdns 2>/dev/null || true

# Kill YouTube and YouTube Music to apply changes
am force-stop com.google.android.youtube 2>/dev/null || true
am force-stop com.google.android.apps.youtube.music 2>/dev/null || true

exit 0
EOF

# Set permissions for Magisk scripts
set_perm $MODPATH/post-fs-data.sh 0 0 0755
set_perm $MODPATH/service.sh 0 0 0755

# Create uninstall script
ui_print "- Creating uninstall script"
cat > $MODPATH/uninstall.sh << 'EOF'
#!/system/bin/sh
# Uninstall script for YouTube AdBlock module

# Restore original hosts file if backup exists
if [ -f "/system/etc/hosts.backup" ]; then
    cp /system/etc/hosts.backup /system/etc/hosts
    rm /system/etc/hosts.backup
fi

# Remove ad blocking properties
setprop youtube.adblock.enabled 0
setprop youtube.music.adblock.enabled 0
setprop net.adblock.enabled 0

# Flush DNS cache
ndc resolver flushdefaultif 2>/dev/null || true
ndc resolver clearnetdns 2>/dev/null || true

# Kill YouTube and YouTube Music
am force-stop com.google.android.youtube 2>/dev/null || true
am force-stop com.google.android.apps.youtube.music 2>/dev/null || true

exit 0
EOF

set_perm $MODPATH/uninstall.sh 0 0 0755

ui_print ""
ui_print "********************************"
ui_print "* Installation Completed! *"
ui_print "********************************"
ui_print ""
ui_print "- Module installed successfully"
ui_print "- Please reboot your device"
ui_print "- YouTube and YouTube Music ads will be blocked"
ui_print "- Check Magisk Manager for module status"
ui_print ""
ui_print "Features:"
ui_print "✓ Hosts file ad blocking"
ui_print "✓ System properties modification"
ui_print "✓ Automatic execution on boot"
ui_print "✓ DNS cache flushing"
ui_print "✓ App data clearing"
ui_print ""