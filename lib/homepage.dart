import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // SỬA LỖI: Cung cấp đường dẫn ảnh ĐÚNG và KHÁC NHAU cho mỗi loại thuốc
  final List<Map<String, String>> popularMedicines = [
    {
      "image": "images/pexels-cottonbro-6943420.jpg", // <-- THAY ĐỔI Ở ĐÂY
      "name": "Thuốc nhỏ mắt Systane ultra nhức mỏi mắt, khô mắt"
    },
    {
      "image": "images/pexels-darina-belonogova-7208628.jpg", // <-- THAY ĐỔI Ở ĐÂY
      "name": "Thuốc nhỏ mắt VRohto"
    },
    {
      "image": "imagespexels-darina-belonogova-7208628.jpg", // <-- THAY ĐỔI Ở ĐÂY
      "name": "Paracetamol Stada"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD7E8FF),
      body: Stack(
        children: [
          Container(
            height: 240,
            width: double.infinity,
            color: const Color(0xFF1F3A60),
          ),
          SafeArea(
            child: ListView(
              children: [
                _buildHeader(),
                _buildSearchBar(),
                _buildBanner(),
                _buildPopularMedicines(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildHeader() {
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

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
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

  Widget _buildBanner() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: SizedBox(
        height: 180,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: Image.asset(
            // SỬA LỖI: Cung cấp đường dẫn ảnh ĐÚNG cho banner
            'images/pexels-pixabay-159211.jpg', // <-- THAY ĐỔI Ở ĐÂY
            fit: BoxFit.contain,
            width: double.infinity,
          ),
        ),
      ),
    );
  }

  Widget _buildPopularMedicines() {
    return Container(
      color: const Color(0xFFD7E8FF),
      padding: const EdgeInsets.all(20.0),
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
              itemCount: popularMedicines.length,
              itemBuilder: (context, index) {
                return _buildMedicineCard(
                  imagePath: popularMedicines[index]['image']!,
                  name: popularMedicines[index]['name']!,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMedicineCard({required String imagePath, required String name}) {
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

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.red,
      unselectedItemColor: Colors.grey,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Trang Chủ',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.medical_services_outlined),
          label: 'Thuốc',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.book_outlined),
          label: 'Điều Trị',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.sync_alt_outlined),
          label: 'Tương tác',
        ),
      ],
    );
  }
}