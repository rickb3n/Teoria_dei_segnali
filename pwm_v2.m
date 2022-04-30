clear;
close all;
clc;

Fc = 4000; % Frequenza di campionamento
Tc = 1/Fc;  % Tempo di campionamento
L = 200;   % Lunghezza del segnale (millisecondi)
t = (0:L-1)*Tc; % Vettore del tempo

fp = 200;     %Freq portante
%TP = 1/fp;   %periodo portante
fm = 20;      %Freq mdoulante
%TM = 1/fm;   %Periodo modulante

portante=(((fp*t)-floor(fp*t))); %portante
modulante=((1/2)+((1/2)-(1/20))*sin(2*pi*fm*t)); %modulante
%pwm1=(sign(modulante-portante));
pwm1=((1/2)+(1/2)*sign(modulante-portante)); %comparazione per avere il risultato in pwm
%è stato aggiunto un offset di 1/2 per coerenza con il caso reale.

plot(t,portante,t,modulante,t,pwm1);
title('Dominio del Tempo')
xlabel('Tempo (secondi)')
ylabel('|y(t)|')

NFFT = 2^nextpow2(L); %Il primo p tale che 2p ≥ |L| (2^10=1024)
Y = fft(pwm1,NFFT)/L;
f=(Fc/2)*linspace(0,1,NFFT/2);%costruzione di un vettore di
%punti equispaziati, in un intervallo delle frequenze che cade
%in [0,Fs/2]; ad esempio [0,500]
figure(2),plot(f,2*abs(Y(1:NFFT/2))); %Plot single-sided amplitude spectrum
title('FFT Dominio della frequenza, parte positiva')
xlabel('Frequenza (Hz)')
ylabel('|Y(f)|')