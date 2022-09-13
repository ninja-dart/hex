library hexview.hex.conv;

import 'dart:math' as math;

extension IntHexExt on int {
  String get hex8 {
    if (this < 0 || this > 255) throw Exception('Invalid data!');
    return toRadixString(16).toUpperCase().padLeft(2, '0');
  }

  String get hex16 {
    if (this < 0 || this > 0xFFFF) throw Exception('Invalid data!');
    return toRadixString(16).toUpperCase().padLeft(4, '0');
  }

  String get hex24 {
    if (this < 0 || this > 0xFFFFFF) throw Exception('Invalid data!');
    return toRadixString(16).toUpperCase().padLeft(6, '0');
  }

  String get hex32 {
    if (this < 0 || this > 0xFFFFFFFF) throw Exception('Invalid data!');
    return toRadixString(16).toUpperCase().padLeft(8, '0');
  }

  int get byte0 => this & 0xFF;

  int get byte1 => (this >> 8) & 0xFF;

  int get byte2 => (this >> 16) & 0xFF;

  int get byte3 => (this >> 24) & 0xFF;

  List<int> get bytes2 => [byte1, byte0];
  List<int> get bytes3 => [byte2, byte1, byte0];
  List<int> get bytes4 => [byte3, byte2, byte1, byte0];
}

extension HexListExt on Iterable<int> {
  String toHex8List({String join = ' '}) => map((e) => e.hex8).join(join);
  String toHex16List({String join = ' '}) => map((e) => e.hex16).join(join);
  String toHex24List({String join = ' '}) => map((e) => e.hex24).join(join);
  String toHex32List({String join = ' '}) => map((e) => e.hex32).join(join);
}

abstract class UInt {
  static int toNibble(final int data) {
    if (data >= 48 && data <= 57) {
      return data - 48;
    } else if (data >= 65 && data <= 70) {
      return 10 + data - 65;
    } else if (data >= 97 && data <= 102) {
      return 10 + data - 97;
    } else {
      throw Exception('Not valid hex $data!');
    }
  }

  static int toUint8(int data1, int data0) {
    int data = toNibble(data1);
    data <<= 4;
    data |= toNibble(data0);
    return data;
  }

  static int toUint16(int data3, int data2, int data1, int data0) {
    int data = toUint8(data3, data2);
    data <<= 8;
    data |= toUint8(data1, data0);
    return data;
  }

  static int toUint24(
      int data5, int data4, int data3, int data2, int data1, int data0) {
    int data = toUint8(data5, data4);
    data <<= 8;
    data |= toUint8(data3, data2);
    data <<= 8;
    data |= toUint8(data1, data0);
    return data;
  }

  static int toUint32(int data7, int data6, int data5, int data4, int data3,
      int data2, int data1, int data0) {
    int data = toUint8(data7, data6);
    data <<= 8;
    data = toUint8(data5, data4);
    data <<= 8;
    data |= toUint8(data3, data2);
    data <<= 8;
    data |= toUint8(data1, data0);
    return data;
  }
}

abstract class Math {
  static double log(int value, int base) => math.log(value) / math.log(base);

  static double log2(int value) => math.log(value) / math.log(2);

  static double log10(int value) => math.log(value) / math.log(10);
}
