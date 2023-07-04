![logo](https://github.com/matheus-vb/wwdc-astar/assets/88170905/6ccee0b7-21c8-473f-bf7e-c74fa9e184a5)

# PizzAstar - WWDC23 Swift Student Challenge - Accepted 🏅
## Project overview
Have you ever stopped to wander about the inner workings of a GPS route? How does an app know the best way to get from one point to another?

Consider the place where you live. If you think about it, there are almost infinite ways of getting from one spot to another, right? Some ways faster, and some shorter. Aside from distance, there are other factors to consider when setting up a route. There is traffic, roads with bad access, among other things.
With all that in mind, how can a program calculate the fastest way of getting to where you want? It would be impossible to check every possibility!

<img width="572" alt="Screenshot 2023-07-04 at 11 03 06" src="https://github.com/matheus-vb/wwdc-astar/assets/88170905/4380ceaf-5227-426b-9fff-4ba21b17a457">

And here is where pathfinding algorithms come in place. An algorithm is a set of actions done repeatedly to solve a problem, and the pathfinding ones are the algorithms designed to find the best path from one point to another.
There are many pathfinding algorithms out there, every one with different characteristics. To choose the best algorithm for a task, the best approach is to know when a specific algorithm will probably be more efficient than others, considering the information you have available for him and what you expect in return.
With that in mind, if you have the locations of the start and end point in a map, the A Star (or A*) algorithm is usually a great choice to solve your problem!

Here is a video that provides a visual comparison between popular pathfinding algorithims: https://www.youtube.com/watch?v=aW9kZcJx64o

The A Star algorithm  keeps track of the distance from your current position to the end position, and every time a new possible spot is going to be considered, the distance is calculated again. If the algorithm knows where you can go from where you are, and how far are these possible destinations from your target location, it can select the closest “neighbor” to be the candidate of a good path. Then, it starts again from that candidate. If that candidate ends up not being the better choice, the algorithm starts over with the second closest point.  With that being done over and over again, eventually the best path from where you are to where you want to be is going to be found. 
## It can be confusing to think about all of that without seeing it, so pizzAstar can provide you a way to visualize how the algorithm actually works, step by step!
![Simulator_Screen_Recording_-_iPad_Pro__11-inch___4th_generation__-_2023-07-04_at_11_14_18_AdobeExpress](https://github.com/matheus-vb/wwdc-astar/assets/88170905/2a2af0d2-b3d8-4172-aec2-ca96b9c96688)
