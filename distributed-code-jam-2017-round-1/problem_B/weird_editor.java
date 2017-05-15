// Sample input 2, in Java.
public class weird_editor {
  public weird_editor() {
  }

  public static long GetNumberLength() {
    return 25L;
  }

  public static long GetDigit(long i) {
    switch ((int)i) {
      case 0: return 1L;
      case 1: return 0L;
      case 2: return 2L;
      case 3: return 3L;
      case 4: return 2L;
      case 5: return 1L;
      case 6: return 3L;
      case 7: return 0L;
      case 8: return 1L;
      case 9: return 0L;
      case 10: return 2L;
      case 11: return 0L;
      case 12: return 2L;
      case 13: return 3L;
      case 14: return 2L;
      case 15: return 1L;
      case 16: return 3L;
      case 17: return 0L;
      case 18: return 3L;
      case 19: return 0L;
      case 20: return 2L;
      case 21: return 0L;
      case 22: return 2L;
      case 23: return 3L;
      case 24: return 2L;
      default: throw new IllegalArgumentException("Invalid argument");
    }
  }
}
