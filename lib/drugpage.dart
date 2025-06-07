import 'package:flutter/material.dart';

class DrugPage extends StatefulWidget {
  const DrugPage({super.key});

  @override
  State<DrugPage> createState() => _DrugPageState();
}

class _DrugPageState extends State<DrugPage> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  final List<String> _categories = [
    'Thuốc kháng sinh',
    'Thuốc tim mạch',
    'Thuốc giảm đau',
    'Thuốc ho',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _categories.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      appBar: AppBar(
        toolbarHeight: 68,
        backgroundColor: const Color(0xFFF0F4F8),
        elevation: 0,
        title: const SearchBarWidget(),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const FilterButton(),
            const SizedBox(height: 16),
            TabBar(
              controller: _tabController,
              isScrollable: true,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey.shade600,
              indicatorColor: Colors.red,
              indicatorWeight: 3.0,
              tabs: _categories.map((category) => Tab(text: category)).toList(),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: _categories.map((category) {
                  // Mỗi tab giờ là một DrugGridView riêng biệt
                  return DrugGridView(category: category);
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.0),
          border: Border.all(color: Colors.grey.shade300)),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: Icon(Icons.search, color: Colors.grey),
          ),
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Tìm kiếm',
                border: InputBorder.none,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: IconButton(
              icon: const Icon(Icons.camera_alt_outlined, color: Colors.grey),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  const FilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: OutlinedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.filter_list),
        label: const Text('Filter'),
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.black,
          side: BorderSide(color: Colors.grey.shade400),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ),
    );
  }
}

class DrugGridView extends StatefulWidget {
  // Nhận category để có thể tải dữ liệu khác nhau cho mỗi tab
  final String category;
  const DrugGridView({super.key, required this.category});

  @override
  State<DrugGridView> createState() => _DrugGridViewState();
}

// Thêm "with AutomaticKeepAliveClientMixin"
class _DrugGridViewState extends State<DrugGridView> with AutomaticKeepAliveClientMixin<DrugGridView> {
  List<Map<String, String>> _drugs = [];
  bool _isLoading = true;

  // Ghi đè wantKeepAlive và trả về true để giữ lại trạng thái của tab
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _loadDrugData();
  }

  Future<void> _loadDrugData() async {
    // Giả lập việc tải dữ liệu từ mạng hoặc CSDL
    await Future.delayed(const Duration(milliseconds: 500));

    // Dữ liệu mẫu (trong thực tế bạn sẽ tải dữ liệu dựa trên widget.category)
    final List<Map<String, String>> loadedDrugs = [
      {"image": "images/8.jpg", "name": "Panadol Extra"},
      {"image": "images/9.jpg", "name": "Amoxicillin 500mg"},
      {"image": "images/10.jpg", "name": "Ibuprofen 200mg"},
      {"image": "images/11.jpg", "name": "Cetirizine 10mg"},
      {"image": "images/12.jpg", "name": "Panadol Cảm Cúm"},
      {"image": "images/13.jpg", "name": "Loratadine 10mg"},
      {"image": "images/14.jpg", "name": "Omeprazole 20mg"},
      {"image": "images/15.jpg", "name": "Salbutamol Inhaler"},
      {"image": "images/16.jpg", "name": "Panadol Trẻ Em"},
      {"image": "images/17.jpg", "name": "Metformin 500mg"},
      {"image": "images/8.jpg", "name": "Aspirin 81mg"},
      {"image": "images/9.jpg", "name": "Atorvastatin 20mg"},
      {"image": "images/10.jpg", "name": "Ciprofloxacin 500mg"},
      {"image": "images/11.jpg", "name": "Diclofenac 50mg"},
      {"image": "images/12.jpg", "name": "Paracetamol 500mg"},
      {"image": "images/13.jpg", "name": "Berberin B12"},
      {"image": "images/14.jpg", "name": "Eugica Forte"},
      {"image": "images/15.jpg", "name": "Strepsils Cool"},
    ];

    if (mounted) {
      setState(() {
        _drugs = loadedDrugs;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Quan trọng: Phải gọi super.build(context) khi dùng AutomaticKeepAliveClientMixin
    super.build(context);

    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return GridView.builder(
      padding: const EdgeInsets.only(top: 24.0, bottom: 16.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: 0.7,
      ),
      itemCount: _drugs.length,
      itemBuilder: (context, index) {
        return DrugGridItem(
          imagePath: _drugs[index]['image']!,
          name: _drugs[index]['name']!,
        );
      },
    );
  }
}

class DrugGridItem extends StatelessWidget {
  const DrugGridItem({
    super.key,
    required this.imagePath,
    required this.name,
  });

  final String imagePath;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12.0),
                topRight: Radius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.error);
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
