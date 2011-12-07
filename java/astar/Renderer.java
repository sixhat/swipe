package astar;

import java.awt.Color;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.Point;
import java.awt.Rectangle;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.awt.event.MouseMotionListener;

import javax.swing.JLabel;

public class Renderer extends JLabel {
    Point                p;
    Casa[][]             mapa;
    int                  a;
    int                  mode;  // 1-obstacle setup, 2-setStart, 3-setTarget
    int                  xs, ys = 0;
    int                  xt, yt = Astar.numCasas - 1;
    Casa                 cStart, cTarget;
    double               max = 0.0;
    private final Janela janela;

    public Renderer(final Janela janela) {
        this.janela = janela;
        mapa = new Casa[Astar.numCasas][Astar.numCasas];
        for (int y = 0; y < mapa.length; y++) {
            for (int x = 0; x < mapa.length; x++) {
                Casa c = new Casa(0);
                c.x = x;
                c.y = y;
                mapa[x][y] = c;
            }
        }
        mode = 1;
        this.addMouseMotionListener(new MouseMotionListener() {
            @Override
            public void mouseMoved(MouseEvent arg0) {
                // TODO Auto-generated method stub
            }

            @Override
            public void mouseDragged(MouseEvent arg0) {
                p = arg0.getPoint();
                switch (mode) {
                case 1:
                    if (mapa[p.x / a][p.y / a].valor < 2) {
                        mapa[p.x / a][p.y / a].valor = 1;
                    }
                    break;
                default:
                    break;
                }
                repaint();
            }
        });
        this.addMouseListener(new MouseListener() {
            @Override
            public void mouseReleased(MouseEvent arg0) {
            }

            @Override
            public void mousePressed(MouseEvent arg0) {
                p = arg0.getPoint();
                switch (mode) {
                case 1:
                    if (mapa[p.x / a][p.y / a].valor < 2) {
                        mapa[p.x / a][p.y / a].valor = 1 - mapa[p.x / a][p.y / a].valor;
                    }
                    break;
                case 2:
                    mapa[xs][ys].valor = 0;
                    xs = p.x / a;
                    ys = p.y / a;
                    mapa[xs][ys].valor = 2;
                    cStart = mapa[xs][ys];
                    mode = 1;
                    janela.start = true;
                    janela.checkGo();
                    break;
                case 3:
                    mapa[xt][yt].valor = 0;
                    xt = p.x / a;
                    yt = p.y / a;
                    mapa[xt][yt].valor = 3;
                    cTarget = mapa[xt][yt];
                    janela.target = true;
                    janela.checkGo();
                    mode = 1;
                    break;
                default:
                    break;
                }
                repaint();
            }

            @Override
            public void mouseExited(MouseEvent arg0) {
            }

            @Override
            public void mouseEntered(MouseEvent arg0) {
            }

            @Override
            public void mouseClicked(MouseEvent arg0) {
            }
        });
    }

    @Override
    protected void paintComponent(Graphics grg) {
        // TODO Auto-generated method stub
        super.paintComponent(grg);
        Graphics2D g = (Graphics2D) grg;
        Rectangle r = g.getClipBounds();
        a = Math.min(r.width, r.height) / Astar.numCasas;
        for (int y = 0; y < Astar.numCasas; y++) {
            for (int x = 0; x < Astar.numCasas; x++) {
                switch (mapa[x][y].valor) {
                case 1:
                    g.setColor(Color.BLACK);
                    g.fillRect(x * a, y * a, a, a);
                    g.setColor(Color.BLACK);
                    g.drawRect(x * a, y * a, a, a);
                    break;
                case 2:
                    g.setColor(Color.YELLOW);
                    g.fillRect(x * a, y * a, a, a);
                    g.setColor(Color.BLACK);
                    g.drawRect(x * a, y * a, a, a);
                    break;
                case 3:
                    g.setColor(Color.GREEN);
                    g.fillRect(x * a, y * a, a, a);
                    g.setColor(Color.BLACK);
                    g.drawRect(x * a, y * a, a, a);
                    break;
                case 4: // Fronteira
                    g.setColor(Color.MAGENTA);
                    g.fillRect(x * a, y * a, a, a);
                    g.setColor(Color.BLACK);
                    g.drawRect(x * a, y * a, a, a);
                    break;
                case 10:
                    g.setColor(Color.RED);
                    g.fillRect(x * a, y * a, a, a);
                    g.setColor(Color.BLACK);
                    g.drawRect(x * a, y * a, a, a);
                    break;
                default:
                    int cc = (int) (255 * (mapa[x][y].cost / max));
                    g.setColor(new Color(cc, cc, 250));
                    g.fillRect(x * a, y * a, a, a);
                    g.setColor(Color.BLACK);
                    g.drawRect(x * a, y * a, a, a);
                    break;
                }
            }
        }
    }

    public void reset() {
        for (int y = 0; y < mapa.length; y++) {
            for (int x = 0; x < mapa.length; x++) {
                Casa c = mapa[x][y];
                c.cost = 0.0;
                c.dist = 0.0;
                c.valor = 0;
                c.from = null;
                max = 0.0;
            }
        }
        this.repaint();
    }
}
