import java.math.BigInteger;
import java.lang.Math;

public class Main {
  static long MAX_LONG = 9223372036854775807L;
  static long DONE = -1;
  static long MOD_VALUE = 1000000007L;

  public static long stevenIndexAbove(long value, long lowIndex, long highIndex) {
    if (lowIndex == highIndex) {
      return lowIndex;
    }

    if (lowIndex > highIndex) {
      throw new IllegalArgumentException("low > high");
    }

    long tryIndex = (highIndex + lowIndex) / 2;

    long tryValue = todd_and_steven.GetStevenValue(tryIndex);
    if (tryIndex == 0 || (tryValue > value && todd_and_steven.GetStevenValue(tryIndex - 1) < value)) {
      return tryIndex;
    }

    if (tryValue > value) {
      return stevenIndexAbove(value, lowIndex, tryIndex - 1);
    } else {
      return stevenIndexAbove(value, tryIndex + 1, highIndex);
    }
  }

  public static void main(String[] args) {
    long startTime = System.currentTimeMillis();

    long N = todd_and_steven.GetToddLength();
    long nodes = message.NumberOfNodes();
    long my_id = message.MyNodeId();
    long digitsPerNode = (N / nodes) + 1;

    final int MASTER_NODE = (int)(nodes - 1);
    final long STEVE_LENGTH = todd_and_steven.GetStevenLength();
    final long TODD_LENGTH = todd_and_steven.GetToddLength();

    long startingDigit = digitsPerNode * my_id;
    long endingDigit = Math.min(N - 1, (digitsPerNode * (my_id + 1)) - 1);
    long hashTotal = 0;
    if (startingDigit < N) {
      boolean isLastNode =(endingDigit == N - 1);

      long toddRunner = startingDigit;
      long toddValue = todd_and_steven.GetToddValue(startingDigit);
      // System.out.println("starting todd index " + startingDigit + " value " + startingValue);

      long steveRunner;
      if (startingDigit == 0) {
        steveRunner = 0;
      } else {
        long above = todd_and_steven.GetToddValue(startingDigit - 1);
        steveRunner = stevenIndexAbove(above, 0, todd_and_steven.GetStevenLength() - 1);
      }

      long steveValue = todd_and_steven.GetStevenValue(steveRunner);

      while (true) {
        if (toddValue < steveValue || steveRunner == STEVE_LENGTH) {
          hashTotal += (toddValue ^ (toddRunner + steveRunner)) % MOD_VALUE;
          toddRunner += 1;
          if (toddRunner > endingDigit) {
            break;
          }
          toddValue = todd_and_steven.GetToddValue(toddRunner);
        } else {
          hashTotal += (steveValue ^ (toddRunner + steveRunner)) % MOD_VALUE;
          steveRunner += 1;
          if (steveRunner < STEVE_LENGTH) {
            steveValue = todd_and_steven.GetStevenValue(steveRunner);
          }
        }
      }

      if (isLastNode) {
        // System.out.println("last node");

        while (steveRunner < STEVE_LENGTH) {
          steveValue = todd_and_steven.GetStevenValue(steveRunner);
            // System.out.println("last node adding value " + steveValue);
          hashTotal += (steveValue ^ (toddRunner + steveRunner)) % MOD_VALUE;
          steveRunner += 1;
        }
      }
    }

    message.PutLL(MASTER_NODE, hashTotal);
    message.Send(MASTER_NODE);


    // message.PutLL(MASTER_NODE, DONE);
    // message.Send(MASTER_NODE);


    if (my_id == MASTER_NODE) {
      // System.out.println("master node");
      BigInteger sum = BigInteger.valueOf(0L);

      for (int node = 0; node < nodes; ++node) {
        // System.out.println("receiveing " + node);
        message.Receive(node);
        sum = sum.add(BigInteger.valueOf(message.GetLL(node)));
      }

      BigInteger modValue = BigInteger.valueOf(MOD_VALUE);

      System.out.println(sum.mod(modValue));
    }
  }
}
