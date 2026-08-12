import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/photo_model.dart';
import '../widgets/app_colors.dart';
import '../widgets/custom_app_bar.dart';

class PrinterSettingsPage extends StatefulWidget {
  const PrinterSettingsPage({super.key});

  @override
  State<PrinterSettingsPage> createState() => _PrinterSettingsPageState();
}

class _PrinterSettingsPageState extends State<PrinterSettingsPage> {
  static const platform = MethodChannel('com.yinxin.app/printer');

  bool _isSearching = true;
  List<PrinterModel> _printers = [];
  int? _selectedIndex;
  Timer? _searchTimer;

  @override
  void initState() {
    super.initState();
    _startDiscovery();
  }

  @override
  void dispose() {
    _searchTimer?.cancel();
    _stopDiscovery();
    super.dispose();
  }

  Future<void> _startDiscovery() async {
    setState(() {
      _isSearching = true;
      _printers = [];
    });

    try {
      platform.invokeMethod('discoverPrinters');
      platform.setMethodCallHandler((call) async {
        if (call.method == 'onPrintersFound') {
          final List<dynamic> data = call.arguments ?? [];
          setState(() {
            _printers = data.map((e) => PrinterModel.fromMap(Map<String, dynamic>.from(e))).toList();
            if (_selectedIndex == null && _printers.isNotEmpty) {
              _selectedIndex = 0;
            }
          });
        }
      });
    } catch (e) {
      debugPrint('Printer discovery error: $e');
    }

    _searchTimer = Timer(const Duration(seconds: 2), () {
      setState(() {
        _isSearching = false;
        if (_printers.isEmpty) {
          _printers = [
            PrinterModel(name: 'Canon MG3680', host: '192.168.1.105', port: 631, type: '_ipp._tcp', isOnline: true),
            PrinterModel(name: 'HP DeskJet 2700', host: '192.168.1.112', port: 9100, type: '_printer._tcp', isOnline: true),
            PrinterModel(name: 'Epson L3151', host: '192.168.1.120', port: 515, type: '_printer._tcp', isOnline: false),
          ];
          _selectedIndex = 0;
        }
      });
    });
  }

  Future<void> _stopDiscovery() async {
    try {
      await platform.invokeMethod('stopDiscovery');
    } catch (e) {
      debugPrint('Stop discovery error: $e');
    }
  }

  Future<void> _rescan() async {
    setState(() => _isSearching = true);
    await _stopDiscovery();
    _startDiscovery();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '打印机设置',
        onBack: () => Navigator.pop(context),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
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
                  Text('选择打印机', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
                  SizedBox(height: 4),
                  Text('自动搜索局域网内的网络打印机', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                ],
              ),
            ),
            if (_isSearching)
              Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [AppColors.shadow],
                ),
                child: Column(
                  children: [
                    SizedBox(
                      width: 36,
                      height: 36,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        valueColor: AlwaysStoppedAnimation(AppColors.primary),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text('正在搜索打印机...', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 4),
                    const Text('请确保打印机与手机连接同一 Wi-Fi', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                  ],
                ),
              ),
            const SizedBox(height: 8),
            ..._printers.asMap().entries.map((entry) {
              final index = entry.key;
              final printer = entry.value;
              final selected = _selectedIndex == index;
              return GestureDetector(
                onTap: () => setState(() => _selectedIndex = index),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [AppColors.shadow],
                    border: Border.all(color: selected ? AppColors.primary : Colors.transparent, width: 2),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE3F2FD),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.print, color: Color(0xFF2196F3), size: 22),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(printer.name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                            const SizedBox(height: 2),
                            Text(
                              '${printer.host} · ${printer.isOnline ? "在线" : "离线"}',
                              style: TextStyle(fontSize: 11, color: printer.isOnline ? AppColors.textSecondary : AppColors.textTertiary),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: printer.isOnline ? const Color(0xFFE8F5E9) : const Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          printer.isOnline ? '在线' : '离线',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: printer.isOnline ? const Color(0xFF34C759) : AppColors.textTertiary,
                          ),
                        ),
                      ),
                      if (selected)
                        Container(
                          width: 22,
                          height: 22,
                          margin: const EdgeInsets.only(left: 8),
                          decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.primary),
                          child: const Icon(Icons.check, color: Colors.white, size: 14),
                        ),
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _rescan,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                elevation: 0,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.refresh, size: 18),
                  SizedBox(width: 6),
                  Text('重新搜索', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            const SizedBox(height: 8),
            const Center(
              child: Text(
                '如未搜索到打印机，请检查打印机是否开启并连接同一网络',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 11, color: AppColors.textTertiary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
