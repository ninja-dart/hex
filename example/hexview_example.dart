import 'dart:typed_data';
import 'package:hexview/hexview.dart';

main() {
	final nums = new List<int>.generate(125, (i) => i + 5);
	final data = new Uint8List.fromList(nums);
	final view = new HexView16(5, data);
	print(view.numRecords);

	for(int i = 0; i < view.numRecords; i++) {
		print(view[i]);
	}
}
