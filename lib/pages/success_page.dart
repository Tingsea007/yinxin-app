import 'package:flutter/material.dart';
import '../widgets/app_colors.dart';

class SuccessPage extends StatelessWidget {
  final bool shareQr;

  const SuccessPage({super.key, required this.shareQr});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 88,
                        height: 88,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(colors: [AppColors.success, Color(0xFF30D158)]),
                          boxShadow: [BoxShadow(color: AppColors.success.withOpacity(0.3), blurRadius: 24, spreadRadius: 4)],
                        ),
                        child: const Icon(Icons.check, color: Colors.white, size: 40),
                      ),
                      const SizedBox(height: 24),
                      const Text('订单提交成功', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 8),
                      Text(
                        shareQr
                            ? '照片已发送至打印机\n分享二维码已生成，可在作品页查看'
                            : '照片已发送至打印机\n打印完成后请注意取件',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 14, color: AppColors.textSecondary, height: 1.6),
                      ),
                      const SizedBox(height: 32),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).popUntil((route) => route.isFirst);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 52),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                          elevation: 0,
                        ),
                        child: const Text('查看作品', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.card,
                          foregroundColor: AppColors.text,
                          minimumSize: const Size(double.infinity, 52),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                          side: const BorderSide(color: AppColors.border),
                          elevation: 0,
                        ),
                        child: const Text('返回首页', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
