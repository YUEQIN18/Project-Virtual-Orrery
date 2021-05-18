
# **Project: Virtual Orrery**

## Group Member : [AbhinandanNuli](https://github.com/AbhinandanNuli), [William Baltus](https://github.com/WilliamBaltus), [Yue Qin](https://github.com/YUEQIN18)

### Directory Structure


main   : [Main.pde](https://github.com/YUEQIN18/Project-Virtual-Orrery/tree/master/main/Main.pde) is the file to run. Needs to be in a folder named `Main.` 


William Baltus                              	                                                        	        	EE-552
Yue Qin      	
Abhinandan Nuli
 
Virtual Orrery
Goals:
        	The goal of the project was to simulate the solar system in a way it would be like an physical orrery, substituting the gears and cogs for CPU and code. There were many requirements for the project, which were the following:
-        Have the simulation be in “2D” and then in “3D.”
-        Have the Sun and recognized planets be a part of the simulation.
-        Have an interface for the user to change the time scale of the project.
-        Have a functioning camera such that the user can zoom, rotate, and pan.
-        Have the celestial bodies take the path of a mathematically accepted formula (in our case, we used the Law of Universal Gravitation).
There were additional features that were recommended such as:
-        Having an asteroid field.

-     Having moons around some celestial bodies. 
-        Having an info message show up on celestial body observation.
-     Having a Star Field that simulates the moving stars in the background.
-     Having textures around all the celestial bodies.
On top of all of these, classmate/professor feedback combined with our own aspirations resulted in the desire to add the following features:
-        Having an interface where the user can directly observe a chosen celestial body
-     Changed the textures to make them appear even more realistic.
-        Adding a ring around Saturn.       	
-        Fixing camera clipping.
-        Adding orbit path lines.
 
Details:
These goals were all achieved. This was done using the Processing language. In this case, java-like syntax knowledge combined with the power of Processing can be leveraged to create code with a visual display. The code can be grouped into a few categories, those being “lighting,” “camera,” “buttons,” and “body.”
In lighting, in order to project the light such that it seems as if it originates from the Sun, “pointLight” is used before all the planets are drawn. Afterwards “ambientLight” is used before the sun is drawn. This allows for the desired lighting.
In camera, we utilized a library called Peasycam. This allowed us to essentially use a fully functional camera just by initializing it. Of course, then it had to be tweaked for our purposes, such as by setting certain key parameters like max/min zoom distance and adjusting its clipping.
In buttons, we utilized a library called P5Control which allows us to place functional buttons easily in 3D space and within the camera HUD. Once initialized plenty of these objects could be created for our purposes. In our case, we used them to make the interface for the user to observe a planet (which also utilized Peasycam). We also used P5Control to make the interface for the user to adjust the time scale of the rotations and orbits of the bodies.
Last but certainly not least, Body, was the bulk of the project. This was our group’s custom class which acted as the blueprint for any celestial body we added into the 3D space. It took in parameters such as the body name, diameter, perihelion, and so on. The Body class also has methods such as setPosition which use the object parameters as arguments to input into the Law of Universal Gravitation. Another neat method the Body class possesses is ringSetup which is used to draw the rings around Saturn. When these bodies are made en masse and placed into an array of Body objects, then an entire solar system can be easily made by making all the planet bodies and many asteroid bodies!
Instructions for Running:
 
Please visit Github to download all the required code.
LINK: https://github.com/YUEQIN18/Project-Virtual-Orrery.git
In order to run after downloading, simply go to the main folder and open up Main.pde.







