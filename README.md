# Soal UTS Praktik

## Pengembangan Aplikasi Mobile

**Materi:** Opacity & BoxDecoration, Radial Animation, dan Performance

1. **BoxDecoration**
   - Buat widget `MenuCard` dengan atribut `nama`, `harga`, dan `tersedia`.
   - Dekorasi menggunakan satu `BoxDecoration` yang berisi `LinearGradient`, `borderRadius: 20`, `border`, dan `boxShadow`.
   - Tempatkan ikon di dalam lingkaran menggunakan `BoxShape.circle`.

2. **Opacity**
   - Saat kartu ditekan lama, ubah status ketersediaan menu.
   - Jika menu habis, tampilkan kartu secara transparan dengan `Opacity: 0.4` menggunakan `AnimatedOpacity` selama 400 ms.
   - Tambahkan label **Habis**.

3. **Daftar Menu**
   - Tampilkan 10 menu pada `KatalogPage` menggunakan `ListView.builder`.
   - Kartu yang masih tersedia tidak boleh dibungkus oleh widget `Opacity`.

4. **Radial Hero**
   - Saat kartu ditekan, tampilkan `DetailPage`.
   - Lingkaran ikon harus bertransformasi bertahap menjadi persegi berukuran besar menggunakan:
     - `Hero`
     - `ClipRRect` dengan radius yang diinterpolasi
     - `createRectTween` dengan lintasan melengkung
     - Durasi 600 ms

5. **Radial Berputar**
   - Pada header `KatalogPage`, tampilkan ikon cangkir yang berputar terus-menerus.
   - Gunakan `AnimationController`, `Transform.rotate`, dan rentang rotasi dari `0` sampai `2π`.
   - Gunakan `AnimatedBuilder` dengan parameter `child` dan `RepaintBoundary`.
   - Panggil `dispose()` pada controller.

6. **Performa**
   - Terapkan `const` pada widget yang memungkinkan.

7. **Laporan**
   - Ukur performa aplikasi menggunakan DevTools dalam profile mode.
   - Jelaskan secara singkat hasil pengukuran performa sebelum dan sesudah optimasi.
