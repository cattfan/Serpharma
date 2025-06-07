import 'package:flutter/material.dart';
import 'tracuuthuoc/interaction_state.dart';

class InteractionLookupPage extends StatefulWidget {
  const InteractionLookupPage({super.key});

  @override
  State<InteractionLookupPage> createState() => _InteractionLookupPageState();
}

class _InteractionLookupPageState extends State<InteractionLookupPage> {
  final TextEditingController _drugInputController = TextEditingController();
  bool _showResults = false;

  void _addDrugToList() {
    final drugName = _drugInputController.text.trim();
    if (drugName.isNotEmpty) {
      addInteractionDrug(drugName);
      _drugInputController.clear();
    }
  }

  void _lookupInteractions() {
    setState(() {
      _showResults = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = const Color(0xFF2C3E50);
    final backgroundColor = const Color(0xFFD7E8FF);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black54),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Tra cứu tương tác thuốc',
          style: TextStyle(color: themeColor, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildSearchCard(themeColor),
                  const SizedBox(height: 16),
                  _buildDrugListCard(themeColor),
                  if (_showResults) _buildResultsCard(themeColor),
                ],
              ),
            ),
          ),
          _buildBottomButton(themeColor),
        ],
      ),
    );
  }

  Widget _buildSearchCard(Color themeColor) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tìm kiếm tên thuốc',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _drugInputController,
                    decoration: InputDecoration(
                      hintText: 'Nhập tên thuốc',
                      prefixIcon:
                      const Icon(Icons.search, color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      contentPadding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _addDrugToList,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: themeColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 14),
                  ),
                  child: const Text('Thêm'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrugListCard(Color themeColor) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Danh sách thuốc',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ValueListenableBuilder<List<String>>(
              valueListenable: interactionDrugListNotifier,
              builder: (context, drugList, child) {
                if (drugList.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Center(
                        child: Text('Chưa có thuốc nào được thêm.',
                            style: TextStyle(color: Colors.grey))),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: drugList.length,
                  itemBuilder: (context, index) {
                    final drugName = drugList[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: themeColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(drugName, style: TextStyle(color: themeColor)),
                          IconButton(
                            icon: const Icon(Icons.close, size: 18),
                            color: themeColor,
                            onPressed: () => removeInteractionDrug(drugName),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultsCard(Color themeColor) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(top: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildResultSection(
              themeColor: themeColor,
              title: 'Cơ chế',
              content:
              'Nefopam ức chế tái hấp thu noradrenalin (norepinephrine) và serotonin trên hệ thần kinh trung ương. Furazolidone ức chế MAO do chất chuyển hóa của thuốc, tác dụng xuất hiện chậm sau 5-10 ngày.',
            ),
            const Divider(height: 32),
            _buildResultSection(
              themeColor: themeColor,
              title: 'Hậu quả',
              content:
              'Tăng nguy cơ kích thích thần kinh trung ương, bao gồm co giật, ảo giác và kích động.',
            ),
            const Divider(height: 32),
            _buildResultSection(
              themeColor: themeColor,
              title: 'Cách xử lí',
              content:
              'Chống chỉ định phối hợp. Nếu đã dùng Furazolidone, chờ ít nhất 10 ngày sau khi ngừng thuốc trước khi bắt đầu Nefopam. Theo dõi chặt chẽ dấu hiệu thần kinh (co giật, kích động); ngừng thuốc ngay nếu xuất hiện triệu chứng và điều trị triệu chứng (benzodiazepine cho co giật).',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultSection(
      {required Color themeColor,
        required String title,
        required String content}) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: themeColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            title,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          content,
          textAlign: TextAlign.justify,
          style: const TextStyle(height: 1.5, fontSize: 15),
        ),
      ],
    );
  }

  Widget _buildBottomButton(Color themeColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _lookupInteractions,
        style: ElevatedButton.styleFrom(
          backgroundColor: themeColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        child: const Text(
          'Tra cứu thuốc',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
