#!/bin/bash

echo "Building YouTube AdBlock Magisk Module with Xposed Support..."

# Create output directory
mkdir -p output/youtube_adblock

# Copy basic module files
cp module.prop output/youtube_adblock/
cp system.prop output/youtube_adblock/
cp hosts output/youtube_adblock/

# Create META-INF directory
mkdir -p output/youtube_adblock/META-INF/com/google/android
cp "META-INF/com/google/android/update-binary" output/youtube_adblock/META-INF/com/google/android/
cp "META-INF/com/google/android/updater-script" output/youtube_adblock/META-INF/com/google/android/

# Create system directories
mkdir -p output/youtube_adblock/system/bin
mkdir -p output/youtube_adblock/system/etc/init.d

# Create init.d script
cat > output/youtube_adblock/system/etc/init.d/99youtube_adblock << 'EOF'
#!/system/bin/sh
# YouTube AdBlock Init Script
sleep 10
if [ -f /system/etc/hosts.youtube_adblock ]; then
    cat /system/etc/hosts.youtube_adblock >> /system/etc/hosts
fi
setprop youtube.adblock.enabled true
setprop youtube.music.adblock.enabled true
stop netd
start netd
exit 0
EOF

# Create main script
cat > output/youtube_adblock/system/bin/youtube_adblock << 'EOF'
#!/system/bin/sh
case "$1" in
    "start")
        setprop youtube.adblock.enabled true
        setprop youtube.music.adblock.enabled true
        if [ -f /system/etc/hosts.youtube_adblock ]; then
            cat /system/etc/hosts.youtube_adblock >> /system/etc/hosts
        fi
        stop netd
        start netd
        ;;
    "stop")
        setprop youtube.adblock.enabled false
        setprop youtube.music.adblock.enabled false
        sed -i '/youtube_adblock/d' /system/etc/hosts
        ;;
    "status")
        if getprop youtube.adblock.enabled | grep -q "true"; then
            echo "YouTube AdBlock is ENABLED"
        else
            echo "YouTube AdBlock is DISABLED"
        fi
        ;;
    *)
        echo "Usage: $0 {start|stop|status}"
        exit 1
        ;;
esac
exit 0
EOF

# Create Xposed module structure
mkdir -p output/youtube_adblock/xposed
cp xposed/scope.txt output/youtube_adblock/xposed/
cp xposed/module.prop output/youtube_adblock/xposed/

# Create Xposed assets
mkdir -p output/youtube_adblock/xposed/assets
cp xposed/assets/xposed_init output/youtube_adblock/xposed/assets/

# Create Xposed app structure
mkdir -p output/youtube_adblock/system/app/YouTubeAdBlock
cp xposed_init output/youtube_adblock/system/app/YouTubeAdBlock/
cp assets/xposed_init output/youtube_adblock/system/app/YouTubeAdBlock/
cp AndroidManifest.xml output/youtube_adblock/system/app/YouTubeAdBlock/

# Create resources
mkdir -p output/youtube_adblock/system/app/YouTubeAdBlock/res/values
cp res/values/arrays.xml output/youtube_adblock/system/app/YouTubeAdBlock/res/values/
cp res/values/strings.xml output/youtube_adblock/system/app/YouTubeAdBlock/res/values/

# Set permissions
chmod +x output/youtube_adblock/system/bin/youtube_adblock
chmod +x output/youtube_adblock/system/etc/init.d/99youtube_adblock

# Create ZIP file
cd output
zip -r youtube_adblock_magisk_module.zip youtube_adblock/
cd ..

echo "Build completed successfully!"
echo "Module ZIP: output/youtube_adblock_magisk_module.zip"
echo ""
echo "Installation Instructions:"
echo "1. Install via Magisk Manager"
echo "2. Reboot device"
echo "3. Open LSPosed Manager"
echo "4. Enable module in Modules section"
echo "5. Set scope for YouTube and YouTube Music"
echo "6. Reboot again"