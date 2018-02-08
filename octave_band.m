%% Calculate Octave Bands in Matlab
fcentre = 10^3 * (2 .^ [-6:4]);
fd = 2^(1/2);
fupper = fcentre * fd;
flower = fcentre / fd;

hold on;
plot(fupper);
plot(fcentre);
plot(flower);
hold off;

%% Calculate Third Octave Bands in Matlab
fcentre  = 10^3 * (2 .^ ([-18:13]/3));
fd = 2^(1/6);
fupper = fcentre * fd;
flower = fcentre / fd;

hold on;
plot(fupper);
plot(fcentre);
plot(flower);
hold off;

Nx = 2^16;  % number of samples to synthesize
B = [0.049922035 -0.095993537 0.050612699 -0.004408786];
A = [1 -2.494956002   2.017265875  -0.522189400];
nT60 = round(log(1000)/(1-max(abs(roots(A))))); % T60 est. Audio Decay Time (T60)
v = randn(1,Nx+nT60); % Gaussian white noise: N(0,1)
x = filter(B,A,v);    % Apply 1/F roll-off to PSD
x = x(nT60+1:end);    % Skip transient response

y = fft(x);
pwr = abs(y).^2 / length(x);
plot( log2(1:( length(x)/2 )), log( pwr( 1:( length(x)/2 ) ) ) );
