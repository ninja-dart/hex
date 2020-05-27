import 'dart:math';

import 'package:ninja_hex/ninja_hex.dart';

void main() {
  final random = Random();
  final data = List<int>.generate(20, (index) => random.nextInt(256));
  print(data);
  final encoded = hexEncode(data);
  print(encoded);
  final decoded = hexDecode(encoded);
  print(decoded);
}
