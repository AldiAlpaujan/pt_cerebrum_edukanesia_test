String? emailValidator(String email) {
  if (email != "") {
    var regex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(email);
    if (regex) {
      return null;
    } else {
      return "Email tidak valid!";
    }
  } else {
    return "Email harus diisi!";
  }
}

String? phoneValidator(String field, String value) {
  if (value.isNotEmpty) {
    var regex = RegExp(
      r"^[0-9]+$",
    ).hasMatch(value);
    if (regex) {
      return null;
    } else {
      return "$field harus valid!";
    }
  } else {
    return "$field  harus diisi!";
  }
}

String? pwValidator(String? password) {
  if (password != null && password != "") {
    return null;
  } else {
    return "Kata Sandi harus diisi!";
  }
}

String? pwStrongValidation(String password, bool strong) {
  if (password != "") {
    if (strong) {
      return null;
    } else {
      return "Kata Sandi tidak memenuhi syarat";
    }
  } else {
    return "Kata Sandi harus diisi!";
  }
}

String? pwConfirmValidator(String password, String confirm) {
  if (confirm == "") {
    return "Konfirmasi Kata Sandi harus diisi!";
  } else {
    if (confirm == password) {
      return null;
    } else {
      return "Konfirmasi Kata Sandi tidak sesuai!";
    }
  }
}

String? emptyValidator(String field, String value) {
  if (value.isNotEmpty) {
    return null;
  } else {
    return "$field harus diisi!";
  }
}

String? nikValidator(String value) {
  if (value.isNotEmpty) {
    if (value.length == 16) {
      return null;
    } else {
      return "NIK harus berisi angka 16 digit";
    }
  } else {
    return "NIK harus diisi!";
  }
}

String? paymentValidator(String value, double money, double total) {
  if (value.isNotEmpty) {
    if (money < total) {
      return "Uang yang diMasukkan tidak cukup";
    } else {
      return null;
    }
  } else {
    return "Anda belum meMasukkan uang";
  }
}
