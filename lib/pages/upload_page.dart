import 'package:flutter/material.dart';
import '../widgets/app_colors.dart';
import '../widgets/custom_app_bar.dart';
import 'photo_select_page.dart';

class UploadPage extends StatelessWidget {
  const UploadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '上传打印',
        onBack: () => Navigator.pop(context),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PhotoSelectPage()),
                ),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.border, width: 2),
                    boxShadow: const [AppColors.shadow],
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF3E0),
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: const Icon(Icons.photo_library_outlined, color: AppColors.primary, size: 28),
                      ),
                      const SizedBox(height: 12),
                      const Text('从相册选择', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 4),
                      const Text('浏览相册，批量选择照片', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [AppColors.shadow],
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('打印须知', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                    SizedBox(height: 8),
                    Text(
                      '• 支持 JPG、PNG 格式\n'
                      '• 建议选择清晰、光线充足的照片\n'
                      '• 打印同时可选择生成分享二维码',
                      style: TextStyle(fontSize: 12, color: AppColors.textSecondary, height: 1.7),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
