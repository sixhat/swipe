package astar;

import java.awt.BorderLayout;
import java.awt.Container;
import java.awt.FlowLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.ItemEvent;
import java.awt.event.ItemListener;
import java.util.Random;

import javax.swing.JButton;
import javax.swing.JCheckBox;
import javax.swing.JFrame;
import javax.swing.JPanel;

public class Janela {
    JFrame            j;
    Renderer          p;
    boolean           start, target = false;
    final JButton     bGo   = new JButton("Go");
    public static int STATE = 1;
    public static int TIE   = 1;

    public Janela() {
        j = new JFrame("Testing A* Algorithm - (c)2011 David Rodrigues ");
        j.setSize(500, 600);
        j.setLocation(100, 100);
        j.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        p = new Renderer(this);
        Container painel = j.getContentPane();
        painel.setLayout(new BorderLayout());
        painel.add(p);
        final JButton bStart = new JButton("set Start");
        final JButton bTarget = new JButton("set Target");
        final JButton bReset = new JButton("Reset");
        final JButton bRandom = new JButton("Random");
        final JCheckBox jCk = new JCheckBox("Heuristic (On=A*, Off=Dijkstra)");
        final JCheckBox tieB = new JCheckBox("Tiebreaker");
        tieB.setSelected(true);
        tieB.addItemListener(new ItemListener() {
            @Override
            public void itemStateChanged(ItemEvent e) {
                Janela.TIE = e.getStateChange();
            }
        });
        jCk.setSelected(true);
        jCk.addItemListener(new ItemListener() {
            @Override
            public void itemStateChanged(ItemEvent e) {
                Janela.STATE = e.getStateChange();
            }
        });
        bGo.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                bTarget.setEnabled(false);
                bStart.setEnabled(false);
                bGo.setEnabled(false);
                bReset.setEnabled(false);
                bRandom.setEnabled(false);
                Astar as = new Astar(p, bReset, bRandom);
                as.start();
            }
        });
        bGo.setEnabled(false);
        bStart.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent arg0) {
                p.mode = 2;
            }
        });
        bTarget.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent arg0) {
                p.mode = 3;
            }
        });
        bReset.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent arg0) {
                p.reset();
                bTarget.setEnabled(true);
                bStart.setEnabled(true);
                bGo.setEnabled(false);
                start = false;
                target = false;
            }
        });
        bRandom.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent arg0) {
                Random rng = new Random();
                for (int y = 0; y < p.mapa.length; y++) {
                    for (int x = 0; x < p.mapa.length; x++) {
                        if (rng.nextDouble() < 0.2) {
                            p.mapa[x][y].valor = 1;
                        }
                    }
                }
                j.repaint();
            }
        });
        JPanel p2 = new JPanel();
        p2.setLayout(new FlowLayout());
        p2.add(bReset);
        p2.add(jCk);
        p2.add(bRandom);
        p2.add(bStart);
        p2.add(bTarget);
        p2.add(bGo);
        JPanel p3 = new JPanel();
        p3.setLayout(new FlowLayout());
        p3.add(jCk);
        p3.add(tieB);
        painel.add(p3, BorderLayout.NORTH);
        painel.add(p2, BorderLayout.SOUTH);
        j.setVisible(true);
    }

    public void checkGo() {
        if (start && target) {
            bGo.setEnabled(true);
        }
    }
}
