# Panduan LSPosed untuk YouTube AdBlock

## Masalah: Modul Tidak Muncul di LSPosed

Jika modul YouTube AdBlock tidak muncul di LSPosed Manager, ikuti langkah-langkah berikut:

### Langkah 1: Verifikasi Instalasi Magisk
1. Buka Magisk Manager
2. Pastikan modul "YouTube & YouTube Music AdBlock" terinstall
3. Pastikan modul diaktifkan (toggle ON)
4. Reboot perangkat

### Langkah 2: Periksa LSPosed
1. Buka LSPosed Manager
2. Pastikan LSPosed terinstall dengan benar
3. Periksa apakah ada error di log LSPosed

### Langkah 3: Reinstall Modul
Jika modul masih tidak muncul:

1. **Uninstall dari Magisk Manager:**
   - Buka Magisk Manager
   - Pergi ke Modules
   - Tap "Remove" pada YouTube AdBlock
   - Reboot perangkat

2. **Install Ulang:**
   - Install modul dari file ZIP
   - Reboot perangkat
   - Buka LSPosed Manager
   - Periksa bagian Modules

### Langkah 4: Manual Setup (Jika Masih Bermasalah)

Jika modul masih tidak muncul, coba setup manual:

1. **Periksa File System:**
   ```bash
   su
   ls -la /data/adb/modules/youtube_adblock/
   ls -la /system/app/YouTubeAdBlock/
   ```

2. **Periksa Xposed Files:**
   ```bash
   su
   cat /data/adb/modules/youtube_adblock/xposed_init
   cat /data/adb/modules/youtube_adblock/xposed/scope.txt
   ```

3. **Restart LSPosed:**
   - Buka LSPosed Manager
   - Tap menu (3 dots)
   - Pilih "Restart LSPosed"
   - Reboot perangkat

### Langkah 5: Alternative Method

Jika masih bermasalah, coba metode alternatif:

1. **Clear LSPosed Data:**
   - Settings > Apps > LSPosed Manager
   - Clear Data dan Cache
   - Reboot perangkat

2. **Reinstall LSPosed:**
   - Uninstall LSPosed
   - Install ulang LSPosed
   - Reboot perangkat
   - Install modul YouTube AdBlock

## Struktur File yang Benar

Modul harus memiliki struktur file berikut:

```
/data/adb/modules/youtube_adblock/
├── module.prop
├── system.prop
├── hosts
├── xposed_init
├── xposed/
│   ├── scope.txt
│   ├── module.prop
│   └── assets/
│       └── xposed_init
└── system/
    ├── bin/
    │   └── youtube_adblock
    ├── etc/
    │   └── init.d/
    │       └── 99youtube_adblock
    └── app/
        └── YouTubeAdBlock/
            ├── AndroidManifest.xml
            ├── xposed_init
            └── res/
                └── values/
                    ├── arrays.xml
                    └── strings.xml
```

## Troubleshooting LSPosed

### Error: "Module not found"
- Pastikan modul terinstall di Magisk
- Reboot perangkat setelah instalasi
- Periksa log LSPosed untuk error

### Error: "Scope not working"
- Pastikan aplikasi target terinstall
- Periksa apakah aplikasi dalam daftar scope
- Reboot perangkat setelah mengatur scope

### Error: "Hook not working"
- Periksa apakah class yang di-hook masih ada
- Update modul ke versi terbaru
- Periksa log Xposed untuk error

## Log Debugging

Untuk debugging, periksa log berikut:

### Magisk Log
```bash
su
magisk --sqlite "SELECT * FROM logs WHERE module='youtube_adblock'"
```

### LSPosed Log
```bash
su
logcat | grep -i lsposed
```

### Xposed Log
```bash
su
logcat | grep -i xposed
```

## Tips dan Trik

1. **Selalu reboot setelah instalasi modul**
2. **Periksa kompatibilitas versi LSPosed**
3. **Gunakan versi terbaru dari semua komponen**
4. **Backup sebelum melakukan perubahan**
5. **Test di perangkat yang berbeda jika memungkinkan**

## Support

Jika masalah masih berlanjut:

1. Periksa log error yang lengkap
2. Sertakan informasi perangkat (Android version, Magisk version, LSPosed version)
3. Jelaskan langkah-langkah yang sudah dicoba
4. Sertakan screenshot error jika ada

## Versi yang Didukung

- **LSPosed**: v1.8.0+
- **Magisk**: v20.0+
- **Android**: 6.0+ (API 23+)
- **Architecture**: ARM64, ARM32, x86, x86_64