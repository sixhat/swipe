package astar;

public class Casa implements Comparable<Casa> {
    int    valor;
    int    x;
    int    y;
    double dist;
    double cost;
    Casa   from;

    public Casa(int valor) {
        assert valor >= 0;
        this.valor = valor;
        from = null;
        cost = 0.0;
        dist = 0.0;
    }

    @Override
    public int compareTo(Casa o) {
        return Double.compare(cost, o.cost);
    }

    @Override
    public String toString() {
        return "Casa " + x + "," + y + " - valor:" + valor + " - cost:" + cost;
    }
}
