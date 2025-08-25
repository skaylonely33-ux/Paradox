# Installation Guide - YouTube & YouTube Music AdBlock

## Quick Installation

### Prerequisites
- Android device with root access
- Magisk Manager installed
- YouTube and/or YouTube Music apps installed

### Step-by-Step Installation

1. **Download the Module**
   - Download `youtube_adblock-v1.0.0.zip` to your device

2. **Install via Magisk Manager**
   - Open Magisk Manager
   - Go to "Modules" section
   - Tap "Install from storage"
   - Select the downloaded ZIP file
   - Wait for installation to complete

3. **Reboot Device**
   - Restart your device to apply changes
   - Wait for system to fully boot

4. **Verify Installation**
   - Open Magisk Manager
   - Check if "YouTube & YouTube Music AdBlock" is enabled
   - Open YouTube/YouTube Music and test ad blocking

## Alternative Installation Methods

### Recovery Installation
1. Download the ZIP file
2. Boot into recovery mode
3. Install the ZIP file
4. Reboot to system

### ADB Installation
```bash
# Push file to device
adb push youtube_adblock-v1.0.0.zip /sdcard/

# Install via Magisk
adb shell su -c "magisk --install-module /sdcard/youtube_adblock-v1.0.0.zip"
```

## Verification

### Check Module Status
```bash
# Check if module is installed
su -c "ls -la /data/adb/modules/youtube_adblock/"

# Check module status
su -c "cat /data/adb/modules/youtube_adblock/module.prop"
```

### Test Ad Blocking
1. Open YouTube app
2. Play any video
3. Check if video ads are skipped
4. Verify no banner ads appear

### Check Logs
```bash
# View ad blocking logs
su -c "cat /data/local/tmp/youtube_adblock.log"
```

## Troubleshooting

### Module Not Working
1. Ensure Magisk is properly installed
2. Check if module is enabled in Magisk Manager
3. Reboot device after installation
4. Clear YouTube app data

### Ads Still Appearing
1. Clear app data:
   ```bash
   su -c "pm clear com.google.android.youtube"
   su -c "pm clear com.google.android.apps.youtube.music"
   ```
2. Restart apps
3. Check module status in Magisk Manager

### App Crashes
1. Update to latest YouTube version
2. Clear app data and cache
3. Check module compatibility

## Uninstallation

### Via Magisk Manager
1. Open Magisk Manager
2. Go to Modules section
3. Disable "YouTube & YouTube Music AdBlock"
4. Reboot device

### Manual Uninstallation
```bash
# Remove module
su -c "rm -rf /data/adb/modules/youtube_adblock"

# Restore hosts file
su -c "cp /system/etc/hosts.backup /system/etc/hosts"

# Reboot
su -c "reboot"
```

## Support

If you encounter issues:
1. Check the troubleshooting section
2. Review the logs: `/data/local/tmp/youtube_adblock.log`
3. Report issues on GitHub
4. Join our community for help

## Notes

- This module requires root access
- Works with official YouTube and YouTube Music apps
- May need updates for new app versions
- Use at your own risk and responsibility