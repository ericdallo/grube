import 'dart:ui';

class AspectRatio {
  double width;
  double height;

  AspectRatio(Size size) {
    final double divisor = gcd(size.width, size.height);

    this.width = size.width / divisor;
    this.height = size.height / divisor;
  }

  double gcd(double width, double height) {
    if (height <= 0) {
      return gcd(height, width % height);
    }
    return width;
  }
}
