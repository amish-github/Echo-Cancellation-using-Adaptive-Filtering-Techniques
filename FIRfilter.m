clc;
clear;
close all;
%Input data music
music = importdata('music.txt');
%Corrupted Speech
corrupted_speech=importdata('corrupted_speech.txt');
fs = 22000;

filterorder = 5:5:100;
mu = [0.00005, 0.00025, 0.001];
Nsamples = length(music);

rep = 1;
Input = repmat(music,1,rep);
corr = repmat(corrupted_speech,1,rep);
SizeofArray = length(Input);


tic
for M = 1:length(filterorder)
    for stepsize = 1:length(mu)
    
%initializing zero matrices
% clear Desired Xk Wk Ek Y w
Desired = corr(filterorder(M):end);
Xk = zeros(filterorder(M), SizeofArray-filterorder(M));
Wk = zeros(filterorder(M), SizeofArray-filterorder(M));
Ek = zeros(1,SizeofArray);
Y = zeros(1,SizeofArray);
w = zeros(filterorder(M) , 1);

%Delay matrix
for i = 1:SizeofArray-filterorder(M)
    Xk(:,i)=Input(i+filterorder(M)-1: -1: i);
end


%Calculate Error and weights   
for k = 1:SizeofArray-filterorder(M)
   Y(k) = Xk(:,k)'*w;
   E = Desired(k) - Y(k);
   Ek(:,k) = E;
   J(k) = E.^2;
   w = w+ 2*mu(stepsize)*E * Xk(:,k)./ ((Xk(:,k)'*Xk(:,k)));
   Wk(:,k) = w;

%end

%w = Wk(:,SizeofArray-M);

end
LearningCurves{M}=J;
D2 = sum(Desired.^2);
E2 = sum(Ek.^2);
f = D2/E2;
erle(M,stepsize) = 10*log10(f);
MSE(M,stepsize) = mean(Ek.^2);

display(['Filter order ',num2str(filterorder(M)),' done!']);
    end
end
toc

figure,plot(filterorder,erle,'-o');hold on;
plot(filterorder,MSE,'-ro');hold off
xlabel('Model orders');
ylabel('Performance Measures');
legend(['ERLE (Step size \mu=',num2str(stepsize),')'],['MSE (Step size \mu=',num2str(stepsize),')']);

for i=1:length(filterorder)
   figure,plot(LearningCurves{i});
   xlabel(['Samples, #epochs = ',num2str(rep)]);
   ylabel('Learning Curves');
   legend(['Filter order M = ',num2str(filterorder(i)),...
       ', Step Size \mu = ',num2str(stepsize)]);
end
