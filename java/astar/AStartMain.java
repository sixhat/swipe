package astar;

import javax.swing.SwingUtilities;

public class AStartMain {
  public static void main(String[] args) {
    SwingUtilities.invokeLater(new Runnable() {
      @Override
      public void run() {
        new Janela();
      }
    });
  }
}
