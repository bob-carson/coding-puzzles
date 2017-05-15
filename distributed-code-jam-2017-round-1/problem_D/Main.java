
public class Main {
  static long MAX_LONG = 9223372036854775807L;
  static int MASTER_NODE = 7;
  static int DONE = -1;

  public static void main(String[] args) {
    long N = oops.GetN();
    long nodes = message.NumberOfNodes();
    long my_id = message.MyNodeId();
    long max = 0L;
    long min = MAX_LONG;
    for (long i = my_id; i < N; i += nodes) {
      long number = oops.GetNumber(i);
      if (max < number) {
        max = number;
      }
      if (min > number) {
        min = number;
      }
    }
    // System.out.println("max " + max + " min " + min);
    message.PutLL(MASTER_NODE, max);
    message.PutLL(MASTER_NODE, min);
    message.Send(MASTER_NODE);

    if (my_id == MASTER_NODE) {
      long global_max = 0L;
      long global_min = MAX_LONG;

      for (int node = 0; node < nodes; ++node) {
        message.Receive(node);
        long node_max = message.GetLL(node);
        long node_min = message.GetLL(node);
        // System.out.println("node " + node + " max " + node_max + " min " + node_min);
        if (global_min > node_min) {
          // System.out.println("new gmin " + node_min);
          global_min = node_min;
        }
        if (global_max < node_max) {
          // System.out.println("new gmax " + node_max);
          global_max = node_max;
        }
      }
      // System.out.println("gmax " + global_max + " gmin " + global_min);
      System.out.println(global_max - global_min);
    }
  }
}
