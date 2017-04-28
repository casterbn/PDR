%% test case (heading wrong)
% x1: Latitude:31.19841767�� Longitude: 121.58203067�� Heading: 75.7��
% x2: Latitude:31.19841550�� Longitude: 121.58204533�� Heading: 77��

%% test case (heading correct)
% x1: Latitude:31.19925617�� Longitude: 121.58265800�� Heading: 340.3��
% x2: Latitude:31.19926933�� Longitude: 121.58265150�� Heading: 339.2��

%% test case
% x1: Latitude:31.19855650�� Longitude: 121.58227450��
% x2: Latitude:31.19855800�� Longitude: 121.58231717��

%% main test
addpath('.\functions\');

x1_latitude = 31.19855650*pi/180;
x1_longitude = 121.58227450*pi/180;
x1_altitude = 2;

x2_latitude = 31.19855800*pi/180;
x2_longitude = 121.58231717*pi/180;
x2_altitude = 2;

% simple convert (use Rm Rn)
RE = 6378137.0;
esqu = 0.00669437999013;
ave_latitude = (x1_latitude + x2_latitude)/2;
RM = RE * (1 - esqu) / ((1 - esqu * sin(ave_latitude) * sin(ave_latitude))^1.5);
RN = RE / (sqrt(1 - esqu * sin(ave_latitude) * sin(ave_latitude)));

delta_latitude = x2_latitude - x1_latitude;
delta_longitude = x2_longitude - x1_longitude;

delta_N = delta_latitude * RM;
delta_E = delta_longitude * RN * cos(ave_latitude);

simple_convert_heading = atan2(delta_E, delta_N)*180/pi;
if simple_convert_heading < 0
    simple_convert_heading = simple_convert_heading + 360;
end
simple_convert_heading

% restrict convert ��use lla->ECEF->ENU)
x1_lla = [x1_latitude, x1_longitude, x1_altitude];
x2_lla = [x2_latitude, x2_longitude, x2_altitude];

x1_ecef = lla2ecef(x1_lla);
x2_ecef = lla2ecef(x2_lla);
delta_ecef = x2_ecef - x1_ecef;
delta_enu = ecef2enu(x1_lla, delta_ecef);
delta_N = delta_enu(2);
delta_E = delta_enu(1);
restrict_convert_heading = atan2(delta_E, delta_N)*180/pi;
if restrict_convert_heading < 0
   restrict_convert_heading = restrict_convert_heading + 360; 
end
restrict_convert_heading


heading = heading_between_2points(x1_lla, x2_lla);
heading = heading*180/pi;
if heading < 0
    heading = heading + 360;
end
heading














