enum ProductAvailability {
  redy,
  notRedy;

  String get caption {
    switch (this) {
      case ProductAvailability.redy:
        return "Tersedia";
      case ProductAvailability.notRedy:
        return "Tidak Tersedia";
    }
  }
}
