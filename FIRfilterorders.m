clc;
clear all;
X=importdata('music.txt');
sample=22000;
d=importdata('corrupted_speech.txt');
N=length(X);
u=0.2;
Dk=d(1:N);
filterorder = 5:5:100;
mu = 0.00005:0.00005:0.001;

tic
for M = 1:length(filterorder)
    for stepsize = 1:length(mu)
    
    
    Xk = zeros(N,filterorder(M));
    Wk = zeros(filterorder(M),N-filterorder(M)+1);
    Ek=zeros(1,N);
    Y=zeros(1,N);
    W = zeros(filterorder(M),1);

        
        for i=1:N
            Xk(i,1)=X(i);
            
            for k=2:filterorder(M)
                Xk(i,k) = (1-u)*Xk(max(i-1,1),k) + u*Xk(max(i-1,1),k-1);
                
            end
            %Calculating Error
            
            Y(i)= W'*Xk(i,:)'; %output
            E = Dk(i) - Y(i); %instantaneous error
            Ek(:,i)=E;
            W = W + 2 * mu(stepsize) * E * Xk(i,:)';
            Wk(:,i)=W;
            
        end
        
        D2 = sum(Dk.^2);
        E2 = sum(Ek.^2);
        f = D2/E2;
        erle(M,stepsize) = 10*log10(f);
        MSE(M,stepsize) = mean(Ek.^2);
        display(['Filter order ',num2str(filterorder(M)),' done!']);
        
    end
end
  toc  
  
for i=1:20
    figure,plot(MSE(:,i));
end
