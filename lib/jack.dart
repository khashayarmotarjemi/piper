import 'dart:io';

class Jack {
  Future<List<Port>> getAllPorts() async {
    final result = await _runCommand('jack_lsp', ['-c']);
    List<String> raw = result.split("\n");
    final List<Port> ports = [];
    for (var element in raw) {
      if(element.startsWith(' ')) {
        ports.last.connectedTo.add(element.substring(3));
      } else {
        final port = Port(element, []);
        ports.add(port);
      }

    }

    return ports;
  }

  Future<String> clearAllConnections() async {
    final result = await _runCommand(
        "jack_disconnect", ['gx_head_amp:out_0', 'gx_head_fx:in_0']);
    print(result);
    return result.toString();
  }

  Future<String> _runCommand(String command, List<String> args) async {
    var result = await Process.run(command, args);
    // print();
    return result.stdout.toString();
  }
}

class Port {
  final String name;
  final List<String> connectedTo;

  Port(this.name, this.connectedTo);

  @override
  String toString() {
    return "name: $name\nconnections: $connectedTo\n\n";
  }
}
