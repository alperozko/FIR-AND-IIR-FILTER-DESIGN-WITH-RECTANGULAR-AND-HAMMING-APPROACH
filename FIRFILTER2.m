% EEM 423 Digital Signal Processing / EEM 411 Sayısal İşaret İşleme 
% FIR filter scanning application with Window Approach
%Design Requirements
wc = 0.687;   d1=0.15;   d2=0.1;
wp = 0.314; ws = 0.942; 
% FIR filter coefficients shifted by (M-1)/2
Md = 101; nn = (1:Md)-(Md-1)/2;
h_d = sin(wc*(nn))./(pi*(nn));  h_d((Md-1)/2) = wc/pi;
figure(1),
stem(nn,h_d),grid,axis([-(Md-1)/2 (Md-1)/2 ylim]),xlabel('time,n'),ylabel('h_d(n)'),title('FIR coefficient')
% Let's get the Frequency Response
[Hd,w] = freqz(h_d,1,256);
figure(2)
subplot(211),plot(w/pi/2,abs(Hd),[0 wp/pi/2],(1+d1)*[1 1],'k--',[0 wp/pi/2],(1-d1)*[1 1],'k--',[ws/pi/2 0.5],(d2)*[1 1],'k--'),grid,xlabel('Normalize frekans'),ylabel('Genlik')
subplot(212),plot(w/pi/2,angle(Hd)*180/pi),grid,xlabel('Normalized frequency'),ylabel('Phase')
pause
% Designed FIR filter length
M = 27; 
n = 0:M-1;h_ds = h_d((Md-1)/2-(M-1)/2+(1:M));
% through rectangular window
w_d = ones(1,M);  h_r = w_d.*h_ds; 
figure(3),
stem(n,[h_ds',h_r']),grid,axis([0 M ylim]),xlabel('time,n'),ylabel('h_d(n), h(n)'),title('FIR coefficient')
% Let's get the Frequency Response
[Hr,w] = freqz(h_r,1,256);
figure(4)
subplot(211),plot(w/pi/2,abs([Hd,Hr]),[0 wp/pi/2],(1+d1)*[1 1],'k--',[0 wp/pi/2],(1-d1)*[1 1],'k--',[ws/pi/2 0.5],(d2)*[1 1],'k--'),grid,xlabel('Normalized frequency'),ylabel('amplitute')
subplot(212),plot(w/pi/2,angle([Hd,Hr])*180/pi),grid,xlabel('Normalized frequency'),ylabel('Phase')
pause
% Hamming passed through the window
w_h = 0.54-0.46*cos(2*pi*n/(M-1));   h_h = w_h.*h_ds;   
figure(3),clf
stem(n,[h_ds',h_r',h_h']),grid,axis([0 M ylim]),xlabel('time,n'),ylabel('h_d(n), h(n)'),title(['FIR coefficient, M = ',num2str(M)])
%get the frequency response
[Hh,w] = freqz(h_h,1,256);
figure(4),clf
subplot(211),plot(w/pi/2,abs([Hd,Hr,Hh]),[0 wp/pi/2],(1+d1)*[1 1],'k--',[0 wp/pi/2],(1-d1)*[1 1],'k--',[ws/pi/2 0.5],(d2)*[1 1],'k--'),grid,xlabel('Normalize frekans'),ylabel('Genlik')
legend('wanted','RECTANGULAR','Hamming')
subplot(212),plot(w/pi/2,angle([Hd,Hr,Hh])*180/pi),grid,xlabel('Normalized frequency'),ylabel('Phase')
pause
 
 

