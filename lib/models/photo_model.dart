class PhotoModel {
  final String id;
  final String? path;
  final String? emoji;
  final String name;
  int copies;
  String size;

  PhotoModel({
    required this.id,
    this.path,
    this.emoji,
    required this.name,
    this.copies = 1,
    this.size = '5寸',
  });
}

class PrinterModel {
  final String name;
  final String host;
  final int port;
  final String type;
  bool isOnline;

  PrinterModel({
    required this.name,
    required this.host,
    required this.port,
    required this.type,
    this.isOnline = true,
  });

  factory PrinterModel.fromMap(Map<String, dynamic> map) {
    return PrinterModel(
      name: map['name'] ?? '未知打印机',
      host: map['host'] ?? '',
      port: int.tryParse(map['port']?.toString() ?? '0') ?? 0,
      type: map['type'] ?? '_ipp._tcp',
      isOnline: true,
    );
  }
}
