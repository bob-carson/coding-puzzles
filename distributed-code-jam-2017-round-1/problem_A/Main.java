
public class Main {
  static long MAX_LONG = 9223372036854775807L;
  static int MASTER_NODE = 7;
  static int DONE = -1;

  public static void main(String[] args) {
    long N = pancakes.GetStackSize();
    long nodes = message.NumberOfNodes();
    long my_id = message.MyNodeId();
    long dinersPerNode = (N / nodes) + 1;

    long myCount = 0L;
    long startingDiner = dinersPerNode * my_id;
    if (startingDiner < N - 1) {
      long lastItem = pancakes.GetStackItem(startingDiner);
      for (long i = startingDiner; i < N - 1 && i < dinersPerNode * (my_id + 1); i += 1) {
        long nextItem = pancakes.GetStackItem(i + 1);

        if (lastItem > nextItem) {
          myCount++;
        }

        lastItem = nextItem;
      }
    }
    // System.out.println("max " + max + " min " + min);
    message.PutLL(MASTER_NODE, myCount);
    message.Send(MASTER_NODE);

    if (my_id == MASTER_NODE) {
      long count = 1L;

      for (int node = 0; node < nodes; ++node) {
        message.Receive(node);
        long nodeCount = message.GetLL(node);
        count += nodeCount;
      }
      // System.out.println("gmax " + global_max + " gmin " + global_min);
      System.out.println(count);
    }
  }
}
