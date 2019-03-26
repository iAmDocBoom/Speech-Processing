close all
clear all

%importing file row and defining range for each bin
voice='DSData.xlsx';
r1='A3:A8003';
r2='B3:B1003';
r3='B1003:B2003';
r4='B2003:B3003';
r5='B3003:B4003';
r6='B4003:B5003';
r7='B5003:B6003';
r8='B6003:B7003';
r9='B7003:B8003';

%dividing the data into bins
w1=xlsread(voice,r2);
w2=xlsread(voice,r3);
w3=xlsread(voice,r4);
w4=xlsread(voice,r5);
w5=xlsread(voice,r6);
w6=xlsread(voice,r7);
w7=xlsread(voice,r8);
w8=xlsread(voice,r9);

L=size(w1); %Size of an individual bin
N=2^nextpow2(L(1,1)); %N=power of 2 closest to the bin size
Ts=0.001; %sampling time
t=1:8;    %range of time
fs=1/Ts;  %Sampling frequency
f=fs*((0:(N/2)-1)/(N)); %Scaled frequency

%DFT of time bins

w(:,1)=fft(w1,N);   %DFT of bin 1
w(:,2)=fft(w2,N);   %DFT of bin 2
w(:,3)=fft(w3,N);   %DFT of bin 3
w(:,4)=fft(w4,N);   %DFT of bin 4
w(:,5)=fft(w5,N);   %DFT of bin 5
w(:,6)=fft(w6,N);   %DFT of bin 6
w(:,7)=fft(w7,N);   %DFT of bin 7
w(:,8)=fft(w8,N);   %DFT of bin 8
figure
stem3(t,f,abs(w(1:512,:)),'marker','none') %3D plot of DFT VS Time
xlabel('Time(S)');
ylabel('Frequency(Hz)');
zlabel('Amplitude');
view([-25,76]);   %rotating the plot for better viewing
title('3D plot of DFT VS Time')

%plot the Frequency VS Amplitude for each second
for i=1:8
    figure
    hold on
    plot(f,abs(w(1:512,i))) 
    %Calculating the formant frequencies
    formax2 = unique(abs(w(1:512,i))); 
    m2=formax2(end-1);
   [pks,pkix]=findpeaks(abs(w(1:512,i)),'MINPEAKHEIGHT',m2-1);
    fmt=f(pkix); 
    axis([0 f(end) 0 (formax2(end)+100)]);
    h=plot(fmt,pks,'s','MarkerSize',5);
    set(h,'MarkerFaceColor','red','color','blue');
    for j=1:2
        text(fmt(j)+10,pks(j),sprintf('F%d : %3.1fHz',j,fmt(j)));
    end
    title(['Frequency vs Amplitude plot for second: ' num2str(i)])
    xlabel('Frequency(Hz)');
    ylabel('Amplitude');
    hold off
    
    %Plotting the graph for formant1 VS formant2
    
    
    str1='Formant1 vs Formant2 for ';
    figure
    axis([0 100 0 300]);
    hold on
    q=plot(fmt(1),fmt(2),'o','markersize',6);
    set(q,'MarkerFaceColor','red','color','red');
    str=sprintf('  F1 : %3.1fHz \n  F2 : %3.1fHz',fmt(1),fmt(2));
    text(fmt(1),fmt(2),str);
    title(['Formant1 vs Formant2 for second : ' num2str(i)]);
    set(get(gca,'title'),'fontsize',12,'fontweight','bold'); 
    xlabel('Formant1 (Hz)','fontsize',10,'fontweight','bold');
    ylabel('Formant2 (Hz)','fontsize',10,'fontweight','bold');
    grid ('on');
    hold off
    axis
    
end




