class Utilities {
  static int getCurrentEpochDate() {
    var now = new DateTime.now();
    var year = now.year;
    var month = now.month;
    var day = now.day;
    var today = new DateTime(year, month, day);
    var milli = today.millisecondsSinceEpoch / 1000;

    print(milli);
    return milli.toInt();
  }

  static int getCurrentEpochMilliSecond() {
    return new DateTime.now().millisecondsSinceEpoch;
  }
}
