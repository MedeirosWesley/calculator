import 'dart:math';

class Calculator {
  double sum(double n1, double n2) {
    return n1 + n2;
  }

  double sub(double n1, double n2) {
    return n1 - n2;
  }

  double divide(double n1, double n2) {
    return n1 / n2;
  }

  double multply(double n1, double n2) {
    return n1 * n2;
  }

  double percent(double n1, double n2) {
    return (n1 * n2) / 100;
  }

  double sqr(double n1) {
    return sqrt(n1);
  }

  double mod(double n1, double n2) {
    return n1 % n2;
  }
}
