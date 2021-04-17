import java.util.ArrayList;
import java.util.List;

public class SolarSystem {
    public SolarSystem(){
        // add planets
        Body Sun = new Body("Sun",0,0,1.9891e30,1.391684e9,0,0,587.28,0);
        Body Mercury = new Body("Mercury",0,0,0.330e24,4.879e6,4.6e10,6.98e10,88,1407.6);
        Body Venus = new Body("Venus",0,0,4.87e24,1.2104e7,1.075e11,1.089e11,224.7,-5832.5);
        Body Earth = new Body("Earth",0,0,5.97e24,1.2756e7,1.471e11,1.521e11,365.2425,23.9);
        Body Mars = new Body("Mars",0,0,0.642e24,6.792e7,2.066e11,2.492e11,687.0,24.6);
        Body Jupiter = new Body("Jupiter",0,0,1898e24,1.42984e8,7.405e11,8.166e11,4331,9.9);
        Body Saturn = new Body("Saturn",0,0,568e24,1.20536e8,1.3526e12,1.5145e12	,10747,10.7);
        // add a list of planets
        List<Body> bodies = new ArrayList<>();
        bodies.add(Sun);
        bodies.add(Mercury);
        bodies.add(Venus);
        bodies.add(Earth);
        bodies.add(Mars);
        bodies.add(Jupiter);
        bodies.add(Saturn);
        // initial position of planets
        for (Body b: bodies) {
            b.initialPosition();
        }
    }

    public static void main(String[] args) {

        SolarSystem solarSystem = new SolarSystem();
    }
}
