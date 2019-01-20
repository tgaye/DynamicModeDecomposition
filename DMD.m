clear all, close all, clc

%Dynamic Mode Decomposition (DMD) is similar to PCA, Principal Component
%Analysis.  However it does not have an orthogonality constraint so it is
%able to pull apart individual components of signals better.  Ex:

xi = linspace(-10,10,400); %400 spatial points
t=linspace(0,4*pi,200); %200 time points
dt=t(2)-t(1); %delta time, controls timestepping

[Xgrid, T]=meshgrid(xi,t); %builds grid of X and T(time)

% Observe two distinct signals mixed together, and pull them apart:
f1=sech(Xgrid+3).*(1*exp(i*2.3*T)); % Hyperbolic Secant(sech)
f2=(sech(Xgrid).*tanh(Xgrid)).*(2*exp(i*2.8*T)); % Sech + Tan
f =f1+f2;

% Plot individual signals and their combination:
subplot(2,2,1), surfl(Xgrid, T, real(f1)); shading interp, colormap(gray)
title('signal 1 (sinh)')
subplot(2,2,2), surfl(Xgrid, T, real(f2)); shading interp, colormap(gray)
title('signal 2 (sinh + tan')
subplot(2,2,3), surfl(Xgrid, T, real(f)); shading interp, colormap(gray)
title('Combined (target signal)')

% Can we pull out the 2 source signals from the combined signal? Lets
% compare PCA and DMD:

[u,s,v]=svd(f.'); %support vector decomposition, basically PCA to pull out low-rank structures of signal
figure(2)
plot(diag(s)/(sum(diag(s))),'ro')
title('Factor Components')

% Plot Low Rank Features given from PCA:
figure(3)
subplot(2,1,1), plot(real(u(:,1:2)))
title('Low Rank Structures from PCA')
subplot(2,1,2), plot(real(v(:,1:2)))
title('Time Dynamics of System')

% We can see SVD (or PCA) has pulled out what it deems the most essential
% elements of our signal, however it has not pulled the individual
% components. DMD fixes this, lets try that now:

%===================================================================
% DMD
X=f.'; %transpose of our combined signal
X1=X(:,1:end-1); 
X2=X(:,2:end);

r=2; % rank, # of feature components
[U,S,V]=svd(X1,'econ'); %old friend SVD

% Pull out first R columns of SVD:
Ur=U(:,1:r); 
Sr=S(1:r,1:r);
Vr=V(:,1:r);

Approx=Ur'*X2*Vr/Sr; %least square fit matrix in low dimensional subspace
[W,D]=eig(Approx); %eig functions and values
Phi=X2*Vr/Sr*W; %DMD modes, how we get back to our real fully dimensional output

lambda=diag(D); %eig values are our diagonals of D
omega=log(lambda)/dt;

% Plot Low Rank Features given from DMD:
figure(4)
plot(real(Phi(:,1:2)))
title('Low Rank Features from DMD')

% Build solution iteratively for each timestep:
x1=X(:,1); %next timestep
b=Phi\x1; %models guess at next timestep

%t2=linspace(0,20*pi,200); %optional increase forecast range
time_dynamics=zeros(r,length(t)); %range we want to forecast

for iter=1:length(t)
    time_dynamics(:,iter)=(b.*exp(omega*t(iter)));
end

% Plot our forecast of target:
X_dmd=Phi*time_dynamics;
figure(1)
subplot(2,2,4), surfl(Xgrid, T, real(X_dmd).'); shading interp, colormap(gray)
title('Our Models Future Estimate')
