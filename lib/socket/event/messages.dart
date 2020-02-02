class Messages {
  List<Message> events;

  Messages();

  factory Messages.fromJson(List<dynamic> json) {
    List<Message> result = json.map((i) => Message(i)).toList();
    return Messages()..events = result;
  }
}

class Message {
  List<dynamic> events;

  Message(this.events);

  String get name => events[0];

  T data<T extends EventData>(T eventData) {
    return eventData.fromJson(events[1]);
  }
}

abstract class EventData {
  EventData fromJson(Map<String, dynamic> json) {
    return from(json);
  }

  EventData from(json);
}
