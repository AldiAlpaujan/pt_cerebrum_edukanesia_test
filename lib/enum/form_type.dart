enum FormType {
  add,
  edit;

  bool get isAdd => this == FormType.add;
  bool get isEdit => this == FormType.edit;

  String getCaptionByValue(String addCap, String editCap) {
    switch (this) {
      case FormType.add:
        return addCap;
      case FormType.edit:
        return editCap;
    }
  }
}
