%Initialise J2

clc
clear

mu    = 398600.4415;          % Earth’s gravitational parameter [km^3/s^2]
R_earth = 6378.137 ;          % Earth radius [km]
J2 = 0.0010836;
we = 360*(1 + 1/365.25)/(3600*24);      % Earth's rotation [deg/s]
fname = 'RandomSatTLE.txt';    % TLE file name
% Open the TLE file and read TLE elements
fid = fopen(fname, 'rb');
while ~feof(fid)
% Reading TLE File
L1 = fscanf(fid,'%23c%*s',1);
L2 = fscanf(fid,'%d%6d%*c%5d%*3c%*2f%f%f%5d%*c%*d%5d%*c%*d%d%5d',[1,9]);
L3 = fscanf(fid,'%d%6d%f%f%f%f%f%f%f%f',[1,9]);
epoch       = L2(1,4)*24*3600;        % Epoch Date and Julian Date Fraction
Db          = L2(1,5);                % Ballistic Coefficient
i           = L3(1,3);                % Inclination [deg]
RAAN        = L3(1,4);        % Right Ascension of the Ascending Node [deg]
e           = L3(1,5)/1e7;            % Eccentricity
omega       = L3(1,6);                % Argument of periapsis [deg]
M           = L3(1,7);                % Mean anomaly [deg]
n           = L3(1,8);                % Mean motion [Revs/day]
% Orbital parametres
a = (mu/(n*2*pi/(24*3600))^2)^(1/3);         % Semi-major axis [km]
% T=3600*24;
T = 2*pi*sqrt(a^3/mu);                    % Period in [min]
rp = a*(1-e);
h = (mu*rp*(1 + e))^0.5;                     % Angular momentum
E = keplerEq(M*pi/180,e,eps);
theta =  acos((cos(E) -e)/(1 - e*cos(E)))*180/pi;    % [deg] True anomaly

E = 2*atan(tand(theta/2)*((1-e)/(1+e))^0.5);
M = E  - e*sin(E);
t0 = M/(2*pi)*T;
end
