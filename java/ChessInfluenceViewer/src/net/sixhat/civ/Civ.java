package net.sixhat.civ;

import java.awt.BorderLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

import javax.swing.JFrame;
import javax.swing.JTextField;

public class Civ {
	public static void main(String[] args) {
		final JFrame jf = new JFrame("FEN Viewer");
		jf.setSize(600, 600);
		jf.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		final Board b = new Board();
		b.setupBoardFen("rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1");
		final GUI gui = new GUI(b);
		jf.setLayout(new BorderLayout());
		jf.add(gui, BorderLayout.CENTER);
		final JTextField texto = new JTextField();
		texto.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent e) {
				b.setupBoardFen(texto.getText());
				gui.bd = b.board;
				b.printBoard();
				// b.printBoardNames();
				b.computeSquareValues();
				b.printBoardValues();
				jf.repaint();
			}
		});
		jf.add(texto, BorderLayout.SOUTH);
		jf.setVisible(true);
		b.computeSquareValues();
		jf.repaint();
		BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
		String fen = "";
		try {
			while (!"quit".equals(fen)) {
				System.out.print("Enter FEN: ");
				fen = br.readLine();
				if ("quit".equals(fen)) {
					break;
				}
				b.setupBoardFen(fen.trim());
				gui.bd = b.board;
				b.printBoard();
				// b.printBoardNames();
				b.computeSquareValues();
				b.printBoardValues();
				gui.repaint();
			}
		} catch (IOException e) {
		}
	}
}
