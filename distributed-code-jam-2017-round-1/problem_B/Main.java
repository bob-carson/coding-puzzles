import java.math.BigInteger;
import java.lang.Math;

public class Main {
  static long MAX_LONG = 9223372036854775807L;
  static long DONE = -1;

  public static void main(String[] args) {
    long startTime = System.currentTimeMillis();

    long N = weird_editor.GetNumberLength();
    long nodes = message.NumberOfNodes();
    long my_id = message.MyNodeId();
    long digitsPerNode = (N / nodes) + 1;

    final int MASTER_NODE = (int)(nodes - 1);

    long startingDigit = digitsPerNode * my_id;
    long endingDigit = Math.min(N - 1, (digitsPerNode * (my_id + 1)) - 1);
    if (startingDigit < N) {
      long max = 1L;
      for (long i = endingDigit; i >= startingDigit; i -= 1) {
        long nextDigit = weird_editor.GetDigit(i);

        if (nextDigit >= max) {
          message.PutLL(MASTER_NODE, nextDigit);
          max = nextDigit;
        }
      }


      // for (long i = startingDigit; i < N && i < digitsPerNode * (my_id + 1); i += 1) {
      //   long nextDigit = weird_editor.GetDigit(i);
      //
      //   if (nextDigit != 0L) {
      //     message.PutLL(MASTER_NODE, nextDigit);
      //   }
      // }
    }
    // System.out.println("max " + max + " min " + min);
    message.PutLL(MASTER_NODE, DONE);
    message.Send(MASTER_NODE);

    if (my_id == MASTER_NODE) {
      long masterStartTime = System.currentTimeMillis();
      StringBuilder sb = new StringBuilder("");

      long max = 1L;
      for (int node = (int)(nodes - 1); node >= 0; --node) {
        message.Receive(node);

        while(true) {
          long digit = message.GetLL(node);
          if (digit != DONE) {
            if (digit >= max) {
              sb.append(String.valueOf(digit));
              max = digit;
            }
          } else {
            break;
          }
        }
      }

      sb = sb.reverse();

      System.out.println("message time " + (System.currentTimeMillis() - masterStartTime));

      while(sb.length() < N) {
        sb.append("0");
      }

      System.out.println("append time " + (System.currentTimeMillis() - masterStartTime));

      BigInteger value = new BigInteger(sb.toString());
      BigInteger prime = new BigInteger("1000000007");

      BigInteger result = value.mod(prime);

      System.out.println("mod time " + (System.currentTimeMillis() - masterStartTime));

      System.out.println("total time " + (System.currentTimeMillis() - startTime));

      System.out.println(result.toString());
    }
  }
}
