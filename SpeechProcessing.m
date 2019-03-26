clc
clear all
voice='Digital Speech Data.xls';
r1='A3:A8003';
r2='B3:B1003';
r3='B1003:B2003';
r4='B2003:B3003';
r5='B3003:B4003';
r6='B4003:B5003';
r7='B5003:B6003';
r8='B6003:B7003';
r9='B7003:B8003';


w1=xlsread(voice,r1);
w2=xlsread(voice,r2);
w3=xlsread(voice,r3);
w4=xlsread(voice,r4);
w5=xlsread(voice,r5);
w6=xlsread(voice,r6);
w7=xlsread(voice,r7);
w8=xlsread(voice,r8);
w9=xlsread(voice,r9);

L=size(w1);
N=2^nextpow2(L(1,1));
Ts=0.001;
t=1:8;
fs=1/Ts;
f=fs*((0:(N/2)-1)/(N));

w(:,1)=fft(w2,N);
w(:,2)=fft(w3,N);
w(:,3)=fft(w4,N);
w(:,4)=fft(w5,N);
w(:,5)=fft(w6,N);
w(:,6)=fft(w7,N);
w(:,7)=fft(w8,N);
w(:,8)=fft(w9,N);
mesh(t,f,abs(w(1:512,:)))

