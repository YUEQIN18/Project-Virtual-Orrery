import java.util.Random;

public class Body {
    String name;
    double x;
    double y;
    double mass; // (kg)
    double diam; // (meters)
    double perihelion; // (meters)
    double aphelion; // (meters)
    double orbPeriod; // (days)
    double rotationalPeriod; // (hours)
    double currentAngle; // (radian)
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
        this.currentAngle = 0;
    }
    public void initialPosition(){
        // set random x and y
        // Or we find the actual position of planet later
        Random random = new Random();
        currentAngle = random.nextDouble()*2*Math.PI; // return a random angel within [0,2PI]
        double a = (perihelion+aphelion)/2; // a is semi-major axis
        double c = a - perihelion;
        double b = Math.sqrt(a*a-c*c); // b is semi-minor axis
        x = a*Math.cos(currentAngle);
        y = b*Math.sin(currentAngle);
    }
    public void setPosition(double time){
        // calculate the next position of planet after 1 second or 0.1 second
        double dist = Math.sqrt(x * x + y * y); // Distance between Sun and planet
        double G = 6.67e-11; // Gravitation instance
        double M = 1.9891e30; // Mass of Sun
        double angularVelocity = Math.sqrt(G * M / Math.pow(dist,3));
        double angle = angularVelocity * time ; // Radian
        // Now we have the angle of planet movement
        // Next we calculate the position fo planet
        double a = (perihelion+aphelion)/2; // a is semi-major axis
        double c = a - perihelion;
        double b = Math.sqrt(a*a-c*c); // b is semi-minor axis
        currentAngle = currentAngle + angle;
        x = a*Math.cos(currentAngle);
        y = b*Math.sin(currentAngle);
    }
}
