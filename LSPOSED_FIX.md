# 🔧 Perbaikan Cepat: Modul Tidak Muncul di LSPosed

## Masalah
Modul YouTube AdBlock tidak muncul di LSPosed Manager setelah instalasi.

## Solusi Cepat

### 1. Reinstall Modul
```bash
# Uninstall dari Magisk Manager
# Reboot perangkat
# Install ulang modul
# Reboot lagi
```

### 2. Periksa File Xposed
Pastikan file-file berikut ada:
- ✅ `xposed_init` (berisi: `com.youtube.adblock.XposedHook`)
- ✅ `xposed/scope.txt` (berisi daftar aplikasi)
- ✅ `AndroidManifest.xml` (dengan metadata Xposed)
- ✅ `res/values/arrays.xml` (dengan scope array)

### 3. Restart LSPosed
1. Buka LSPosed Manager
2. Tap menu (3 dots)
3. Pilih "Restart LSPosed"
4. Reboot perangkat

### 4. Clear LSPosed Data
1. Settings > Apps > LSPosed Manager
2. Clear Data dan Cache
3. Reboot perangkat

## File yang Diperbaiki

Saya telah menambahkan file-file berikut untuk kompatibilitas LSPosed:

### ✅ File Baru
- `xposed_init` - Load hook class
- `assets/xposed_init` - Backup load file
- `xposed/module.prop` - Metadata Xposed
- `AndroidManifest.xml` - App manifest
- `res/values/arrays.xml` - Scope array
- `res/values/strings.xml` - String resources
- `XposedHook.java` - Hook class

### ✅ Script yang Diperbarui
- `META-INF/com/google/android/update-binary` - Install Xposed files
- `build_updated.sh` - Build dengan Xposed support

## Langkah Instalasi yang Benar

1. **Install via Magisk Manager**
2. **Reboot perangkat**
3. **Buka LSPosed Manager**
4. **Cari "YouTube AdBlock" di Modules**
5. **Aktifkan modul**
6. **Set scope untuk YouTube & YouTube Music**
7. **Save dan reboot**

## Troubleshooting

### Jika Masih Tidak Muncul
1. Periksa log LSPosed: `logcat | grep -i lsposed`
2. Periksa file modul: `ls -la /data/adb/modules/youtube_adblock/`
3. Periksa Xposed files: `cat /data/adb/modules/youtube_adblock/xposed_init`

### Jika Muncul Tapi Tidak Berfungsi
1. Pastikan scope sudah diset dengan benar
2. Reboot setelah set scope
3. Periksa log Xposed: `logcat | grep -i xposed`

## Build Module yang Diperbaiki

Gunakan script build yang baru:
```bash
./build_updated.sh
```

Script ini akan membuat modul dengan semua file Xposed yang diperlukan.

## Verifikasi

Setelah instalasi, modul seharusnya:
- ✅ Muncul di LSPosed Manager
- ✅ Dapat diaktifkan
- ✅ Memiliki scope yang benar
- ✅ Berfungsi untuk memblokir iklan

---

**Jika masih bermasalah, gunakan panduan lengkap di `LSPOSED_GUIDE.md`**