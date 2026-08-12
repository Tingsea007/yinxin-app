import 'package:flutter/material.dart';
import '../models/photo_model.dart';
import '../widgets/app_colors.dart';
import '../widgets/custom_app_bar.dart';
import 'order_confirm_page.dart';

class PrintSettingsPage extends StatefulWidget {
  final List<PhotoModel> selectedPhotos;

  const PrintSettingsPage({super.key, required this.selectedPhotos});

  @override
  State<PrintSettingsPage> createState() => _PrintSettingsPageState();
}

class _PrintSettingsPageState extends State<PrintSettingsPage> {
  String _selectedSize = '5寸';
  int _copies = 1;
  bool _shareAfterPrint = true;

  final List<String> _sizes = ['5寸', '6寸', '7寸'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '打印参数',
        onBack: () => Navigator.pop(context),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildCard(
                    title: '照片尺寸',
                    child: Wrap(
                      spacing: 10,
                      children: _sizes.map((size) {
                        final active = _selectedSize == size;
                        return ChoiceChip(
                          label: Text(size),
                          selected: active,
                          onSelected: (_) => setState(() => _selectedSize = size),
                          selectedColor: AppColors.primary.withOpacity(0.08),
                          backgroundColor: AppColors.card,
                          side: BorderSide(color: active ? AppColors.primary : AppColors.border, width: 1.5),
                          labelStyle: TextStyle(
                            color: active ? AppColors.primaryDark : AppColors.text,
                            fontWeight: active ? FontWeight.w600 : FontWeight.w500,
                            fontSize: 14,
                          ),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                          showCheckmark: false,
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildCard(
                    title: '打印张数',
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('每张照片打印份数', style: TextStyle(fontSize: 14, color: AppColors.textSecondary)),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.border),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              _buildQtyBtn(Icons.remove, () {
                                if (_copies > 1) setState(() => _copies--);
                              }),
                              Container(
                                width: 40,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                  border: Border.symmetric(vertical: BorderSide(color: AppColors.border)),
                                ),
                                child: Text('$_copies', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                              ),
                              _buildQtyBtn(Icons.add, () {
                                if (_copies < 99) setState(() => _copies++);
                              }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () => setState(() => _shareAfterPrint = !_shareAfterPrint),
                    child: Container(
                      padding: const EdgeInsets.all(16),
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
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.share_outlined, color: AppColors.primary, size: 18),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('同时生成分享二维码', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                                const SizedBox(height: 2),
                                Text(
                                  '打印完成后自动创建分享链接',
                                  style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 48,
                            height: 28,
                            decoration: BoxDecoration(
                              color: _shareAfterPrint ? AppColors.primary : AppColors.border,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: AnimatedAlign(
                              duration: const Duration(milliseconds: 200),
                              alignment: _shareAfterPrint ? Alignment.centerRight : Alignment.centerLeft,
                              child: Container(
                                width: 24,
                                height: 24,
                                margin: const EdgeInsets.all(2),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [BoxShadow(color: Color(0x20000000), blurRadius: 2)],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
            child: ElevatedButton(
              onPressed: () {
                for (var p in widget.selectedPhotos) {
                  p.size = _selectedSize;
                  p.copies = _copies;
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => OrderConfirmPage(
                      photos: widget.selectedPhotos,
                      shareAfterPrint: _shareAfterPrint,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 54),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                elevation: 0,
              ),
              child: const Text('确认参数', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard({required String title, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [AppColors.shadow],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title.toUpperCase(), style: const TextStyle(fontSize: 12, color: AppColors.textSecondary, letterSpacing: 0.5)),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  Widget _buildQtyBtn(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        alignment: Alignment.center,
        child: Icon(icon, size: 18),
      ),
    );
  }
}
