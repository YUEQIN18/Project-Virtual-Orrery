import java.util.Random;

public class Body {
    String name;
    double x;
    double y;
    double mass;
    double diam;
    double perihelion;
    double aphelion;
    double orbPeriod; // (days)
    double rotationalPeriod; // (hours)
    // constructor
    public Body(){}
    public Body(String name, double x, double y, double m, double diam, double perihelion, double aphelion, double orbPeriod, double rotationalPeriod){
        this.name = name;
        this.x = x;
        this.y = y;
        this.mass = m;
        this.diam = diam;
        this.perihelion = perihelion;
        this.aphelion =  aphelion;
        this.orbPeriod = orbPeriod;
        this.rotationalPeriod = rotationalPeriod;
    }
    public void initialPosition(){
        // set random x and y
        // Or we find the actual position of planet later
        Random random = new Random();
        double randomAngel = random.nextDouble()*2*Math.PI; // return a random angel within [0,2PI]
        double a = (perihelion+aphelion)/2; // a is semi-major axis
        double c = a - perihelion;
        double b = Math.sqrt(a*a-c*c); // b is semi-minor axis
        x = a*Math.cos(randomAngel);
        y = b*Math.sin(randomAngel);
    }
    public void setPosition(double time){
        // calculate the next position of planet after 1 second or 0.1 second
    }
}
