import 'package:flutter/material.dart';
import 'dart:math';
import 'tracuuthuoc/interaction_state.dart';
import 'tracuuthuoc.dart';

class DrugDetails {
  final String internationalName;
  final String drugName;
  final String drugType;
  final String indication;
  final String dosageAndUsage;
  final String adr;

  DrugDetails({
    required this.internationalName,
    required this.drugName,
    required this.drugType,
    required this.indication,
    required this.dosageAndUsage,
    required this.adr,
  });

  factory DrugDetails.generateRandom(String name) {
    final random = Random();
    const indications = [
      'Giảm đau đầu, đau nửa đầu, đau họng, đau bụng kinh, đau cơ xương, triệu chứng cảm cúm.',
      'Hạ sốt, giảm đau răng, giảm đau sau tiêm vaccin.',
      'Điều trị các triệu chứng của cảm lạnh và cúm như sốt, nhức đầu và sổ mũi.',
      'Chống viêm, giảm đau trong các trường hợp viêm khớp, thoái hóa khớp.'
    ];
    const dosages = [
      'Người lớn và trẻ em trên 12 tuổi: uống 1-2 viên/lần, 3-4 lần/ngày. Không uống quá 8 viên/ngày.',
      'Uống sau bữa ăn. Khoảng cách giữa các liều là 4-6 giờ.',
      'Trẻ em 6-12 tuổi: uống 1/2 - 1 viên/lần. Tham khảo ý kiến bác sĩ.',
      'Không sử dụng cho bệnh nhân mẫn cảm với bất kỳ thành phần nào của thuốc.'
    ];
    const adrs = [
      'Phát ban da, buồn nôn, đau bụng. Hiếm gặp: phản ứng phản vệ.',
      'Mệt mỏi, chóng mặt. Ngừng sử dụng và hỏi ý kiến bác sĩ nếu có dấu hiệu bất thường.',
      'Có thể gây kích ứng dạ dày nhẹ. Nên uống cùng với thức ăn.',
      'Không có tác dụng phụ đáng kể khi dùng đúng liều lượng.'
    ];
    const types = [
      'Thuốc giảm đau, hạ sốt',
      'Thuốc kháng histamin',
      'Thuốc kháng viêm không steroid (NSAID)',
      'Thuốc kháng sinh'
    ];

    return DrugDetails(
      internationalName: name.split(' ').first,
      drugName: name,
      drugType: types[random.nextInt(types.length)],
      indication: indications[random.nextInt(indications.length)],
      dosageAndUsage: dosages[random.nextInt(dosages.length)],
      adr: adrs[random.nextInt(adrs.length)],
    );
  }
}

class DrugDetailPage extends StatefulWidget {
  final String drugName;
  final String imagePath;

  const DrugDetailPage(
      {super.key, required this.drugName, required this.imagePath});

  @override
  State<DrugDetailPage> createState() => _DrugDetailPageState();
}

class _DrugDetailPageState extends State<DrugDetailPage> {
  late final DrugDetails details;
  String _selectedUserType = 'Người dùng';

  @override
  void initState() {
    super.initState();
    details = DrugDetails.generateRandom(widget.drugName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD7E8FF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black54),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(''),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black54),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.share_outlined, color: Colors.black54),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.bookmark_border, color: Colors.black54),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Colors.black54),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey.shade300)),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedUserType,
                      icon: const Icon(Icons.keyboard_arrow_down,
                          color: Colors.black54),
                      items: <String>['Người dùng', 'Y sĩ']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedUserType = newValue!;
                        });
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      )
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset(
                        widget.imagePath,
                        height: 200,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return const SizedBox(
                              height: 200,
                              child: Icon(Icons.medication_liquid_outlined,
                                  size: 100, color: Colors.grey));
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      details.drugName,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildDetailRow(
                        'Tên chung quốc tế:', details.internationalName),
                    _buildDetailRow('Tên thuốc:', details.drugName),
                    _buildDetailRow('Loại thuốc:', details.drugType),
                    _buildDetailRow('Chỉ định:', details.indication),
                    _buildDetailRow(
                        'Liều lượng và cách dùng:', details.dosageAndUsage),
                    _buildDetailRow(
                        'Tác dụng không mong muốn (ADR):', details.adr),
                    const SizedBox(height: 30),
                    const Center(
                      child: Text(
                        'THÔNG TIN THUỐC ĐƯỢC TRÍCH XUẤT TỪ DƯỢC\nĐIỂN QUỐC GIA',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        color: const Color(0xFFE3F2FD),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade300,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 2,
                ),
                child: const Text('Lưu', style: TextStyle(fontSize: 16)),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  addInteractionDrug(widget.drugName);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const InteractionLookupPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1F3A60),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 2,
                ),
                child: const Text(
                  'Thêm vào tương tác',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String content) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black87),
            ),
            const SizedBox(height: 4),
            Text(
              content,
              style: const TextStyle(
                  fontSize: 16, color: Colors.black54, height: 1.4),
            ),
          ],
        ));
  }
}
