import 'dart:typed_data';

import 'hex_conv.dart';

abstract class Record {
  int get startAddress;

  /// The data. [null] value means unknown.
  List<int> get data;

  int get length;

  int get endAddress => startAddress + (data.length > 0 ? data.length - 1 : 0);

  int operator [](int address);

  operator []=(int address, int value);

  Record16 withOffset(int offset);
}

/// A 16 byte record
class Record16 implements Record {
  final int startAddress;

  /// The data. [null] value means unknown.
  final List<int> data;

  int get length => 16;

  int get endAddress => startAddress + 15;

  Record16._(this.startAddress, this.data);

  Record16(this.startAddress, List<int> data)
      : data = new List<int>.from(data, growable: false) {
    if (startAddress & 0xF != 0)
      throw new Exception('Start address must be in 16-byte boundary!');
    if (data.length != 16) throw new Exception('Data length must be 16!');
  }

  factory Record16.adjust(int startAddress, List<int> data) {
    if(data.length > 16) throw new ArgumentError.value(data, 'data', 'Invalid length!');

    final int corAddr = startAddress & ~0xF;

    final d = new List<int>(16);
    int i = 0;

    // Fill facing nulls
    for(; i < (startAddress - corAddr); i++) {
      d[i] = null;
    }

    for(int datum in data) {
      d[i] = datum;
      i++;
    }

    return new Record16._(corAddr, d);
  }

  int operator [](int address) {
    if (address < startAddress || address > endAddress)
      throw new RangeError.range(address, startAddress, endAddress, 'address');

    return data[address - startAddress];
  }

  operator []=(int address, int value) {
    if (address < startAddress || address > endAddress)
      throw new RangeError.range(address, startAddress, endAddress, 'address');
    data[address - startAddress] = value;
  }

  Record16 withOffset(int offset) => new Record16(startAddress + offset, data);

  String toString() {
    final sb = new StringBuffer();
    sb.write('0x' + Hex.toHex32Str(startAddress));
    sb.write('\t');
    for (int datum in data) {
      if(datum != null) {
        sb.write(Hex.toHex8Str(datum));
      } else {
        sb.write('--');
      }
      sb.write(' ');
    }
    return sb.toString();
  }
}

/// Provides hexadecimal view of byte array
class HexView16 {
  /// Starting address of the byte array
  final int startAddress;

  /// The byte array
  final Uint8List data;

  const HexView16(this.startAddress, this.data);

  int get length => data.length;

  int get endAddress => startAddress + (data.length > 0 ? data.length - 1 : 0);

  int get numRecords {
    final int alignSA = startAddress & ~0xF;
    final int alignEA = endAddress & ~0xF;

    if(alignSA == alignEA) return 1;

    return ((alignEA - startAddress)/16).ceil() + 1;
  }

  Record16 operator[](int recNum) => getRecord(recNum);

  Record16 getRecord(int recNum) {
    if (recNum < 0 || recNum >= numRecords) {
      throw new RangeError.range(recNum, 0, numRecords - 1, 'recNum');
    }

    if(recNum == 0) {
      int end = length;
      if(length > 16) {
        end = ((startAddress + 16) & ~0xF) - startAddress;
      }
      return new Record16.adjust(startAddress, data.sublist(0, end));
    } else if(recNum == (numRecords - 1)) {
      final int start = (endAddress & ~0xF) - startAddress;
      return new Record16.adjust(endAddress & ~0xF, data.sublist(start, length));
    } else {
      final int startAddr = (startAddress & ~0xF) + (recNum * 16);
      final int start = startAddr - startAddress;
      return new Record16(startAddr, data.sublist(start, start + 16));
    }
  }

  String toString() {
    final sb = new StringBuffer();

    for(int i = 0; i < numRecords; i++) {
      sb.writeln(getRecord(i));
    }

    return sb.toString();
  }
}
