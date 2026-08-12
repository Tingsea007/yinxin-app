import 'package:flutter/material.dart';
import '../models/photo_model.dart';
import '../widgets/app_colors.dart';
import '../widgets/custom_app_bar.dart';
import 'success_page.dart';

class OrderConfirmPage extends StatefulWidget {
  final List<PhotoModel> photos;
  final bool shareAfterPrint;

  const OrderConfirmPage({super.key, required this.photos, required this.shareAfterPrint});

  @override
  State<OrderConfirmPage> createState() => _OrderConfirmPageState();
}

class _OrderConfirmPageState extends State<OrderConfirmPage> {
  late List<PhotoModel> _photos;

  @override
  void initState() {
    super.initState();
    _photos = List.from(widget.photos);
  }

  int get totalCopies => _photos.fold(0, (sum, p) => sum + p.copies);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '确认订单',
        onBack: () => Navigator.pop(context),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: [
                  ..._photos.asMap().entries.map((entry) {
                    final index = entry.key;
                    final photo = entry.value;
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.card,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [AppColors.shadow],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 52,
                            height: 52,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFECD2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(child: Text(photo.emoji ?? '', style: const TextStyle(fontSize: 24))),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(photo.name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                                const SizedBox(height: 2),
                                Text(photo.size, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.border),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Row(
                              children: [
                                _buildQtyBtn(Icons.remove, () {
                                  if (photo.copies > 1) {
                                    setState(() => photo.copies--);
                                  }
                                }),
                                Container(
                                  width: 32,
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                    border: Border.symmetric(vertical: BorderSide(color: AppColors.border)),
                                  ),
                                  child: Text('${photo.copies}', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                                ),
                                _buildQtyBtn(Icons.add, () {
                                  if (photo.copies < 99) {
                                    setState(() => photo.copies++);
                                  }
                                }),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.card,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [AppColors.shadow],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('共 ', style: TextStyle(fontSize: 14, color: AppColors.textSecondary)),
                        Text('${_photos.length}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.text)),
                        Text(' 张照片，打印 ', style: TextStyle(fontSize: 14, color: AppColors.textSecondary)),
                        Text('$totalCopies', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.text)),
                        Text(' 张', style: TextStyle(fontSize: 14, color: AppColors.textSecondary)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
            child: ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SuccessPage(shareQr: widget.shareAfterPrint),
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 54),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                elevation: 0,
              ),
              child: const Text('提交订单', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQtyBtn(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 30,
        height: 30,
        alignment: Alignment.center,
        child: Icon(icon, size: 16),
      ),
    );
  }
}
