import 'package:flutter/material.dart';
import '../widgets/app_colors.dart';
import 'printer_settings_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFFFF9F0), AppColors.bg],
                ),
              ),
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(colors: [AppColors.primary, Color(0xFFFF8C00)]),
                      boxShadow: [BoxShadow(color: Color(0x1A000000), blurRadius: 16, spreadRadius: 2)],
                    ),
                    child: const Center(
                      child: Text('李', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w700)),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text('李明', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 4),
                  const Text('印享用户 · 已打印 36 张', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  _MenuItem(
                    icon: Icons.print_outlined,
                    iconColor: const Color(0xFF2196F3),
                    iconBg: const Color(0xFFE3F2FD),
                    title: '打印机设置',
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PrinterSettingsPage())),
                  ),
                  _MenuItem(
                    icon: Icons.settings_outlined,
                    iconColor: const Color(0xFF9C27B0),
                    iconBg: const Color(0xFFF3E5F5),
                    title: '设置',
                    onTap: () => _showToast(context, '功能开发中'),
                  ),
                  _MenuItem(
                    icon: Icons.help_outline,
                    iconColor: const Color(0xFFFF9800),
                    iconBg: const Color(0xFFFFF3E0),
                    title: '帮助与反馈',
                    onTap: () => _showToast(context, '功能开发中'),
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

  void _showToast(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String title;
  final VoidCallback onTap;

  const _MenuItem({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [AppColors.shadow],
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(10)),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(child: Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500))),
            const Icon(Icons.chevron_right, color: AppColors.textTertiary),
          ],
        ),
      ),
    );
  }
}
