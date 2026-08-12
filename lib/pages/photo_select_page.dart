import 'package:flutter/material.dart';
import '../models/photo_model.dart';
import '../widgets/app_colors.dart';
import '../widgets/custom_app_bar.dart';
import 'print_settings_page.dart';

class PhotoSelectPage extends StatefulWidget {
  const PhotoSelectPage({super.key});

  @override
  State<PhotoSelectPage> createState() => _PhotoSelectPageState();
}

class _PhotoSelectPageState extends State<PhotoSelectPage> {
  final List<PhotoModel> _photos = List.generate(
    12,
    (i) => PhotoModel(
      id: 'photo_$i',
      emoji: ['🏔️', '🎂', '🐱', '🌅', '🌸', '🏖️', '🍜', '🎉', '🐶', '🌃', '🍁', '⚽'][i],
      name: '照片${i + 1}',
    ),
  );

  int get selectedCount => _photos.where((p) => p.copies > 0).length;

  void _toggleSelect(int index) {
    setState(() {
      _photos[index].copies = _photos[index].copies > 0 ? 0 : 1;
    });
  }

  void _selectAll() {
    final allSelected = selectedCount == _photos.length;
    setState(() {
      for (var p in _photos) {
        p.copies = allSelected ? 0 : 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final count = selectedCount;
    return Scaffold(
      appBar: CustomAppBar(
        title: '选择照片',
        onBack: () => Navigator.pop(context),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('全部照片', style: TextStyle(fontSize: 14, color: AppColors.textSecondary)),
                GestureDetector(
                  onTap: _selectAll,
                  child: const Text('全选', style: TextStyle(fontSize: 14, color: AppColors.primary, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 3,
                mainAxisSpacing: 3,
              ),
              itemCount: _photos.length,
              itemBuilder: (context, index) {
                final photo = _photos[index];
                final selected = photo.copies > 0;
                return GestureDetector(
                  onTap: () => _toggleSelect(index),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Container(
                        color: const Color(0xFFE0E0E0),
                        child: Center(
                          child: Text(photo.emoji ?? '', style: const TextStyle(fontSize: 28)),
                        ),
                      ),
                      if (selected)
                        Container(
                          color: AppColors.primary.withOpacity(0.15),
                          child: const Center(
                            child: Icon(Icons.check_circle, color: AppColors.primary, size: 28),
                          ),
                        ),
                      Positioned(
                        top: 6,
                        right: 6,
                        child: Container(
                          width: 22,
                          height: 22,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: selected ? AppColors.primary : Colors.black.withOpacity(0.2),
                            border: Border.all(color: Colors.white.withOpacity(0.8), width: 2),
                          ),
                          child: selected
                              ? const Icon(Icons.check, color: Colors.white, size: 14)
                              : null,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.95),
              border: const Border(top: BorderSide(color: AppColors.border)),
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Text('已选 ', style: const TextStyle(fontSize: 14, color: AppColors.textSecondary)),
                  Text('$count', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.text)),
                  const Text(' 张', style: TextStyle(fontSize: 14, color: AppColors.textSecondary)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: count > 0
                          ? () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => PrintSettingsPage(selectedPhotos: _photos.where((p) => p.copies > 0).toList()),
                                ),
                              )
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                        elevation: 0,
                      ),
                      child: const Text('下一步', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
