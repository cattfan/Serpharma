import 'dart:async';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFD7E8FF),
      child: const Stack(
        children: [
          SizedHeaderBackground(),
          SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: Header()),
                SliverToBoxAdapter(child: SearchBar()),
                SliverToBoxAdapter(child: ImageBanner()),
                SliverToBoxAdapter(child: PopularMedicines()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SizedHeaderBackground extends StatelessWidget {
  const SizedHeaderBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      width: double.infinity,
      color: const Color(0xFF1F3A60),
    );
  }
}


class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.bookmark_border, color: Colors.white),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.settings_outlined, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.0),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.1),
              spreadRadius: 1,
              blurRadius: 5,
            )
          ],
        ),
        child: Row(
          children: [
            const Icon(Icons.search, color: Colors.grey),
            const SizedBox(width: 10),
            const Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Tìm kiếm',
                  border: InputBorder.none,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.camera_alt_outlined, color: Colors.grey),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class ImageBanner extends StatefulWidget {
  const ImageBanner({super.key});

  @override
  State<ImageBanner> createState() => _ImageBannerState();
}

class _ImageBannerState extends State<ImageBanner> {
  late final PageController _pageController;
  Timer? _timer;
  int _currentPage = 0;

  static const List<String> _bannerImages = [
    'images/banner/1.jpg',
    'images/banner/2.jpg',
    'images/banner/3.jpg',
    'images/banner/4.jpg',
    'images/banner/5.jpg',
    'images/banner/6.jpg',
    'images/banner/7.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);
    _startTimer();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (!mounted) return;
      _currentPage = (_currentPage + 1) % _bannerImages.length;
      if(_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: SizedBox(
        height: 180,
        child: Stack(
          alignment: Alignment.center,
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: _bannerImages.length,
              onPageChanged: (int page) {
                if(mounted) {
                  setState(() {
                    _currentPage = page;
                  });
                }
              },
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.asset(
                    _bannerImages[index],
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                );
              },
            ),
            Positioned(
              left: 0,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () {
                  if(_pageController.hasClients) {
                    _pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                  }
                },
              ),
            ),
            Positioned(
              right: 0,
              child: IconButton(
                icon: const Icon(Icons.arrow_forward_ios, color: Colors.white),
                onPressed: () {
                  if(_pageController.hasClients) {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PopularMedicines extends StatelessWidget {
  const PopularMedicines({super.key});

  static const List<Map<String, String>> _popularMedicines = [
    {"image": "images/8.jpg", "name": "Thuốc nhỏ mắt Systane ultra nhức mỏi mắt, khô mắt"},
    {"image": "images/9.jpg", "name": "Thuốc nhỏ mắt VRohto"},
    {"image": "images/10.jpg", "name": "Paracetamol Stada"},
    {"image": "images/14.jpg", "name": "Thuốc giảm đau Panadol"},
    {"image": "images/15.jpg", "name": "Vitamin C"},
    {"image": "images/16.jpg", "name": "Thuốc ho Acemuc"},
  ];

  static const List<Map<String, String>> _secondRowMedicines = [
    {"image": "images/11.jpg", "name": "Thuốc ho Prospan"},
    {"image": "images/12.jpg", "name": "Berberin"},
    {"image": "images/13.jpg", "name": "Eugica"},
    {"image": "images/17.jpg", "name": "Oresol"},
    {"image": "images/18.jpg", "name": "Thuốc kháng sinh Amoxicillin"},
    {"image": "images/19.jpg", "name": "Thuốc đau dạ dày Phosphalugel"},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Thuốc phổ biến',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: 180,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _popularMedicines.length,
              itemBuilder: (context, index) {
                return MedicineCard(
                  imagePath: _popularMedicines[index]['image']!,
                  name: _popularMedicines[index]['name']!,
                );
              },
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: 180,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _secondRowMedicines.length,
              itemBuilder: (context, index) {
                return MedicineCard(
                  imagePath: _secondRowMedicines[index]['image']!,
                  name: _secondRowMedicines[index]['name']!,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MedicineCard extends StatelessWidget {
  const MedicineCard({
    super.key,
    required this.imagePath,
    required this.name,
  });

  final String imagePath;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      margin: const EdgeInsets.only(right: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 130,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
