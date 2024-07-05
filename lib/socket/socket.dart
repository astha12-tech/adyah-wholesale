import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketScreen extends StatefulWidget {
  const SocketScreen({super.key});

  @override
  State<SocketScreen> createState() => _SocketScreenState();
}

class _SocketScreenState extends State<SocketScreen> {
  void connectToSocket() {
    try {
      final socket = io.io('http://192.168.1.114:3000', <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
      });

      socket.connect();

      socket.on('connect', (_) => debugPrint('connect: ${socket.id}'));
      socket.on('location', handleLocationListen);

      socket.on('typing', handleTyping);
      socket.on('message', handleMessage);
      socket.on('disconnect', (_) => debugPrint('disconnect'));
      socket.on('fromServer', (_) => debugPrint(_));
    } catch (e) {
      debugPrint("=== error scoket is here ===>>>${e.toString()}");
    }
  }

  void handleMessage(dynamic data) {
    if (data is Map<String, dynamic>) {
      debugPrint("=== data is here ===>> $data");
    } else {
      debugPrint('Unexpected data format: $data');
    }
  }

  handleLocationListen(dynamic data) async {
    if (data is Map<String, dynamic>) {
      debugPrint("=== data is here ===>> $data");
    } else {
      debugPrint('Unexpected data format: $data');
    }
  }

  void handleTyping(dynamic data) {
    if (data is Map<String, dynamic>) {
      debugPrint("=== data is here ===>> $data");
    } else {
      debugPrint('Unexpected data format: $data');
    }
  }

  @override
  void initState() {
    connectToSocket();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
