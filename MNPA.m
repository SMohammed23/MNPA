%%ELEC 4700 PA 7 MNA Building 
%Saifuddin Mohammed 
%101092039

set(0,'DefaultFigureWindowStyle','docked')
set(0,'defaultaxesfontsize',20)
set(0,'defaultaxesfontname','Times New Roman')
set(0,'DefaultLineLineWidth',2); 
close all



% Given Paramters
R_1 = 1;
C_1 = 0.25;
R_2 = 2;
L = 0.2;
R_3 = 10;
al = 100;
R_4 = 0.1; 
R_0 = 1000; 



%Creating C and G matrices 
 C = zeros(7, 7);
 G = [1 0 0 0 0 0 0; 1/R_1 -((1/R_1) + (1/L)) 1/L 0 0 0 0; 0 1 -1 0 0 0 0; 0 0 1/R_3 0 0 0 -1; 0 0 0 1 0 0 -al; 0 0 0 1 0 -al 0; 0 0 0 1/R_4 -((1/R_4) + (1/R_0)) 0 0];


%Filling the C array as per the differential equations
C(2, 1) = C_1; 
C(2, 2) = -C_1;
C(3, 6) = -L;


V1 = zeros(100, 1);
V_0 = zeros(100, 1);
V3 = zeros(100, 1);

% Setting a 7x1 F matrix 
F = zeros(7, 1);

%Initializng to 0
Volt = 0;



%Perform the DC sweep of input Voltage V1 from -10V to 10V 
%The Voltage VO and V3 will be plotted 

 for V_IN = -10:1:10       %We need to sweep from -10V to 10V
    
    Volt = Volt + 1;
    F(1) = V_IN;
    
    V = G\F;
    
    V1(Volt) = V_IN;
    
    V_0(Volt) = V(5);
    
    V3(Volt) = V(3);
    
    %v = v + 1;
    
end

%Plotting the plot of the DC sweep 
figure(1)
subplot(2,2,1);
plot(V1, V_0, 'r');
hold on;
plot(V1, V3, 'b');
xlabel('V_i_n')
ylabel('V')



F = [10; 0; 0; 0; 0; 0; 0];

V2 = zeros(100, 1); 
w = zeros(1000, 1);
g = zeros(1000, 1);

for ac_F = linspace(0,100,1000)
    
    Volt = Volt+1;
    
    V_f = (G+1j*ac_F*C)\F;
    
    w(Volt) = ac_F;
    
    V2(Volt) = norm(V_f(5));
    
    g(Volt) = norm(V_f(5))/10;
    

    
end 
  
%Plotting the omega v Gain plot
subplot(2,2,2);
plot(w, V2, 'r')
hold on;
plot(w, g, 'b' )
xlim([0 100])
xlabel('w')
ylabel('Gain')



w = pi;        % omega = pi 

Cap_Arry = zeros(100,1);

Gain_Arry = zeros(100,1);

for iter = 1:1000
    
    C_Gen = C_1 + 0.5*randn();
    
    C(2, 1) = C_Gen; 
    
    C(2, 2) = -C_Gen;
    
    C(3, 3) = L;
    
    V_f2 = (G+1i*w*C)\F;
    
    Cap_Arry(iter) = C_Gen;
    
    Gain_Arry(iter) = norm(V_f2(5))/10;
    
end



%Plotting the Histogram Capcitor value and numbers
subplot(2,2,3);
histogram(Cap_Arry,15)
xlabel('C');
ylabel('Number'); 

%Histogram of the Gian 
subplot(2,2,4);
histogram(Gain_Arry,15)
xlabel('V_o / V_i');
ylabel('Number'); 