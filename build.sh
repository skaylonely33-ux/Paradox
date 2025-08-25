#!/bin/bash
echo "Building YouTube AdBlock Magisk Module..."
mkdir -p output/youtube_adblock
cp module.prop output/youtube_adblock/
cp system.prop output/youtube_adblock/
cp hosts output/youtube_adblock/
mkdir -p output/youtube_adblock/META-INF/com/google/android
cp META-INF/com/google/android/update-binary output/youtube_adblock/META-INF/com/google/android/
cp META-INF/com/google/android/updater-script output/youtube_adblock/META-INF/com/google/android/
mkdir -p output/youtube_adblock/system/bin
mkdir -p output/youtube_adblock/system/etc/init.d
echo "#!/system/bin/sh" > output/youtube_adblock/system/bin/youtube_adblock
chmod +x output/youtube_adblock/system/bin/youtube_adblock
cd output && zip -r youtube_adblock_magisk_module.zip youtube_adblock/ && cd ..
echo "Build completed! Module ZIP: output/youtube_adblock_magisk_module.zip"
