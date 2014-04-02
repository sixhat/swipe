package net.sixhat.civ;

public class Board {
	Square[][]	board;
	String		files	= "abcdefgh";
	String		rows	= "12345678";

	public Board() {
		board = new Square[8][8];
	}

	public void computeSquareValues() {
		int x, y;
		int[] xx = { -2, -1, 1, 2 };
		int[] yy = { -2, -1, 1, 2 };
		for (int f = 0; f < 8; f++) {
			for (int r = 0; r < 8; r++) {
				switch (board[f][r].piece) {
				// White Pieces first
					case "R":
						// horizontal
						x = f + 1;
						while (x < 8) {
							board[x][r].value++;
							if (!"-".equals(board[x][r].piece)) {
								break;
							}
							x++;
						}
						x = f - 1;
						while (x >= 0) {
							board[x][r].value++;
							if (!"-".equals(board[x][r].piece)) {
								break;
							}
							x--;
						}
						// Vertical
						y = r + 1;
						while (y < 8) {
							board[f][y].value++;
							if (!"-".equals(board[f][y].piece)) {
								break;
							}
							y++;
						}
						y = r - 1;
						while (y >= 0) {
							board[f][y].value++;
							if (!"-".equals(board[f][y].piece)) {
								break;
							}
							y--;
						}
						break;
					case "r":
						// horizontal
						x = f + 1;
						while (x < 8) {
							board[x][r].value--;
							if (!"-".equals(board[x][r].piece)) {
								break;
							}
							x++;
						}
						x = f - 1;
						while (x >= 0) {
							board[x][r].value--;
							if (!"-".equals(board[x][r].piece)) {
								break;
							}
							x--;
						}
						// Vertical
						y = r + 1;
						while (y < 8) {
							board[f][y].value--;
							if (!"-".equals(board[f][y].piece)) {
								break;
							}
							y++;
						}
						y = r - 1;
						while (y >= 0) {
							board[f][y].value--;
							if (!"-".equals(board[f][y].piece)) {
								break;
							}
							y--;
						}
						break;
					case "N":
						for (int x1 : xx) {
							for (int y1 : yy) {
								if ((Math.abs(x1) + Math.abs(y1)) == 3) {
									int x2 = x1 + f;
									int y2 = y1 + r;
									if (x2 >= 0 && x2 < 8 && y2 >= 0 && y2 < 8) {
										board[x2][y2].value++;
									}
								}
							}
						}
						break;
					case "n":
						for (int x1 : xx) {
							for (int y1 : yy) {
								if ((Math.abs(x1) + Math.abs(y1)) == 3) {
									int x2 = x1 + f;
									int y2 = y1 + r;
									if (x2 >= 0 && x2 < 8 && y2 >= 0 && y2 < 8) {
										board[x2][y2].value--;
									}
								}
							}
						}
						break;
					case "B":
						x = f + 1;
						y = r + 1;
						while (x < 8 && y < 8) {
							board[x][y].value++;
							if (!"-".equals(board[x][y].piece)) {
								break;
							}
							x++;
							y++;
						}
						x = f - 1;
						y = r - 1;
						while (x >= 0 && y >= 0) {
							board[x][y].value++;
							if (!"-".equals(board[x][y].piece)) {
								break;
							}
							x--;
							y--;
						}
						x = f + 1;
						y = r - 1;
						while (x < 8 && y >= 0) {
							board[x][y].value++;
							if (!"-".equals(board[x][y].piece)) {
								break;
							}
							x++;
							y--;
						}
						x = f - 1;
						y = r + 1;
						while (x >= 0 && y < 8) {
							board[x][y].value++;
							if (!"-".equals(board[x][y].piece)) {
								break;
							}
							x--;
							y++;
						}
						break;
					case "b":
						x = f + 1;
						y = r + 1;
						while (x < 8 && y < 8) {
							board[x][y].value--;
							if (!"-".equals(board[x][y].piece)) {
								break;
							}
							x++;
							y++;
						}
						x = f - 1;
						y = r - 1;
						while (x >= 0 && y >= 0) {
							board[x][y].value--;
							if (!"-".equals(board[x][y].piece)) {
								break;
							}
							x--;
							y--;
						}
						x = f + 1;
						y = r - 1;
						while (x < 8 && y >= 0) {
							board[x][y].value--;
							if (!"-".equals(board[x][y].piece)) {
								break;
							}
							x++;
							y--;
						}
						x = f - 1;
						y = r + 1;
						while (x >= 0 && y < 8) {
							board[x][y].value--;
							if (!"-".equals(board[x][y].piece)) {
								break;
							}
							x--;
							y++;
						}
						break;
					case "Q":
						// Rook + Bishop?
						x = f + 1;
						while (x < 8) {
							board[x][r].value++;
							if (!"-".equals(board[x][r].piece)) {
								break;
							}
							x++;
						}
						x = f - 1;
						while (x >= 0) {
							board[x][r].value++;
							if (!"-".equals(board[x][r].piece)) {
								break;
							}
							x--;
						}
						// Vertical
						y = r + 1;
						while (y < 8) {
							board[f][y].value++;
							if (!"-".equals(board[f][y].piece)) {
								break;
							}
							y++;
						}
						y = r - 1;
						while (y >= 0) {
							board[f][y].value++;
							if (!"-".equals(board[f][y].piece)) {
								break;
							}
							y--;
						}
						x = f + 1;
						y = r + 1;
						while (x < 8 && y < 8) {
							board[x][y].value++;
							if (!"-".equals(board[x][y].piece)) {
								break;
							}
							x++;
							y++;
						}
						x = f - 1;
						y = r - 1;
						while (x >= 0 && y >= 0) {
							board[x][y].value++;
							if (!"-".equals(board[x][y].piece)) {
								break;
							}
							x--;
							y--;
						}
						x = f + 1;
						y = r - 1;
						while (x < 8 && y >= 0) {
							board[x][y].value++;
							if (!"-".equals(board[x][y].piece)) {
								break;
							}
							x++;
							y--;
						}
						x = f - 1;
						y = r + 1;
						while (x >= 0 && y < 8) {
							board[x][y].value++;
							if (!"-".equals(board[x][y].piece)) {
								break;
							}
							x--;
							y++;
						}
						break;
					case "q":
						x = f + 1;
						while (x < 8) {
							board[x][r].value--;
							if (!"-".equals(board[x][r].piece)) {
								break;
							}
							x++;
						}
						x = f - 1;
						while (x >= 0) {
							board[x][r].value--;
							if (!"-".equals(board[x][r].piece)) {
								break;
							}
							x--;
						}
						// Vertical
						y = r + 1;
						while (y < 8) {
							board[f][y].value--;
							if (!"-".equals(board[f][y].piece)) {
								break;
							}
							y++;
						}
						y = r - 1;
						while (y >= 0) {
							board[f][y].value--;
							if (!"-".equals(board[f][y].piece)) {
								break;
							}
							y--;
						}
						x = f + 1;
						y = r + 1;
						while (x < 8 && y < 8) {
							board[x][y].value--;
							if (!"-".equals(board[x][y].piece)) {
								break;
							}
							x++;
							y++;
						}
						x = f - 1;
						y = r - 1;
						while (x >= 0 && y >= 0) {
							board[x][y].value--;
							if (!"-".equals(board[x][y].piece)) {
								break;
							}
							x--;
							y--;
						}
						x = f + 1;
						y = r - 1;
						while (x < 8 && y >= 0) {
							board[x][y].value--;
							if (!"-".equals(board[x][y].piece)) {
								break;
							}
							x++;
							y--;
						}
						x = f - 1;
						y = r + 1;
						while (x >= 0 && y < 8) {
							board[x][y].value--;
							if (!"-".equals(board[x][y].piece)) {
								break;
							}
							x--;
							y++;
						}
						break;
					case "K":
						for (int dx = -1; dx < 2; dx++) {
							for (int dy = -1; dy < 2; dy++) {
								if (Math.abs(dx) + Math.abs(dy) != 0) {
									x = f + dx;
									y = r + dy;
									if (x >= 0 && x < 8 && y >= 0 && y < 8) {
										board[x][y].value++;
									}
								}
							}
						}
						break;
					case "k":
						for (int dx = -1; dx < 2; dx++) {
							for (int dy = -1; dy < 2; dy++) {
								if (Math.abs(dx) + Math.abs(dy) != 0) {
									x = f + dx;
									y = r + dy;
									if (x >= 0 && x < 8 && y >= 0 && y < 8) {
										board[x][y].value--;
									}
								}
							}
						}
						break;
					case "P":
						if (r + 1 < 8 && f > 0) {
							board[f - 1][r + 1].value++;
						}
						if (r + 1 < 8 && f < 7) {
							board[f + 1][r + 1].value++;
						}
						break;
					case "p":
						if (r - 1 >= 0 && f > 0) {
							board[f - 1][r - 1].value--;
						}
						if (r - 1 >= 0 && f < 7) {
							board[f + 1][r - 1].value--;
						}
						break;
					default:
						break;
				}
			}
		}
	}

	public Square getSquare(String sq) {
		if (sq.length() == 2) {
			char f = sq.charAt(0);
			char r = sq.charAt(1);
			int file = files.indexOf(f);
			int row = rows.indexOf(r);
			return board[file][row];
		}
		return null;
	}

	public void emptyBoard() {
		board = new Square[8][8];
	}

	public void printBoardNames() {
		System.out.println("=================================");
		for (int i = 7; i >= 0; i--) {
			for (int j = 0; j < 8; j++) {
				Square sq = board[j][i];
				System.out.print("|" + sq.name + " ");
			}
			System.out.println("|");
		}
		System.out.println("=================================");
	}

	public void printBoardValues() {
		System.out.println("=================================");
		for (int i = 7; i >= 0; i--) {
			for (int j = 0; j < 8; j++) {
				Square sq = board[j][i];
				System.out.format("|%2d ", sq.value);
			}
			System.out.println("|");
		}
		System.out.println("=================================");
	}

	public void printBoard() {
		System.out.println("=================================");
		for (int i = 7; i >= 0; i--) {
			for (int j = 0; j < 8; j++) {
				Square sq = board[j][i];
				System.out.print("| " + sq.piece + " ");
			}
			System.out.println("|");
		}
		System.out.println("=================================");
	}

	public void setupBoardFen(String fen) {
		// Example fen rnbqkbnr/pppppppp/8/8/4P3/8/PPPP1PPP/RNBQKBNR b KQkq e3 0
		// 1
		emptyBoard();
		String[] fena = fen.trim().split(" ");
		String[] rank = fena[0].trim().split("/");
		int row = 8;
		for (String r1 : rank) {
			row--;
			int pos = 0;
			// System.out.println(r1);
			String[] r = r1.trim().split("");
			for (String e : r) {
				if (e.length() > 0) {
					if (rows.indexOf(e) == -1) {
						// Piece
						board[pos++][row] = new Square(e);
					} else {
						// Empty Space Rep
						for (int i = 0; i < Integer.parseInt(e); i++) {
							board[pos++][row] = new Square();
						}
					}
				}
			}
		}
		for (int i = 0; i < 8; i++) {
			for (int j = 0; j < 8; j++) {
				board[j][i].name = "" + files.substring(j, j + 1) + (i + 1);
			}
		}
	}
}
