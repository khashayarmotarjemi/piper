import 'package:piper/jack.dart';

main() async {
  final jack = Jack();
  final ports = await jack.getAllPorts();
  print(ports);
}