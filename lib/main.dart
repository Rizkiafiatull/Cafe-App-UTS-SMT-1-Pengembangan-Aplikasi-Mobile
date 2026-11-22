import 'dart:math' as math;

import 'package:flutter/material.dart';

// Titik awal aplikasi: jalankan widget root dalam mode const.
void main() {
  runApp(const KatalogApp());
}

// Menyediakan tema global dan halaman pertama aplikasi.
class KatalogApp extends StatelessWidget {
  const KatalogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Katalog Menu',
      debugShowCheckedModeBanner: false,
      // Warna dasar aplikasi menggunakan nuansa hangat seperti kedai kopi.
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF8A4F32),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFFFF9F3),
        useMaterial3: true,
      ),
      home: const KatalogPage(),
    );
  }
}

// Data satu menu yang dipakai bersama oleh kartu katalog dan halaman detail.
@immutable
class MenuItem {
  const MenuItem({
    required this.id,
    required this.nama,
    required this.harga,
    required this.icon,
    required this.color,
    this.tersedia = true,
  });

  final String id;
  final String nama;
  final int harga;
  final IconData icon;
  final Color color;
  final bool tersedia;

  // Membuat salinan menu dengan status baru tanpa mengubah objek sebelumnya.
  MenuItem copyWith({bool? tersedia}) {
    return MenuItem(
      id: id,
      nama: nama,
      harga: harga,
      icon: icon,
      color: color,
      tersedia: tersedia ?? this.tersedia,
    );
  }
}

// Halaman katalog menyimpan daftar menu dan controller animasi cangkir.
class KatalogPage extends StatefulWidget {
  const KatalogPage({super.key});

  @override
  State<KatalogPage> createState() => _KatalogPageState();
}

class _KatalogPageState extends State<KatalogPage>
    with SingleTickerProviderStateMixin {
  // Controller memutar cangkir dan memakai State ini sebagai ticker provider.
  late final AnimationController _rotationController;

  // Sepuluh menu yang ditampilkan secara bertahap oleh ListView.builder.
  late final List<MenuItem> _menus = <MenuItem>[
    const MenuItem(
      id: 'espresso',
      nama: 'Espresso',
      harga: 18000,
      icon: Icons.coffee,
      color: Color(0xFF795548),
    ),
    const MenuItem(
      id: 'cappuccino',
      nama: 'Cappuccino',
      harga: 28000,
      icon: Icons.local_cafe,
      color: Color(0xFFB36B42),
    ),
    const MenuItem(
      id: 'caffe-latte',
      nama: 'Caffe Latte',
      harga: 30000,
      icon: Icons.coffee,
      color: Color(0xFF9A7552),
    ),
    const MenuItem(
      id: 'mocha',
      nama: 'Mocha',
      harga: 32000,
      icon: Icons.emoji_food_beverage,
      color: Color(0xFF8D5A49),
    ),
    const MenuItem(
      id: 'americano',
      nama: 'Americano',
      harga: 22000,
      icon: Icons.local_cafe_outlined,
      color: Color(0xFF6D584B),
    ),
    const MenuItem(
      id: 'matcha',
      nama: 'Matcha Latte',
      harga: 30000,
      icon: Icons.emoji_food_beverage,
      color: Color(0xFF71845B),
    ),
    const MenuItem(
      id: 'chocolate',
      nama: 'Cokelat Panas',
      harga: 27000,
      icon: Icons.cake,
      color: Color(0xFF94624B),
    ),
    const MenuItem(
      id: 'chai',
      nama: 'Chai Latte',
      harga: 29000,
      icon: Icons.emoji_food_beverage,
      color: Color(0xFFB17C4A),
    ),
    const MenuItem(
      id: 'caramel',
      nama: 'Caramel Macchiato',
      harga: 34000,
      icon: Icons.coffee,
      color: Color(0xFFAD7952),
    ),
    const MenuItem(
      id: 'cold-brew',
      nama: 'Cold Brew',
      harga: 26000,
      icon: Icons.local_drink,
      color: Color(0xFF64778A),
    ),
  ];

  @override
  void initState() {
    super.initState();
    // Satu putaran berlangsung empat detik dan diulang tanpa henti.
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    // Lepaskan ticker agar animasi tidak berjalan setelah halaman ditutup.
    _rotationController.dispose();
    super.dispose();
  }

  // Tekan lama kartu untuk mengganti status tersedia/habis.
  void _toggleAvailability(int index) {
    setState(() {
      _menus[index] = _menus[index].copyWith(
        tersedia: !_menus[index].tersedia,
      );
    });
  }

  // Ketuk kartu untuk membuka detail menu yang dipilih.
  void _openDetails(MenuItem menu) {
    Navigator.of(context).push<void>(MenuDetailRoute(menu: menu));
  }

  @override
  Widget build(BuildContext context) {
    // Header tetap di atas; daftar menu mengisi area yang tersisa.
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 16),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'KEDAI SENJA',
                          style:
                              Theme.of(context).textTheme.labelLarge?.copyWith(
                                    color: const Color(0xFF9A6B4E),
                                    letterSpacing: 2.2,
                                    fontWeight: FontWeight.w700,
                                  ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Menu favoritmu',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                color: const Color(0xFF3B2A22),
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Pilih teman untuk menemani harimu.',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: const Color(0xFF806C60)),
                        ),
                      ],
                    ),
                  ),
                  AnimatedBuilder(
                    animation: _rotationController,
                    // Child statis tidak dibuat ulang setiap nilai animasi berubah.
                    child: const RepaintBoundary(
                      child: _RotatingCupIcon(),
                    ),
                    builder: (BuildContext context, Widget? child) {
                      return Transform.rotate(
                        // Ubah nilai 0..1 controller menjadi sudut 0..2π radian.
                        angle: _rotationController.value * 2 * math.pi,
                        child: child,
                      );
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              // ListView.builder hanya membangun kartu saat diperlukan di layar.
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
                itemCount: _menus.length,
                itemBuilder: (BuildContext context, int index) {
                  final MenuItem menu = _menus[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    // Key stabil menjaga identitas kartu ketika statusnya berubah.
                    child: MenuCard(
                      key: ValueKey<String>(menu.id),
                      nama: menu.nama,
                      harga: menu.harga,
                      tersedia: menu.tersedia,
                      icon: menu.icon,
                      color: menu.color,
                      heroTag: 'menu-${menu.id}',
                      onTap: () => _openDetails(menu),
                      onLongPress: () => _toggleAvailability(index),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Ikon cangkir statis yang diputar oleh AnimatedBuilder pada header.
class _RotatingCupIcon extends StatelessWidget {
  const _RotatingCupIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 58,
      height: 58,
      decoration: const BoxDecoration(
        color: Color(0xFFF2E2D2),
        // Bentuk lingkaran menjadi ikon utama katalog.
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.coffee,
        color: Color(0xFF8A4F32),
        size: 30,
      ),
    );
  }
}

// Kartu menu menampilkan harga, ketersediaan, dan animasi menuju detail.
class MenuCard extends StatelessWidget {
  const MenuCard({
    required this.nama,
    required this.harga,
    required this.tersedia,
    required this.icon,
    required this.color,
    required this.heroTag,
    required this.onTap,
    required this.onLongPress,
    super.key,
  });

  final String nama;
  final int harga;
  final bool tersedia;
  final IconData icon;
  final Color color;
  final String heroTag;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  @override
  Widget build(BuildContext context) {
    final TextStyle? priceStyle = Theme.of(context).textTheme.titleMedium;
    return AnimatedOpacity(
      // Kartu habis diredupkan, sementara kartu tersedia tetap sepenuhnya jelas.
      opacity: tersedia ? 1 : 0.4,
      // Perubahan opasitas dibuat halus selama 400 milidetik.
      duration: const Duration(milliseconds: 400),
      child: Container(
        // Satu BoxDecoration memberi gradasi, sudut, garis tepi, dan bayangan.
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              Colors.white,
              Color.lerp(color, Colors.white, 0.91)!,
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withValues(alpha: 0.20)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: color.withValues(alpha: 0.10),
              blurRadius: 16,
              offset: const Offset(0, 7),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            // Tap membuka detail; long press mengubah ketersediaan menu.
            onTap: onTap,
            onLongPress: onLongPress,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: <Widget>[
                  Hero(
                    // Tag yang sama pada kedua halaman menghubungkan transisi Hero.
                    tag: heroTag,
                    createRectTween: (Rect? begin, Rect? end) {
                      // RectTween fallback mencegah tween null jika posisi belum ada.
                      if (begin == null || end == null) {
                        return RectTween(
                          begin: Rect.zero,
                          end: Rect.zero,
                        );
                      }
                      // MaterialRectArcTween membuat lintasan Hero melengkung.
                      return MaterialRectArcTween(begin: begin, end: end);
                    },
                    // Bentuk lingkaran ikon katalog membesar menjadi artwork di detail.
                    flightShuttleBuilder: (
                      BuildContext flightContext,
                      Animation<double> animation,
                      HeroFlightDirection flightDirection,
                      BuildContext fromHeroContext,
                      BuildContext toHeroContext,
                    ) =>
                        _heroFlightShuttle(
                      animation,
                      flightDirection,
                      icon,
                      color,
                    ),
                    child: Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: color,
                        // Ikon kartu dimulai sebagai lingkaran sebelum transisi Hero.
                        shape: BoxShape.circle,
                      ),
                      child: Icon(icon, size: 30, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          nama,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: const Color(0xFF3B2A22),
                                    fontWeight: FontWeight.w700,
                                  ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Rp ${_formatPrice(harga)}',
                          style: priceStyle?.copyWith(
                            color: const Color(0xFF8A4F32),
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (tersedia)
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16,
                      color: Color(0xFF9C8273),
                    )
                  else
                    // Label status muncul saat menu tidak tersedia.
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6),
                      child: Text(
                        'Habis',
                        style: TextStyle(
                          color: Color(0xFF8A4F32),
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Artwork berwarna untuk ikon Hero, digunakan di kartu dan halaman detail.
class _HeroArtwork extends StatelessWidget {
  const _HeroArtwork({required this.icon, required this.color});

  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    // FittedBox menjaga ikon tetap muat ketika ukuran Hero berubah.
    return SizedBox.expand(
      child: ColoredBox(
        color: color,
        child: Center(
          child: FittedBox(
            child: Icon(icon, size: 92, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

// Halaman detail menampilkan Hero berukuran besar serta informasi menu.
class DetailPage extends StatelessWidget {
  const DetailPage({required this.menu, super.key});

  final MenuItem menu;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Detail Menu'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 220,
                height: 220,
                child: Hero(
                  // Tag harus cocok dengan Hero kartu agar Flutter menjalankan transisi.
                  tag: 'menu-${menu.id}',
                  createRectTween: (Rect? begin, Rect? end) {
                    // Pertahankan fallback tween untuk kondisi batas tanpa Rect.
                    if (begin == null || end == null) {
                      return RectTween(
                        begin: Rect.zero,
                        end: Rect.zero,
                      );
                    }
                    return MaterialRectArcTween(begin: begin, end: end);
                  },
                  // Gunakan artwork dan interpolasi radius yang sama selama penerbangan.
                  flightShuttleBuilder: (
                    BuildContext flightContext,
                    Animation<double> animation,
                    HeroFlightDirection flightDirection,
                    BuildContext fromHeroContext,
                    BuildContext toHeroContext,
                  ) =>
                      _heroFlightShuttle(
                    animation,
                    flightDirection,
                    menu.icon,
                    menu.color,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: _HeroArtwork(icon: menu.icon, color: menu.color),
                  ),
                ),
              ),
              const SizedBox(height: 28),
              Text(
                menu.nama,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: const Color(0xFF3B2A22),
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(height: 10),
              Text(
                'Rp ${_formatPrice(menu.harga)}',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: const Color(0xFF8A4F32),
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 16),
              Chip(
                // Ikon dan teks status mengikuti ketersediaan menu.
                avatar: Icon(
                  menu.tersedia ? Icons.check_circle : Icons.cancel,
                  size: 18,
                ),
                label: Text(menu.tersedia ? 'Tersedia' : 'Habis'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Route khusus agar perpindahan Hero berlangsung selama 600 milidetik.
class MenuDetailRoute extends MaterialPageRoute<void> {
  MenuDetailRoute({required MenuItem menu})
      : super(builder: (BuildContext context) => DetailPage(menu: menu));

  @override
  Duration get transitionDuration => const Duration(milliseconds: 600);
}

// Widget yang dirender saat Hero bergerak di antara kartu dan halaman detail.
Widget _heroFlightShuttle(
  Animation<double> animation,
  HeroFlightDirection direction,
  IconData icon,
  Color color,
) {
  // Arah push mengecilkan radius dari lingkaran ke sudut persegi; pop sebaliknya.
  final bool pushing = direction == HeroFlightDirection.push;
  final Animation<double> radiusAnimation = Tween<double>(
    begin: pushing ? 32 : 28,
    end: pushing ? 28 : 32,
  ).animate(
    // Kurva easing menghaluskan perubahan radius selama transisi.
    CurvedAnimation(parent: animation, curve: Curves.easeInOutCubic),
  );

  // ClipRRect membaca radius animasi agar perubahan bentuk terlihat bertahap.
  return AnimatedBuilder(
    animation: radiusAnimation,
    builder: (BuildContext context, Widget? child) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(radiusAnimation.value),
        child: child,
      );
    },
    child: _HeroArtwork(icon: icon, color: color),
  );
}

// Memformat angka harga dengan pemisah ribuan berupa titik.
String _formatPrice(int price) {
  return price.toString().replaceAllMapped(
        // Cocokkan posisi di antara digit yang diikuti kelompok tiga digit.
        RegExp(r'\B(?=(\d{3})+(?!\d))'),
        (Match match) => '.',
      );
}
