# Checklist File YouTube AdBlock untuk LSPosed

## File Wajib Ada

### ✅ File Dasar Magisk
- [ ] `module.prop` - Metadata modul
- [ ] `system.prop` - Properti sistem
- [ ] `hosts` - Daftar domain iklan
- [ ] `META-INF/com/google/android/update-binary` - Script instalasi
- [ ] `META-INF/com/google/android/updater-script` - Recovery compatibility

### ✅ File Xposed Framework
- [ ] `xposed_init` - File utama untuk load hook class
- [ ] `assets/xposed_init` - Backup file untuk load hook class
- [ ] `xposed/scope.txt` - Daftar aplikasi yang di-hook
- [ ] `xposed/module.prop` - Metadata untuk Xposed
- [ ] `xposed/assets/xposed_init` - File load untuk Xposed

### ✅ File Android App
- [ ] `AndroidManifest.xml` - Manifest aplikasi
- [ ] `res/values/arrays.xml` - Daftar scope aplikasi
- [ ] `res/values/strings.xml` - String resources

### ✅ File Script
- [ ] `system/bin/youtube_adblock` - Script kontrol utama
- [ ] `system/etc/init.d/99youtube_adblock` - Script boot

### ✅ File Hook Class
- [ ] `XposedHook.java` - Class utama untuk hooking

## Struktur Direktori yang Benar

```
youtube_adblock/
├── module.prop
├── system.prop
├── hosts
├── xposed_init
├── assets/
│   └── xposed_init
├── xposed/
│   ├── scope.txt
│   ├── module.prop
│   └── assets/
│       └── xposed_init
├── res/
│   └── values/
│       ├── arrays.xml
│       └── strings.xml
├── META-INF/
│   └── com/
│       └── google/
│           └── android/
│               ├── update-binary
│               └── updater-script
├── system/
│   ├── bin/
│   │   └── youtube_adblock
│   ├── etc/
│   │   └── init.d/
│   │       └── 99youtube_adblock
│   └── app/
│       └── YouTubeAdBlock/
│           ├── AndroidManifest.xml
│           ├── xposed_init
│           └── res/
│               └── values/
│                   ├── arrays.xml
│                   └── strings.xml
└── XposedHook.java
```

## Verifikasi Instalasi

### Setelah Install di Magisk
```bash
# Periksa apakah modul terinstall
su
ls -la /data/adb/modules/youtube_adblock/

# Periksa file Xposed
cat /data/adb/modules/youtube_adblock/xposed_init
cat /data/adb/modules/youtube_adblock/xposed/scope.txt

# Periksa script
ls -la /data/adb/modules/youtube_adblock/system/bin/
ls -la /data/adb/modules/youtube_adblock/system/etc/init.d/
```

### Setelah Reboot
```bash
# Periksa apakah script berjalan
su
youtube_adblock status

# Periksa properti sistem
getprop youtube.adblock.enabled
getprop youtube.music.adblock.enabled

# Periksa hosts file
grep youtube_adblock /system/etc/hosts
```

### Di LSPosed Manager
1. Buka LSPosed Manager
2. Pergi ke bagian "Modules"
3. Cari "YouTube AdBlock"
4. Tap untuk membuka pengaturan
5. Aktifkan modul
6. Set scope untuk YouTube dan YouTube Music
7. Save dan reboot

## Troubleshooting Checklist

### Jika Modul Tidak Muncul di LSPosed
- [ ] File `xposed_init` ada dan berisi class yang benar
- [ ] File `AndroidManifest.xml` ada dengan metadata Xposed
- [ ] File `arrays.xml` berisi daftar scope yang benar
- [ ] Modul terinstall dengan benar di Magisk
- [ ] Sudah reboot setelah instalasi
- [ ] LSPosed terinstall dengan benar

### Jika Hook Tidak Berfungsi
- [ ] Modul aktif di LSPosed
- [ ] Scope sudah diset dengan benar
- [ ] Aplikasi target terinstall
- [ ] Sudah reboot setelah set scope
- [ ] Class yang di-hook masih ada di aplikasi target

### Jika Script Tidak Berfungsi
- [ ] File script ada di `/system/bin/`
- [ ] Permission script sudah benar (755)
- [ ] Script dapat dijalankan
- [ ] Properti sistem sudah diset

## Build dan Test

### Build Module
```bash
# Jalankan script build
./build_updated.sh

# Periksa file ZIP
ls -la output/youtube_adblock_magisk_module.zip
```

### Test Installation
1. Install modul via Magisk Manager
2. Reboot perangkat
3. Periksa apakah modul muncul di LSPosed
4. Aktifkan modul dan set scope
5. Reboot lagi
6. Test pemblokiran iklan

## Notes

- **Selalu reboot** setelah instalasi modul
- **Periksa log** jika ada masalah
- **Backup** sebelum melakukan perubahan
- **Test** di perangkat yang berbeda jika memungkinkan