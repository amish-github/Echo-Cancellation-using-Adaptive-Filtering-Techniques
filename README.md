# Adaptive-Filters-Echo-Cancellation

## Introduction 

Echo cancellation is an important aspect of any communication-based system.The purpose of echo cancellation is to reduce the echo as much as possible in order to obtain a clear understanding of the original message. One of the earliest form of echo control involved adding a loss of 3dB in the transmission line which delayed the entire signal by 6dB. Although this technique was effective in reducing the echo heard at the source, it also introduced an additional 3dB loss to the speech transmission, making it an unideal solution. The echo suppressor is a device that had been commonly used to control the network echoes. Although the device was effective in controlling echo in circuits with about 100ms of round-trip delays, the suppressors failed to function effectively with telephone calls with delays over 600ms and often mutilated signals that received a high level of echo or a low speech level. 

Another form of echo cancellation is through the use of adaptive filters. These are more widely used than echo suppressors as they are significantly more stable and also have a larger scope of improvement. Adaptive filters are also dynamic and can change their features depending on the input data. Currently, there are many algorithms that are used for echo cancellation, but the most common one is the Least Mean Squares (LMS) algorithm because of its simplicity.
 
Usually, the adaptive filter that implements the algorithm is a Finite Impulse Response (FIR) filter. This is due to the fact that the FIR filter provides unimodal mean squared error (MSE) and greater stability. However, implementing the FIR algorithm also requires a greater computational complexity since the algorithm would require a significant amount of filter coefficients to match the impulse response. Hence, the IIR filter is substituted which provides reduced complexity as the IIR filter requires fewer coefficients as compared to the FIR filter. 

## Weiner Hopf Solution

The purpose of the adaptive filter is to minimize the cost function J which is the difference between the output y(i) and the desired output d(i) where i is the total number of samples. This is explained further by looking at the figure below. 

![trainingalgorithm](https://user-images.githubusercontent.com/50300494/58265390-935fe580-7d4d-11e9-8739-56be7d9f5d38.png)

The adaptive system gives out an output y which goes into the cost function block, J, along with the desired response. However, y is essentially the mapper chosen by the user for the learning algorithm. For the purpose of this experiment, the output of the mapper will be linear, yielding equation (1) for the output of y. 

![Linear Equation](https://user-images.githubusercontent.com/50300494/58276473-8949e100-7d65-11e9-8333-caacad62b1c0.PNG)

"e" is then calculated by subtracting the output of y with the desired data, d. Hence, yielding equation (2) for the output of the error function. 

![ErrorCalcualtion](https://user-images.githubusercontent.com/50300494/58276424-6b7c7c00-7d65-11e9-893f-d77c2fe4e4c4.PNG)

The cost function, J, that is represented in equation (3) becomes the squared function of equation (2):

![CostFunction](https://user-images.githubusercontent.com/50300494/58276390-53a4f800-7d65-11e9-85f6-05150ad4e82e.PNG)

The goal of the Wiener Hopf solution is to find the minimum of the cost function by first calculating the derivative of J(w) with respect to w, and then determining the value of w from equation (4). 

![WeinerHopf](https://user-images.githubusercontent.com/50300494/58276341-35d79300-7d65-11e9-8ef9-6992687e79d9.PNG)

However, this solution is only ideal for stationary signals where the statistics of the input signals do not change over time. Hence, the LMS filter is proposed over the Wiener solutions since the weight values (w) are learnt locally and updated based on each individual sample. 


## LMS Finite Impulse Response Filter

The alternative method for supervised learning is to use a search algorithm. In essence, this is a special class of algorithms under the category of online learning where the value of w is continuously updated as opposed to the batch learning algorithm proposed by Wiener Hopf. One of the earliest search algorithms that uses the information of the gradient to determine the value of w is called the Steepest Descent. In the Steepest Descent algorithm, instead of finding the value of w from the full range of data, the value of w is updated based on every point of the data. The concept of steepest descent is illustrated in Figure 2. The graph is plotted based on the values of the cost function and the goal of the algorithm is to reach the minimum value of the parabola. Initially, a random value of w, or a value of 0 is chosen as the initial condition. From the starting value,  the value of w moves in the opposite direction to that of the gradient. The algorithm  reaches the minimum of the parabola depending on the value of the step-size This is shown in Equation (5).

![WeightUpdate](https://user-images.githubusercontent.com/50300494/58276102-961a0500-7d64-11e9-99f7-c5a6351027ca.PNG)

The value of the stepsize is a hyper-parameter that is picked by the user in order to obtain the best possible value of w. The two main parameters that determine the optimum value of w is the step size and the gradient. Hence, the graph would still move towards the minimum value even if   was a value of 0, since the slope changes at every iteration. With the inclusion of the step size, if the value of the step size is too small, then the number of iterations that it takes to reach the minimum point of the graph would be too large and the system would be computationally expensive. Alternatively, if the value of the stepsize is too large, the weights will approximate the final value by oscillating around the minimum point of the graph, leading the graph to diverge. Generally, the value of  the stepsize is chosen based on equation (6). Where the value of λ is the maximum eigenvalue of the dataset. 

![Stepsizevalue](https://user-images.githubusercontent.com/50300494/58276163-c2358600-7d64-11e9-9571-96812cf5d189.PNG)

An adaptation of equation (5) was proposed by Widrow where the instantaneous value of the gradient was used as the estimator of the true quantity. Hence, the gradient estimate in equation (5) was transformed as shown in equation (7). 

![Adaptation](https://user-images.githubusercontent.com/50300494/58276248-eee99d80-7d64-11e9-9a0f-c753cab4420f.PNG)

This would then change equation 5 and allow the computation to become significantly less complex as shown in equation (8). 

![Updatedeq](https://user-images.githubusercontent.com/50300494/58276527-b0081780-7d65-11e9-96d9-cc31249c7b49.PNG)

Equation (8) shows the new LMS algorithm for determining the value of w at multiple intervals. A normalized solution to the LMS algorithm was proposed as shown in equation (9) (NLMS) in order to obtain a greater stability with unknown signals and also to ensure that the outliers of the sample data does not deviate the weight update too far from the trajectory. The only disadvantage of the NLMS would be that it requires more computations (3M+1) multiplications when compared to the LMS algorithm due to the reference signal power.

![NLMS](https://user-images.githubusercontent.com/50300494/58276627-e9d91e00-7d65-11e9-90be-27b9d632c7f8.PNG)

Once the appropriate weights are obtained, the error of the signal is compared qualitatively by listening to the speech after the filtering, and quantitatively by computing the echo return loss enhancement (ERLE) measure shown in equation (10). 

![ERLE](https://user-images.githubusercontent.com/50300494/58276658-01b0a200-7d66-11e9-9c90-01125af2d490.PNG)

ERLE is a measure of the performance of the echo cancellation algorithm. A higher value of ERLE would be tantamount to a greater performance of the system. Hence, the objective is to obtain the best value of ERLE by altering the hyper-parameters namely the step-size and the model order. 


## Gamme IIR Filter

Infinite impulse response (IIR) filters are those in which the zeros and poles of the filter can be adapted. They are generally preferred over FIR filters due to the fact that the echo can be synthesized by a relatively smaller number of filter coefficients. The Gamma filter is a special case of a class of linear systems called the feedforward filters. It possesses a general feedforward structure but with the addition of local recursive loops. The Gamma filter is essentially a first order recurrent system. The main working of the Gamma filter is demonstrated in the figure below. 

![gammafilteroutput](https://user-images.githubusercontent.com/50300494/58276748-3e7c9900-7d66-11e9-8985-c7d3c0963e39.PNG)

In an FIR configuration, the signal goes from the input to the output. However, in the case of the Gamma filter, the signal still goes from the input to the output, however there is a return path – making it an IIR filter. The main output of the IIR filter is shown in equation (11).

![IIRoutput](https://user-images.githubusercontent.com/50300494/58276898-90252380-7d66-11e9-802e-ef94203f69a6.PNG)

The output y(n) is the combination of the input x(n), but also with the addition of the previous value of the output. The solution of this equation can be computed given that the initial condition is equal to 0. Hence, when n is a value of 1, y(0)=0. The impulse response of the equation can be computed by solving transfer function in the z domain yielding the output shown in equation (12). 

![Transferfunction](https://user-images.githubusercontent.com/50300494/58276944-a6cb7a80-7d66-11e9-9349-caaf2fd47900.PNG)

From  equation(12) , it is obvious that if the value of   is increased, then the impulse response of the system will decay at a  faster rate. The benefit of the IIR filter is that it can remember every single delay of the input, as opposed to the FIR filter which can only determine a set amount of time delays. The equation in the time domain of y(n) is given in equation (13):

![TimeDomainoutput](https://user-images.githubusercontent.com/50300494/58277021-cd89b100-7d66-11e9-93eb-03f32c91c636.PNG)

Where the values of x(k) are shown in equation (14):

![xk values](https://user-images.githubusercontent.com/50300494/58277067-e5f9cb80-7d66-11e9-8f8b-fa3e45482e12.PNG)

In equation (14) , n denotes the time and k denotes the time of the state variable. For the Gamma filter, to ensure stability, the value of   remains between 0 and 1, and the weights are updated, as before in the FIR filter. 
