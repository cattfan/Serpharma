import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'drugdetailpage.dart';

List<Map<String, String>> _parseAndLoadDrugs(String category) {
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
  return loadedDrugs;
}

class DrugPage extends StatefulWidget {
  const DrugPage({super.key});

  @override
  State<DrugPage> createState() => _DrugPageState();
}

class _DrugPageState extends State<DrugPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  String _activeFilter = 'Tất cả';

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

  void _showFilterOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return _FilterOptionsSheet(
          initialFilter: _activeFilter,
          onFilterSelected: (selectedFilter) {
            setState(() {
              _activeFilter = selectedFilter;
            });
            Navigator.pop(context);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD7E8FF),
      appBar: AppBar(
        toolbarHeight: 68,
        backgroundColor: const Color(0xFFD7E8FF),
        elevation: 0,
        title: const SearchBarWidget(),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            FilterButton(onPressed: () => _showFilterOptions(context)),
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
                  return DrugGridView(
                    key: ValueKey('$category-$_activeFilter'),
                    category: category,
                    filter: _activeFilter,
                  );
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
  final VoidCallback onPressed;
  const FilterButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: OutlinedButton.icon(
        onPressed: onPressed,
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

class _FilterOptionsSheet extends StatefulWidget {
  final String initialFilter;
  final Function(String) onFilterSelected;

  const _FilterOptionsSheet({
    required this.initialFilter,
    required this.onFilterSelected,
  });

  @override
  State<_FilterOptionsSheet> createState() => _FilterOptionsSheetState();
}

class _FilterOptionsSheetState extends State<_FilterOptionsSheet> {
  late String _selectedOption;

  @override
  void initState() {
    super.initState();
    _selectedOption = widget.initialFilter;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(Icons.filter_list, color: Colors.black54),
                  SizedBox(width: 8),
                  Text(
                    'Filter',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 12.0,
            runSpacing: 12.0,
            children: [
              _buildFilterChip('Tất cả'),
              _buildFilterChip('Thuốc theo tên (A-Z)'),
              _buildFilterChip('Thuốc mới rút số'),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final isSelected = _selectedOption == label;

    return ChoiceChip(
      label: Text(label),
      avatar: isSelected
          ? const Icon(Icons.check, color: Colors.white, size: 18)
          : null,
      selected: isSelected,
      onSelected: (selected) {
        if (selected) {
          widget.onFilterSelected(label);
        }
      },
      backgroundColor: Colors.grey.shade200,
      selectedColor: const Color(0xFF4A6AAB),
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.black87,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        side: BorderSide.none,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      showCheckmark: false,
    );
  }
}


class DrugGridView extends StatefulWidget {
  final String category;
  final String filter;
  const DrugGridView(
      {super.key, required this.category, required this.filter});

  @override
  State<DrugGridView> createState() => _DrugGridViewState();
}

class _DrugGridViewState extends State<DrugGridView>
    with AutomaticKeepAliveClientMixin<DrugGridView> {
  List<Map<String, String>> _allDrugs = [];
  List<Map<String, String>> _filteredDrugs = [];
  bool _isLoading = true;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _loadDrugData();
  }

  @override
  void didUpdateWidget(covariant DrugGridView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(oldWidget.filter != widget.filter) {
      _applyFilter();
    }
  }

  Future<void> _loadDrugData() async {
    final loadedDrugs = await compute(_parseAndLoadDrugs, widget.category);

    if (mounted) {
      setState(() {
        _allDrugs = List.from(loadedDrugs);
        _filteredDrugs = List.from(loadedDrugs);
        _isLoading = false;
        _applyFilter();
      });
    }
  }

  void _applyFilter() {
    List<Map<String, String>> tempDrugs = List.from(_allDrugs);
    switch (widget.filter) {
      case 'Thuốc theo tên (A-Z)':
        tempDrugs.sort((a, b) => a['name']!.compareTo(b['name']!));
        break;
      case 'Thuốc mới rút số':
        tempDrugs.shuffle(Random());
        break;
      case 'Tất cả':
      default:
        break;
    }
    setState(() {
      _filteredDrugs = tempDrugs;
    });
  }

  @override
  Widget build(BuildContext context) {
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
      itemCount: _filteredDrugs.length,
      itemBuilder: (context, index) {
        final drug = _filteredDrugs[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DrugDetailPage(
                  drugName: drug['name']!,
                  imagePath: drug['image']!,
                ),
              ),
            );
          },
          child: DrugGridItem(
            imagePath: drug['image']!,
            name: drug['name']!,
          ),
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
