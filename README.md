# Modul Magisk YouTube & YouTube Music AdBlock

Modul Magisk untuk memblokir iklan dari aplikasi YouTube dan YouTube Music, mirip dengan fungsionalitas YouTube ReVanced.

## Fitur Utama

- **Pemblokiran Iklan YouTube**: Memblokir iklan video, iklan banner, dan iklan overlay
- **Pemblokiran Iklan YouTube Music**: Memblokir iklan audio dan iklan banner
- **Pemblokiran Level DNS**: Menggunakan file hosts untuk memblokir domain iklan di level DNS
- **Integrasi Framework Xposed**: Hook ke dalam metode aplikasi untuk mencegat permintaan iklan
- **Properti Sistem**: Mengkonfigurasi properti sistem untuk pemblokiran iklan
- **Manajemen Mudah**: Perintah sederhana untuk mengaktifkan/menonaktifkan modul

## Persyaratan Sistem

- Android 6.0+ (API 23+)
- Magisk 20.0+
- Akses root
- Framework Xposed (LSPosed/EdXposed direkomendasikan)

## Cara Instalasi

### Langkah 1: Persiapan
1. **Root Device**: Pastikan perangkat Android Anda sudah di-root
2. **Magisk**: Install Magisk Manager versi terbaru
3. **Backup**: Backup data penting sebelum instalasi

### Langkah 2: Download Modul
- Download file ZIP langsung dari repository ini
- File: `youtube_adblock_magisk_module_v1.0.0.zip` (11 KB)
- **Status**: ✅ Siap install langsung

### Langkah 3: Install via Magisk Manager
1. Buka Magisk Manager
2. Tap tab "Modules"
3. Tap "Install from storage"
4. Pilih file ZIP modul yang sudah didownload
5. Tap "Install"
6. Tunggu proses instalasi selesai
7. Tap "Reboot"

### Langkah 4: Aktifkan Framework Xposed (Direkomendasikan)
1. Install LSPosed atau EdXposed
2. Buka manager Xposed
3. Pergi ke bagian "Modules"
4. Cari "YouTube AdBlock" dalam daftar modul
5. Tap pada modul untuk membuka pengaturan
6. Aktifkan modul dengan toggle switch
7. Tap "Scope" untuk memilih aplikasi yang akan di-hook:
   - ✅ YouTube (com.google.android.youtube)
   - ✅ YouTube Music (com.google.android.apps.youtube.music)
   - ✅ YouTube TV (com.google.android.youtube.tv) - opsional
   - ✅ YouTube Kids (com.google.android.apps.youtube.kids) - opsional
8. Tap "Save" untuk menyimpan pengaturan
9. Reboot perangkat Anda

### Langkah 5: Verifikasi Instalasi
1. Buka Terminal atau gunakan ADB
2. Jalankan: `su -c youtube_adblock status`
3. Anda seharusnya melihat "YouTube AdBlock is ENABLED"

## Cara Penggunaan

### Kontrol Command Line

```bash
# Cek status modul
su -c youtube_adblock status

# Aktifkan pemblokiran iklan
su -c youtube_adblock start

# Nonaktifkan pemblokiran iklan
su -c youtube_adblock stop
```

### Melalui Magisk Manager

- Buka Magisk Manager
- Pergi ke bagian Modules
- Cari "YouTube & YouTube Music AdBlock"
- Toggle untuk mengaktifkan/menonaktifkan
- Reboot ketika diminta

### Testing Modul

1. Buka aplikasi YouTube
2. Coba putar video yang biasanya menampilkan iklan
3. Iklan seharusnya diblokir atau skip otomatis
4. Hal yang sama berlaku untuk YouTube Music

## Cara Kerja Modul

### 1. Pemblokiran File Hosts
Modul menambahkan entri ke `/system/etc/hosts` untuk memblokir domain iklan yang diketahui:
- Server iklan YouTube
- Layanan iklan Google
- Jaringan DoubleClick
- Domain analytics dan tracking

### 2. Hook Xposed
Modul hook ke dalam aplikasi YouTube dan YouTube Music untuk:
- Mencegat metode pemuatan iklan
- Memblokir panggilan API terkait iklan
- Skip video iklan secara otomatis
- Mencegah tracking analytics iklan

### 3. Properti Sistem
Mengatur properti sistem untuk:
- Mengaktifkan fitur pemblokiran iklan
- Menonaktifkan analytics dan telemetry
- Mengkonfigurasi pemblokiran iklan jaringan

## Domain yang Diblokir

Modul memblokir berbagai domain terkait iklan termasuk:

### Domain YouTube
- `googlevideo.com` (iklan video)
- `youtube.com` (domain utama)
- `m.youtube.com` (mobile)
- `www.youtube.com` (web)

### Domain Google Ads
- `doubleclick.net` (penyedia iklan)
- `googlesyndication.com` (sindikasi iklan)
- `googleadservices.com` (layanan iklan)
- `adsystem.google.com` (sistem iklan)

### Domain Regional
- `adservice.google.co.id` (Indonesia)
- `adservice.google.co.uk` (UK)
- `adservice.google.com.au` (Australia)
- Dan banyak lagi domain regional lainnya

## Troubleshooting

### Iklan Masih Muncul
1. Pastikan modul diaktifkan di Magisk Manager
2. Periksa apakah framework Xposed terinstall dengan benar
3. Verifikasi modul diaktifkan untuk YouTube/YouTube Music di Xposed
4. Coba bersihkan data dan cache aplikasi
5. Reboot perangkat Anda

### Modul Tidak Berfungsi
1. Periksa log Magisk untuk error
2. Verifikasi akses root berfungsi
3. Pastikan Anda memiliki versi Magisk terbaru
4. Periksa apakah perangkat Anda kompatibel

### Modul Tidak Muncul di LSPosed
1. Pastikan modul sudah terinstall dengan benar di Magisk Manager
2. Reboot perangkat setelah instalasi modul
3. Buka LSPosed Manager dan periksa bagian "Modules"
4. Jika modul tidak muncul, coba:
   - Uninstall modul dari Magisk Manager
   - Reboot perangkat
   - Install ulang modul
   - Reboot lagi
5. Pastikan LSPosed terinstall dengan benar
6. Periksa apakah ada konflik dengan modul lain

### Masalah Performa
1. Modul mungkin sedikit mempengaruhi waktu startup aplikasi
2. Beberapa fitur mungkin lebih lambat karena pemblokiran iklan
3. Pertimbangkan untuk menonaktifkan jika Anda mengalami lag yang signifikan

### Error Saat Instalasi
1. Pastikan file ZIP tidak rusak
2. Periksa apakah ada cukup ruang penyimpanan
3. Coba install ulang Magisk Manager
4. Pastikan perangkat mendukung Magisk

## Download Modul

### File Siap Pakai
Modul sudah siap download dan install langsung tanpa perlu build:

- **File**: `youtube_adblock_magisk_module_v1.0.0.zip`
- **Ukuran**: ~11 KB
- **Status**: Siap install

### Cara Download
1. Download file `youtube_adblock_magisk_module_v1.0.0.zip` langsung dari repository ini
2. Install langsung via Magisk Manager
3. Tidak perlu build atau compile

## Kontribusi

Kontribusi sangat diterima! Silakan submit pull requests atau buka issues untuk:

### Bug Reports
- Jelaskan masalah dengan detail
- Sertakan log error jika ada
- Sebutkan versi Android dan Magisk

### Feature Requests
- Jelaskan fitur yang diinginkan
- Berikan alasan mengapa fitur tersebut diperlukan
- Sertakan contoh implementasi jika memungkinkan

### Performance Improvements
- Optimasi kode
- Peningkatan efisiensi
- Pengurangan penggunaan memori

### Additional Ad Domains
- Domain iklan baru yang ditemukan
- Update domain yang sudah ada
- Domain regional tambahan

## Peringatan dan Disclaimer

### Peringatan
- Modul ini hanya untuk tujuan edukasi
- Gunakan dengan risiko Anda sendiri
- Developer tidak bertanggung jawab atas masalah yang mungkin timbul
- Pastikan Anda memahami risiko menggunakan modul root

### Legal Notice
- Modul ini tidak terkait dengan Google atau YouTube
- Penggunaan modul ini mungkin melanggar Terms of Service
- Gunakan dengan bijak dan bertanggung jawab

## Lisensi

Proyek ini dilisensikan di bawah MIT License - lihat file LICENSE untuk detail.

## Kredit dan Ucapan Terima Kasih

### Developer
- **Author**: MasVentot
- **Maintainer**: MasVentot

### Inspirasi
- YouTube ReVanced project
- Vanced project (tidak aktif lagi)
- NewPipe project

### Teknologi
- Framework Xposed untuk app hooking
- Magisk framework untuk systemless modding
- Android system modification

### Komunitas
- Kontribusi komunitas untuk daftar domain iklan
- Testing dan feedback dari pengguna
- Saran dan perbaikan dari developer lain

## Changelog

### v1.0.0 (Release Awal)
- ✅ Fungsionalitas pemblokiran iklan dasar
- ✅ Dukungan YouTube dan YouTube Music
- ✅ Integrasi file hosts
- ✅ Hook framework Xposed
- ✅ Script kontrol command line
- ✅ Auto-start pada boot
- ✅ Pemblokiran 100+ domain iklan

### Rencana v1.1.0
- 🔄 Peningkatan performa
- 🔄 Dukungan YouTube TV
- 🔄 Dukungan YouTube Kids
- 🔄 Interface pengaturan GUI
- 🔄 Whitelist domain

### Rencana v1.2.0
- 🔄 Pemblokiran iklan regional
- 🔄 Custom filter rules
- 🔄 Backup dan restore settings
- 🔄 Scheduled blocking

## Dukungan dan Bantuan

### Cara Mendapatkan Bantuan
1. **Baca dokumentasi ini dengan teliti**
2. **Periksa bagian troubleshooting**
3. **Cari di issues yang sudah ada**
4. **Buat issue baru jika diperlukan**

### Informasi yang Perlu Disertakan
- Versi Android
- Versi Magisk
- Versi modul
- Log error (jika ada)
- Langkah-langkah reproduksi masalah

### Komunitas
- Join grup Telegram atau Discord (jika ada)
- Ikuti update di repository GitHub
- Berbagi pengalaman dengan pengguna lain

## Uninstall

### Cara Uninstall
1. Buka Magisk Manager
2. Pergi ke bagian "Modules"
3. Cari "YouTube AdBlock"
4. Tap "Remove"
5. Reboot perangkat Anda

### Cleanup Manual (Jika Perlu)
1. Hapus entri dari `/system/etc/hosts`
2. Reset properti sistem
3. Bersihkan cache aplikasi

## 📁 File Repository

### 📦 File Siap Download
- `youtube_adblock_magisk_module_v1.0.0.zip` - Modul Magisk siap install
- `youtube_adblock_magisk_module_v1.0.0.md` - Release notes

### 📋 File Source Code
- `module.prop` - Metadata modul
- `system.prop` - Properti sistem
- `hosts` - Daftar domain iklan
- `XposedHook.java` - Class hook utama
- `AndroidManifest.xml` - Manifest aplikasi
- Dan file-file pendukung lainnya

---

**Selamat menikmati YouTube tanpa iklan! 🎉**

*Dibuat dengan ❤️ oleh MasVentot untuk komunitas Android Indonesia*