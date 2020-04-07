library hexview.hex.conv;

import 'dart:math' as math;

abstract class Hex {
  static String hex8(int data) {
    if (data < 0 || data > 255) throw Exception('Invalid data!');
    String digits = data.toRadixString(16).toUpperCase();
    digits = '0' * (2 - digits.length) + digits;
    return digits;
  }

  static String hex16(int data) {
    if (data < 0 || data > 0xFFFF) throw Exception('Invalid data!');
    String digits = data.toRadixString(16).toUpperCase();
    digits = '0' * (4 - digits.length) + digits;
    return digits;
  }

  static String hex24(int data) {
    if (data < 0 || data > 0xFFFFFF) throw Exception('Invalid data!');
    String digits = data.toRadixString(16).toUpperCase();
    digits = '0' * (6 - digits.length) + digits;
    return digits;
  }

  static String hex32(int data) {
    if (data < 0 || data > 0xFFFFFFFF) throw Exception('Invalid data!');
    String digits = data.toRadixString(16).toUpperCase();
    digits = '0' * (8 - digits.length) + digits;
    return digits;
  }

  static String hex8List(List<int> data, {String join = ' '}) =>
      data.map(hex8).join(join);

  static String hex16List(List<int> data, {String join = ' '}) =>
      data.map(hex16).join(join);

  static String hex24List(List<int> data, {String join = ' '}) =>
      data.map(hex24).join(join);

  static String hex32List(List<int> data, {String join = ' '}) =>
      data.map(hex32).join(join);
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

  static int byte0(int data) => data & 0xFF;

  static int byte1(int data) => (data >> 8) & 0xFF;

  static int byte2(int data) => (data >> 16) & 0xFF;

  static int byte3(int data) => (data >> 24) & 0xFF;

  static List<int> bytes2(int data) =>
      <int>[]..add(byte1(data))..add(byte0(data));

  static List<int> bytes3(int data) =>
      <int>[]..add(byte2(data))..add(byte1(data))..add(byte0(data));

  static List<int> bytes4(int data) => <int>[]
    ..add(byte3(data))
    ..add(byte2(data))
    ..add(byte1(data))
    ..add(byte0(data));
}

abstract class Math {
  static double log(int value, int base) => math.log(value) / math.log(base);

  static double log2(int value) => math.log(value) / math.log(2);

  static double log10(int value) => math.log(value) / math.log(10);
}
