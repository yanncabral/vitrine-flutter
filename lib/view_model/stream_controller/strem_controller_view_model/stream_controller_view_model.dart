import 'dart:async';

abstract class StreamControllerViewModel<State> {
  State get state;
  final controller = StreamController<State>.broadcast();

  void setState(Function() action) {
    action();
    controller.add(state);
  }

  void dispose() => controller.close();
}
