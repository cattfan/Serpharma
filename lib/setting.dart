import 'package:flutter/material.dart';
import 'login_page.dart';
import 'setting/saved_drugs_page.dart';
import 'setting/search_history_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  void _showConfirmationDialog(
      BuildContext context, {
        required String title,
        required String content,
        required String confirmText,
        required VoidCallback onConfirm,
        bool isDestructiveAction = false,
      }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              child: const Text('Hủy'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                confirmText,
                style: TextStyle(
                    color: isDestructiveAction
                        ? Colors.red
                        : Theme.of(context).primaryColor),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                onConfirm();
              },
            ),
          ],
        );
      },
    );
  }

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
          'Cài đặt',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSettingsItem(
              context,
              title: 'Lịch sử tìm kiếm',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SearchHistoryPage()),
                );
              },
            ),
            _buildSettingsItem(
              context,
              title: 'Thuốc đã lưu',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SavedDrugsPage()),
                );
              },
            ),
            _buildSettingsItem(
              context,
              title: 'Xóa tài khoản',
              isDestructive: true,
              onTap: () {
                _showConfirmationDialog(
                  context,
                  title: 'Xóa tài khoản',
                  content:
                  'Hành động này không thể hoàn tác. Bạn có chắc chắn muốn xóa tài khoản?',
                  confirmText: 'Xóa',
                  isDestructiveAction: true,
                  onConfirm: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                          (Route<dynamic> route) => false,
                    );
                  },
                );
              },
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _showConfirmationDialog(
                    context,
                    title: 'Đăng xuất',
                    content: 'Bạn có chắc chắn muốn đăng xuất?',
                    confirmText: 'Đăng xuất',
                    onConfirm: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                            (Route<dynamic> route) => false,
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2C3E50),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
                child: const Text('Đăng xuất',
                    style:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsItem(BuildContext context,
      {required String title,
        required VoidCallback onTap,
        bool isDestructive = false}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 0.5,
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
              color: isDestructive ? Colors.red : Colors.black87,
              fontSize: 16),
        ),
        trailing:
        const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }
}
