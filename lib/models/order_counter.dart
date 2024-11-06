// Change _OrderCounter to OrderCounter (remove underscore to make it public)
class OrderCounter {
  int _orderCount = 1; // Initial order count

  int get orderCount => _orderCount;

  void increment() {
    _orderCount++;
  }

  void decrement() {
    if (_orderCount > 1) {
      _orderCount--;
    }
  }

  void reset() {
    _orderCount = 1; // Reset to initial count
  }
}
