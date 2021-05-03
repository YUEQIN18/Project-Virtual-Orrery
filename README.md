# Project: Virtual Orrery
## Simulate a solar system in 3D

### Directory Structure

├── Project-Virtual-Orrery   
│  ├── main   : [Main.pde](https://github.com/YUEQIN18/Project-Virtual-Orrery/tree/master/main/Main.pde) is the file could run.  
│  └── src    : source code



### [2021-04-17] 

#### Version: 1.0.1

#### Contributor: Yue Qin

Added [Body.java](https://github.com/YUEQIN18/Project-Virtual-Orrery/tree/master/src/Body.java) with base parameters and its constructors.

    public Body(){
        ...
    }

Added a function to initialize position of planets.
        
    public void initialPosition(){
        ...
    }

Added [SolarSystem.java](https://github.com/YUEQIN18/Project-Virtual-Orrery/tree/master/src/SolarSystem.java) and its constructor. Initialize eight planets
of parameters from https://nssdc.gsfc.nasa.gov/planetary/factsheet/index.html

    public SolarSystem(){
        ...
    }


### [2021-04-20] 
  
#### Version: 1.0.2

#### Contributor: William Baltus

Created 3D space.
Added Star background to space. 

### [2021-04-26]   
  
#### Version: 1.0.3  

#### Contributor: William Baltus

Added [Star.pde]  
Added [Field_of_Stars.pde]  
Added [Main.pde]  
Added [Planet.pde]  

Light manipulation, time scale manipulation, and planetary motion perfecting implementation is next!  

Contributor: Abhinandan Ashok Nuli

Added StarField

Added 2D objects

Added 3D objects

Added 3D textures


### [2021-04-29]

#### Version: 1.0.4

#### Contributor: Yue Qin

updated [Body.java](https://github.com/YUEQIN18/Project-Virtual-Orrery/tree/master/src/Body.java) with Function setPosition(). Implemented this function base on Newton' s Gravitation Law.
    
    public void setPosition(double time){
        ...
    }

Added [Body.pde](https://github.com/YUEQIN18/Project-Virtual-Orrery/tree/master/main/Body.pde) (converted from body.java). This file quotes code from [Planet.pde](https://github.com/YUEQIN18/Project-Virtual-Orrery/tree/master/src/Planet.pde).

Modified [Main.pde](https://github.com/YUEQIN18/Project-Virtual-Orrery/tree/master/main/Main.pde) and It can show a moving 3D solar system now!!!


### [2021-05-02]

#### Version: 1.0.5

#### Contributor: Abhinandan Nuli

added [2D_3D_Textures.pde] and [SolarSystem_2D_3D_Texture.pde].


### [2021-05-02]

#### Version: 1.0.6

#### Contributor: Yue Qin

Added all picture to /main/data

Modified [Main.pde](https://github.com/YUEQIN18/Project-Virtual-Orrery/tree/master/main/Main.pde) and added textures to all celestial body, they look more real now.
