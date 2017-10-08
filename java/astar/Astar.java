package astar;

import java.util.PriorityQueue;

import javax.swing.JButton;
import javax.swing.JOptionPane;

public class Astar extends Thread {
	public final static int numCasas = 25;
	private Renderer        p;
	private final JButton   bReset;
	private final JButton   bRandom;

	public Astar(Renderer p, JButton bReset, JButton bRandom) {
		this.p = p;
		this.bReset = bReset;
		this.bRandom = bRandom;
	}

	@Override
	public void run() {
		System.out.println("AStar Started");
		PriorityQueue<Casa> visitadas = new PriorityQueue<Casa>();
		PriorityQueue<Casa> fronteira = new PriorityQueue<Casa>();
		fronteira.add(p.cStart);
		while (fronteira.peek() != p.cTarget && !fronteira.isEmpty()) {
			Casa current = fronteira.poll();
			visitadas.add(current);
			if (current != p.cStart) {
				current.valor = 0;
			}
			Casa norte = null, este = null, oeste = null, sul = null;
			if (current.y > 0) {
				norte = p.mapa[current.x][current.y - 1];
			}
			if (current.y < numCasas - 1) {
				sul = p.mapa[current.x][current.y + 1];
			}
			if (current.x > 0) {
				oeste = p.mapa[current.x - 1][current.y];
			}
			if (current.x < numCasas - 1) {
				este = p.mapa[current.x + 1][current.y];
			}
			double dist = current.dist + 1;
			Casa[] all = { norte, este, sul, oeste };
			for (Casa vizinho : all) {
				if (vizinho == null) {
					continue;
				}
				if (vizinho.valor == 1) {
					continue;
				}
				if (fronteira.contains(vizinho) && dist < vizinho.dist) {
					fronteira.remove(vizinho);
					vizinho.dist = 0;
					vizinho.cost = 0;
					vizinho.from = null;
					System.out.println("Viz na Fronteira");
				}
				if (visitadas.contains(vizinho) && dist < vizinho.dist) {
					visitadas.remove(vizinho);
					vizinho.dist = 0;
					vizinho.cost = 0;
					vizinho.from = null;
					System.out.println("Viz nas Visitadas");
				}
				if (!fronteira.contains(vizinho) && !visitadas.contains(vizinho)) {
					vizinho.dist = dist;
					// double h = (Math.abs(vizinho.x - p.cTarget.x) +
					// Math.abs(vizinho.y
					// - p.cTarget.y));
					double h = 0.0;
					if (Janela.STATE == 1) {
						h = (Math.sqrt(Math.pow((vizinho.x - p.cTarget.x), 2)
									+ Math.pow((vizinho.y - p.cTarget.y), 2)));
					}
					double cross = 0.0;
					if (Janela.TIE == 1) {
						double dx1 = current.x - p.cTarget.x;
						double dy1 = current.y - p.cTarget.y;
						double dx2 = p.cStart.x - p.cTarget.x;
						double dy2 = p.cStart.y - p.cTarget.y;
						cross = Math.abs(dx1 * dy2 - dx2 * dy1);
					}
					// double h = (Math.pow(vizinho.x - p.cTarget.x,2)+
					// Math.pow(vizinho.y
					// - p.cTarget.y,2));
					vizinho.cost = dist + 1.0 * h + cross * 0.1;
					fronteira.add(vizinho);
					if (vizinho.valor < 2) {
						vizinho.valor = 4;
					}
					vizinho.from = current;
					if (vizinho.cost > p.max) {
						p.max = vizinho.cost;
					}
				}
				p.repaint();
			}
			try {
				sleep(100);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		// Rebulid path

		bReset.setEnabled(true);
		bRandom.setEnabled(true);
		System.out.println("AStar Ended");

		Casa last = fronteira.peek();
		if (null == last){
			JOptionPane.showMessageDialog(null, "No path found for destination");
			return;
		}
		last = last.from;
		while (last.from != null) {
			last.valor = 10;
			last = last.from;
			p.repaint();
			try {
				sleep(100);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
}
