// Sample input 1, in Java.
public class todd_and_steven {
  public todd_and_steven() {
  }

  public static long GetToddLength() {
    return 8L;
  }

  public static long GetStevenLength() {
    return 12L;
  }

  public static long GetToddValue(long i) {
    switch ((int)i) {
      case 0: return 3L; //1
      case 1: return 5L; //2
      case 2: return 7L; //4
      case 3: return 9L; //6
      case 4: return 11L; //7
      case 5: return 13L; //8
      case 6: return 15L; //9
      case 7: return 17L; //11
      default: throw new IllegalArgumentException("Invalid argument");
    }
  }

  public static long GetStevenValue(long i) {
    switch ((int)i) {
      case 0: return 2L; //0
      case 1: return 6L; //3
      case 2: return 8L; //5
      case 3: return 16L; //10
      case 4: return 26L; //12
      case 5: return 36L;
      case 6: return 46L;
      case 7: return 56L;
      case 8: return 66L;
      case 9: return 76L;
      case 10: return 86L;
      case 11: return 96L;
      case 12: return 116L;
      default: throw new IllegalArgumentException("Invalid argument");
    }
  }
}
