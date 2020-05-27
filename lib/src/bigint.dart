BigInt bigIntFromHex(String input, {String separator = ':'}) {
  input = input.replaceAll(RegExp('$separator|\r|\n'), '');
  return BigInt.parse(input, radix: 16);
}
