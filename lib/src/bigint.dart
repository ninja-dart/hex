/* TODO
extension BigIntAndHex on BigInt {
  String toHex({String separator = ':'}) {
    String ret = toRadixString(16);
    if(separator == '') return ret;


    // TODO
  } 
}
 */

BigInt bigIntFromHex(String input, {String separator = ':'}) {
  input = input.replaceAll(RegExp('$separator|\r|\n'), '');
  return BigInt.parse(input, radix: 16);
}