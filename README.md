# Katalog Menu

Aplikasi Flutter sederhana untuk katalog sepuluh menu, status ketersediaan, dan
transisi Hero menuju halaman detail.

## Menjalankan aplikasi

Jika platform runner belum tersedia, buat runner Android/iOS dari direktori
proyek dengan `flutter create --platforms android,ios .`.

```shell
flutter pub get
flutter run
```

Tekan lama kartu untuk mengganti status tersedia/habis. Ketuk kartu untuk
membuka detail. Jalankan pengujian widget dengan `flutter test`.

## Pengukuran performa

Belum ada hasil pengukuran DevTools yang direkam: proyek ini dibuat di
lingkungan tanpa Flutter SDK, emulator, atau perangkat terhubung. Untuk membuat
perbandingan yang valid, jalankan aplikasi pada perangkat yang sama dengan
`flutter run --profile`, buka DevTools, lalu rekam frame raster/UI pada skenario
scroll katalog dan animasi yang sama. Catat median dan persentil ke-90 frame
build/raster serta jumlah frame yang melewati batas 16,7 ms.

| Versi | Hasil pengukuran |
|---|---|
| Sebelum optimasi | Belum diukur; tidak ada baseline yang tersedia. |
| Sesudah optimasi | Belum diukur; perlu dijalankan di perangkat dalam profile mode. |

Optimasi yang disiapkan di implementasi ini meliputi `const` pada widget statis,
child statis pada `AnimatedBuilder`, dan `RepaintBoundary` pada ikon berputar.
Karena baseline dan pengukuran perangkat belum tersedia, tidak ada klaim angka
atau peningkatan frame rate yang dibuat.
