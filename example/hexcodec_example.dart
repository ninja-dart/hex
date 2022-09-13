import 'dart:math';

import 'package:ninja_hex/ninja_hex.dart';

void main() {
  final random = Random();
  final data = List<int>.generate(20, (index) => random.nextInt(256));
  print(data);
  final encoded = data.toHex;
  print(encoded);
  final decoded = encoded.decodeHex;
  print(decoded);
}
