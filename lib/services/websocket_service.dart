import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

class WebSocketService {
  final String url;
  late WebSocketChannel channel;

  WebSocketService(this.url) {
    try {
      channel = WebSocketChannel.connect(Uri.parse(url));
    } catch (e) {
      throw Exception('Failed to connect to WebSocket');
    }
  }

  void listen(Function(dynamic) onData) {
    channel.stream.listen(
      onData,
      onError: (error) => print('WebSocket error: $error'),
      onDone: () => print('WebSocket connection closed'),
    );
  }

  void send(String message) {
    try {
      channel.sink.add(message);
    } catch (e) {
      throw Exception('Failed to send message');
    }
  }

  void close() {
    try {
      channel.sink.close(status.goingAway);
    } catch (e) {
      throw Exception('Failed to close WebSocket connection');
    }
  }
}
