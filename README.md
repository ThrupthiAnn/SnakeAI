# SnakeAI
A snake game and computer agents to play it! Have fun writing your own agents! This code is written in Matlab. You don't need additional software.

To run this program, run the script 'SnakeGame.m' in Matlab.

     >>SnakeGame

## Options
The following options can be changed in SnakeGame.m:
1. nrows: determines the size of the playing field. It will always be square and even
2. AI: choose which agent you want from AI_gen1 to AI_gen12
3. create_video:  In case you want to record the game
4. video_name: name of the video file for your record
The colours of various elements can be changed in the file Render.m.

## The Agents
Here is a brief description of the included agents:
* AI_gen1: Endlessly goes round and round the edges
* AI_gen2: Choose the direction based on the row and column of the food
* AI_gen3: Take the shortest path to the food
* AI_gen4: Take the shortest path to the food. If there is no path, take the shortest path to the tail
* AI_gen5: Same as AI_gen4. If there is no path to the tail, go clockwise
* AI_gen6: Take the shortest path to the food or the longest path to the tail. If it doesn't exist, go clockwise
* AI_gen7: Go in the direction which ensures most freedom!
* AI_gen8: Don't divide the field into two
* AI_gen9: Follow a Hamiltonian circuit. This AI will always win.
* AI_gen10: Follow a Hamiltonian circuit. Take a shortcut if the food becomes nearer and there is no snake in the cut-off loop.
* AI_gen11: Advanced version of AI_gen10 where the circuit is truly treated as a circuit and has no begining and end
* AI_gen12: Use random Hamiltonian circuits 

## Algorithm for generating Hamiltonian circuits
The idea is inspired by the website: https://clisby.net/projects/hamiltonian_path/ which in turn is inspired by the paper: “Secondary structures in long compact polymers” by Richard Oberdorf, Allison Ferguson, Jesper L. Jacobsen and Jané Kondev, Phys. Rev. E 74, 051801 (2006). This paper describes a procedure called 'backbite' wherein a Hamiltonian path can be changed randomly. Hamiltonian circuits were created by applying the backbite move multiple times till it became a circuit. 
