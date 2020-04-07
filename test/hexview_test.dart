import 'dart:typed_data';
import 'package:hexview/hexview.dart';
import 'package:test/test.dart';

void main() {
  group('HexView16', () {
    setUp(() {});

    test('Simple1', () {
      final nums = List<int>.generate(125, (i) => i + 5);
      final data = Uint8List.fromList(nums);
      final view = HexView16(5, data);
      expect(view.numRecords, 9);

      for (int i = 0; i < view.numRecords; i++) {
        final Record16 rec = view[i];
        expect(rec.startAddress, i * 16);
        expect(rec.endAddress, ((i + 1) * 16) - 1);
      }
    });

    test('Simple2', () {
      final nums = List<int>.generate(128, (i) => i);
      final data = Uint8List.fromList(nums);
      final view = HexView16(0, data);
      expect(view.numRecords, 8);

      for (int i = 0; i < view.numRecords; i++) {
        final Record16 rec = view[i];
        expect(rec.startAddress, i * 16);
        expect(rec.endAddress, ((i + 1) * 16) - 1);
      }
    });
  });
}
