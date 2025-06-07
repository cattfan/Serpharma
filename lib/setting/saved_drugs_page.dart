import 'package:flutter/material.dart';
import 'package:serpharma/drugdetailpage.dart';

class SavedDrugsPage extends StatelessWidget {
  const SavedDrugsPage({super.key});

  final List<Map<String, String>> _savedDrugs = const [
    {"image": "images/14.jpg", "name": "Thuốc giảm đau Panadol"},
    {"image": "images/15.jpg", "name": "Vitamin C"},
    {"image": "images/18.jpg", "name": "Thuốc kháng sinh Amoxicillin"},
    {"image": "images/11.jpg", "name": "Thuốc ho Prospan"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE3F2FD),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE3F2FD),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black54),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Thuốc đã lưu',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: _savedDrugs.length,
        itemBuilder: (context, index) {
          final drug = _savedDrugs[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 6.0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 0.5,
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  drug['image']!,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.medication_liquid_outlined, size: 40, color: Colors.grey);
                  },
                ),
              ),
              title: Text(drug['name']!),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
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
            ),
          );
        },
      ),
    );
  }
}
