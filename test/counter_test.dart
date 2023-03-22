import 'package:flutter_test/flutter_test.dart';
import 'package:learning_project/counter_code.dart';

void main() {
  test('This is description of counter test', () {
    final Counter counter = Counter();
    final val = counter.count;
    expect(val, 0);
  });
}
