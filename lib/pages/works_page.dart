import 'package:flutter/material.dart';
import '../widgets/app_colors.dart';
import 'share_qr_page.dart';

class WorksPage extends StatelessWidget {
  const WorksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(24, 40, 24, 20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFFFF9F0), AppColors.bg],
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('我的作品', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
                  SizedBox(height: 4),
                  Text('已上传 3 个相册，共 12 张照片', style: TextStyle(fontSize: 14, color: AppColors.textSecondary)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  _WorkCard(
                    emoji: '🏔️',
                    title: '云南之旅',
                    date: '2025.08.10',
                    count: 4,
                    color: const Color(0xFFFFECD2),
                    onShare: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ShareQrPage())),
                  ),
                  _WorkCard(
                    emoji: '🎂',
                    title: '生日派对',
                    date: '2025.08.05',
                    count: 5,
                    color: const Color(0xFFA8EDEA),
                    onShare: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ShareQrPage())),
                  ),
                  _WorkCard(
                    emoji: '🐱',
                    title: '布丁日常',
                    date: '2025.07.28',
                    count: 3,
                    color: const Color(0xFFD299C2),
                    onShare: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ShareQrPage())),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _WorkCard extends StatelessWidget {
  final String emoji;
  final String title;
  final String date;
  final int count;
  final Color color;
  final VoidCallback onShare;

  const _WorkCard({
    required this.emoji,
    required this.title,
    required this.date,
    required this.count,
    required this.color,
    required this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [AppColors.shadow],
      ),
      child: Column(
        children: [
          Container(
            height: 160,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Center(child: Text(emoji, style: const TextStyle(fontSize: 56))),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 4),
                    Text('$date · $count张照片', style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                  ],
                ),
                ElevatedButton(
                  onPressed: onShare,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary.withOpacity(0.1),
                    foregroundColor: AppColors.primaryDark,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                  ),
                  child: const Text('生成分享码', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
