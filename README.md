# Adaptive-Filters-Echo-Cancellation

## Introduction 

Echo cancellation is an important aspect of any communication-based system.The purpose of echo cancellation is to reduce the echo as much as possible in order to obtain a clear understanding of the original message. One of the earliest form of echo control involved adding a loss of 3dB in the transmission line which delayed the entire signal by 6dB. Although this technique was effective in reducing the echo heard at the source, it also introduced an additional 3dB loss to the speech transmission, making it an unideal solution. The echo suppressor is a device that had been commonly used to control the network echoes. Although the device was effective in controlling echo in circuits with about 100ms of round-trip delays, the suppressors failed to function effectively with telephone calls with delays over 600ms and often mutilated signals that received a high level of echo or a low speech level. 

Another form of echo cancellation is through the use of adaptive filters. These are more widely used than echo suppressors as they are significantly more stable and also have a larger scope of improvement. Adaptive filters are also dynamic and can change their features depending on the input data. Currently, there are many algorithms that are used for echo cancellation, but the most common one is the Least Mean Squares (LMS) algorithm because of its simplicity.
 
Usually, the adaptive filter that implements the algorithm is a Finite Impulse Response (FIR) filter. This is due to the fact that the FIR filter provides unimodal mean squared error (MSE) and greater stability. However, implementing the FIR algorithm also requires a greater computational complexity since the algorithm would require a significant amount of filter coefficients to match the impulse response. Hence, the IIR filter is substituted which provides reduced complexity as the IIR filter requires fewer coefficients as compared to the FIR filter. 

## Weiner Hopf Solution

The purpose of the adaptive filter is to minimize the cost function J which is the difference between the output y(i) and the desired output d(i) where i is the total number of samples. This is explained further by looking at the figure below. 

![trainingalgorithm](https://user-images.githubusercontent.com/50300494/58265390-935fe580-7d4d-11e9-8739-56be7d9f5d38.png)

The adaptive system gives out an output y which goes into the cost function block, J, along with the desired response. However, y is essentially the mapper chosen by the user for the learning algorithm. For the purpose of this experiment, the output of the mapper will be linear, yielding equation (1) for the output of y. 

![Linear Equation](https://user-images.githubusercontent.com/50300494/58265550-e5a10680-7d4d-11e9-8fb9-40ba201b771b.png)

"e" is then calculated by subtracting the output of y with the desired data, d. Hence, yielding equation (2) for the output of the error function. 

![ErrorCalculation](https://user-images.githubusercontent.com/50300494/58265627-0a957980-7d4e-11e9-9672-e67a8c6f20bc.PNG)

The cost function, J, that is represented in equation (3) becomes the squared function of equation (2):

![CostFunction](https://user-images.githubusercontent.com/50300494/58265682-2862de80-7d4e-11e9-9982-4b66f09f10bc.PNG)

The goal of the Wiener Hopf solution is to find the minimum of the cost function by first calculating the derivative of J(w) with respect to w, and then determining the value of w from equation (4). 

![WeinerHopf](https://user-images.githubusercontent.com/50300494/58265719-3f093580-7d4e-11e9-93ee-856a7292c0af.PNG)

However, this solution is only ideal for stationary signals where the statistics of the input signals do not change over time. Hence, the LMS filter is proposed over the Wiener solutions since the weight values (w) are learnt locally and updated based on each individual sample. 


## Least Mean Squared Finite Impulse Response Filter

The alternative method for supervised learning is to use a search algorithm. In essence, this is a special class of algorithms under the category of online learning where the value of w is continuously updated as opposed to the batch learning algorithm proposed by Wiener Hopf. One of the earliest search algorithms that uses the information of the gradient to determine the value of w is called the Steepest Descent. In the Steepest Descent algorithm, instead of finding the value of w from the full range of data, the value of w is updated based on every point of the data. The concept of steepest descent is illustrated in Figure 2. The graph is plotted based on the values of the cost function and the goal of the algorithm is to reach the minimum value of the parabola. Initially, a random value of w, or a value of 0 is chosen as the initial condition. From the starting value,  the value of w moves in the opposite direction to that of the gradient. The algorithm  reaches the minimum of the parabola depending on the value of the step-size This is shown in Equation (5).

![WeightUpdate](https://user-images.githubusercontent.com/50300494/58276102-961a0500-7d64-11e9-99f7-c5a6351027ca.PNG)

The value of the stepsize is a hyper-parameter that is picked by the user in order to obtain the best possible value of w. The two main parameters that determine the optimum value of w is the step size and the gradient. Hence, the graph would still move towards the minimum value even if   was a value of 0, since the slope changes at every iteration. With the inclusion of the step size, if the value of the step size is too small, then the number of iterations that it takes to reach the minimum point of the graph would be too large and the system would be computationally expensive. Alternatively, if the value of the stepsize is too large, the weights will approximate the final value by oscillating around the minimum point of the graph, leading the graph to diverge. Generally, the value of  the stepsize is chosen based on equation (6). Where the value of λ is the maximum eigenvalue of the dataset. 

![Stepsizevalue](https://user-images.githubusercontent.com/50300494/58276163-c2358600-7d64-11e9-9571-96812cf5d189.PNG)

An adaptation of equation (5) was proposed by Widrow where the instantaneous value of the gradient was used as the estimator of the true quantity. Hence, the gradient estimate in equation (5) was transformed as shown in equation (7). 

![Adaptation](https://user-images.githubusercontent.com/50300494/58276248-eee99d80-7d64-11e9-9a0f-c753cab4420f.PNG)



