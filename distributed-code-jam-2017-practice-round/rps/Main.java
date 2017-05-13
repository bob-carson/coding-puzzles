
public class Main {
  static long MAX_LONG = 9223372036854775807L;
  static int MASTER_NODE = 0;
  static int DONE = -1;

  public static boolean leftWins(char l, long l_index, char r, long r_index) {
    if (l == r) {
      return l_index < r_index;
    }
    switch(l) {
      case 'R':
        return r != 'P';
      case 'P':
        return r != 'S';
      case 'S':
        return r != 'R';
      default:
        throw new IllegalArgumentException("Invalid argument");
    }
  }

  public static long numForRoundsLeft(int roundsLeft) {
    if (roundsLeft == 1) {
      return 2;
    } else {
      return 2 * numForRoundsLeft(roundsLeft - 1);
    }
  }

  public static void main(String[] args) {
    int N = (int)rps.GetN();
    int nodes = (int)message.NumberOfNodes();
    int my_id = (int)message.MyNodeId();

    for (long i = my_id; i < numForRoundsLeft(N) / 2; i += nodes) {
      char l = rps.GetFavoriteMove(i * 2);
      char r = rps.GetFavoriteMove(i * 2 + 1);
      long winner;
      char move;
      if (leftWins(l, i*2, r, i*2+1)) {
        winner = i*2;
        move = l;
      } else {
        winner = i*2 + 1;
        move = r;
      }

      System.out.println("winner " + winner + " " + move);

      int sendToNode = (int)(i / 2);
            // System.out.println("send to  " + sendToNode);
      message.PutLL(sendToNode, winner);
      message.PutChar(sendToNode, move);
      message.Send(sendToNode);
    }

    for (int roundsLeft = N-1; roundsLeft > 0; roundsLeft--) {
      // Stop eveeryone between rounds
      

      for (long i = my_id; i < numForRoundsLeft(roundsLeft) / 2; i += nodes) {
            // System.out.println("roundsLeft " + roundsLeft + " i " + i);
        int source = message.Receive(-1);
        long l_index = message.GetLL(source);
        char l_move = message.GetChar(source);
        // System.out.println("l " + l_index + " " + l_move);
        source = message.Receive(-1);
        long r_index = message.GetLL(source);
        char r_move = message.GetChar(source);
        // System.out.println("r " + r_index + " " + r_move);

        long winner;
        char move;
        if (leftWins(l_move, l_index, r_move, r_index)) {
          winner = l_index;
          move = l_move;
        } else {
          winner = r_index;
          move = r_move;
        }

              System.out.println("winner " + winner + " " + move);

        if (roundsLeft == 1) {
          System.out.println(winner);
        } else {
          int sendToNode = (int)(i / 2);
          message.PutLL(sendToNode, winner);
          message.PutChar(sendToNode, move);
          message.Send(sendToNode);
        }


      }
    }
  }
}
