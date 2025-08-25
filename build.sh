#!/bin/bash

# YouTube & YouTube Music AdBlock Magisk Module Build Script
# This script packages the module into a ZIP file for installation

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Module information
MODULE_NAME="YouTube & YouTube Music AdBlock"
MODULE_VERSION="v1.0.0"
MODULE_ID="youtube_adblock"
OUTPUT_FILE="${MODULE_ID}-${MODULE_VERSION}.zip"

# Log function
log() {
    echo -e "${GREEN}[BUILD]${NC} $1"
}

log_error() {
    echo -e "${RED}[BUILD] ERROR:${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[BUILD] WARNING:${NC} $1"
}

log_info() {
    echo -e "${BLUE}[BUILD] INFO:${NC} $1"
}

# Check if required files exist
check_files() {
    log "Checking required files..."
    
    local required_files=(
        "module.prop"
        "customize.sh"
        "README.md"
        "hosts"
        "system.prop"
        "system/bin/youtube_adblock"
        "config/adblock.conf"
        "META-INF/com/google/android/update-binary"
        "META-INF/com/google/android/updater-script"
    )
    
    for file in "${required_files[@]}"; do
        if [ ! -f "$file" ]; then
            log_error "Required file not found: $file"
            exit 1
        fi
    done
    
    log "All required files found"
}

# Create temporary build directory
create_build_dir() {
    log "Creating build directory..."
    
    BUILD_DIR="build_${MODULE_ID}"
    rm -rf "$BUILD_DIR"
    mkdir -p "$BUILD_DIR"
    
    log "Build directory created: $BUILD_DIR"
}

# Copy files to build directory
copy_files() {
    log "Copying files to build directory..."
    
    # Copy main files
    cp module.prop "$BUILD_DIR/"
    cp customize.sh "$BUILD_DIR/"
    cp README.md "$BUILD_DIR/"
    cp hosts "$BUILD_DIR/"
    cp system.prop "$BUILD_DIR/"
    
    # Create system directory structure
    mkdir -p "$BUILD_DIR/system/bin"
    mkdir -p "$BUILD_DIR/system/etc"
    mkdir -p "$BUILD_DIR/system/etc/init.d"
    
    # Copy system files
    cp system/bin/youtube_adblock "$BUILD_DIR/system/bin/"
    cp hosts "$BUILD_DIR/system/etc/"
    
    # Create init.d script
    cat > "$BUILD_DIR/system/etc/init.d/99youtube_adblock" << 'EOF'
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

    # Create config directory
    mkdir -p "$BUILD_DIR/config"
    cp config/adblock.conf "$BUILD_DIR/config/"
    
    # Create Magisk scripts
    cat > "$BUILD_DIR/post-fs-data.sh" << 'EOF'
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

    cat > "$BUILD_DIR/service.sh" << 'EOF'
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

    cat > "$BUILD_DIR/uninstall.sh" << 'EOF'
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

    # Copy META-INF directory
    cp -r META-INF "$BUILD_DIR/"
    
    log "Files copied successfully"
}

# Set permissions
set_permissions() {
    log "Setting file permissions..."
    
    # Set executable permissions
    chmod 755 "$BUILD_DIR/customize.sh"
    chmod 755 "$BUILD_DIR/system/bin/youtube_adblock"
    chmod 755 "$BUILD_DIR/system/etc/init.d/99youtube_adblock"
    chmod 755 "$BUILD_DIR/post-fs-data.sh"
    chmod 755 "$BUILD_DIR/service.sh"
    chmod 755 "$BUILD_DIR/uninstall.sh"
    chmod 755 "$BUILD_DIR/META-INF/com/google/android/update-binary"
    chmod 755 "$BUILD_DIR/META-INF/com/google/android/updater-script"
    
    # Set read permissions for other files
    chmod 644 "$BUILD_DIR/module.prop"
    chmod 644 "$BUILD_DIR/README.md"
    chmod 644 "$BUILD_DIR/hosts"
    chmod 644 "$BUILD_DIR/system.prop"
    chmod 644 "$BUILD_DIR/system/etc/hosts"
    chmod 644 "$BUILD_DIR/config/adblock.conf"
    
    log "Permissions set successfully"
}

# Create ZIP file
create_zip() {
    log "Creating ZIP file..."
    
    # Remove existing ZIP file
    rm -f "$OUTPUT_FILE"
    
    # Create ZIP file
    cd "$BUILD_DIR"
    zip -r "../$OUTPUT_FILE" . -x "*.DS_Store" "*/.*"
    cd ..
    
    if [ -f "$OUTPUT_FILE" ]; then
        log "ZIP file created successfully: $OUTPUT_FILE"
        
        # Get file size
        FILE_SIZE=$(du -h "$OUTPUT_FILE" | cut -f1)
        log_info "File size: $FILE_SIZE"
    else
        log_error "Failed to create ZIP file"
        exit 1
    fi
}

# Verify ZIP file
verify_zip() {
    log "Verifying ZIP file..."
    
    if [ ! -f "$OUTPUT_FILE" ]; then
        log_error "ZIP file not found"
        exit 1
    fi
    
    # Check if ZIP file is valid
    if unzip -t "$OUTPUT_FILE" > /dev/null 2>&1; then
        log "ZIP file verification passed"
    else
        log_error "ZIP file verification failed"
        exit 1
    fi
    
    # List contents
    log_info "ZIP file contents:"
    unzip -l "$OUTPUT_FILE" | head -20
}

# Clean up
cleanup() {
    log "Cleaning up build directory..."
    rm -rf "$BUILD_DIR"
    log "Cleanup completed"
}

# Main build process
main() {
    log "Starting build process for $MODULE_NAME $MODULE_VERSION"
    log "Output file: $OUTPUT_FILE"
    echo ""
    
    # Check requirements
    check_files
    
    # Build process
    create_build_dir
    copy_files
    set_permissions
    create_zip
    verify_zip
    cleanup
    
    echo ""
    log "Build completed successfully!"
    log "Module ZIP file: $OUTPUT_FILE"
    log "Ready for installation via Magisk Manager"
    echo ""
    log_info "Installation instructions:"
    log_info "1. Copy $OUTPUT_FILE to your device"
    log_info "2. Open Magisk Manager"
    log_info "3. Go to Modules section"
    log_info "4. Tap 'Install from storage'"
    log_info "5. Select $OUTPUT_FILE"
    log_info "6. Reboot your device"
}

# Run main function
main "$@"