import 'dart:typed_data';
import 'package:hexview/hexview.dart';

void main() {
	final nums = List<int>.generate(125, (i) => i + 5);
	final data = Uint8List.fromList(nums);
	final view = HexView16(5, data);
	print(view.numRecords);

	print(view);
}
