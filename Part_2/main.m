%%%%%%%%%%%%%%%%%%%%%% main_shape_analysis.m file %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose:
%       1. Given image "match1.gif", perform object extraction using bwlabel
%          and calculate the size distribution U(n), pectrum f(n),
%          and complexity H(X|B) for each object. 
%       2. Also, based on the pecstral value, determine the distance as per eqn.(6.11.10) PitasCh6 to
%          match the objects in "match1.gif" to objects in "match3.gif". 
%
% Input Variables:
%       img     "match1.gif"
%
% Returned Results:
%       distance      distance obtained from eqn.(6.11.10) PitasCh6
%
% Processing Flow:
%       1.  Calculate the size distribution, pecstrum and shape complexity of the images
%           function.
%       2.  Determine the distance as per eqn.(6.11.10) PitasCh6 to calculate matching objects.
%
% The functions being called are:      shape_analysis
%                                      compute_distance
%                                      image_cleanup 
%
% Author:      Sweekar Sudhakara, Savinay Nagendra, Nagarjuna Pampana and
%              Prapti Panigrahi
% Date:        2/23/2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc;
clear all;
close all;

% Read Image
img = 'match1.gif';
[Un_ref, Fn_ref, Hxb_ref] = shape_analysis(img, 0, 0);
[m,n] = size(Un_ref);

%Plots
% Figure 1
figure();
hold on;
plot(Un_ref(1,:),'.', 'MarkerSize',24);
plot(Un_ref(1,:));
xlabel('radius');
ylabel('Area');
title('Size distribution of Clover in match1.gif');

% Figure 2
figure();
hold on;
plot(Un_ref(2,:),'.', 'MarkerSize',24);
plot(Un_ref(2,:));
xlabel('radius');
ylabel('Area');
title('Size distribution of Steer in match1.gif');

% Figure 3
figure();
hold on;
plot(Un_ref(3,:),'.', 'MarkerSize',24);
plot(Un_ref(3,:));
xlabel('radius');
ylabel('Area');
title('Size distribution of Aeroplane in match1.gif');

% Figure 4
figure();
hold on;
plot(Un_ref(4,:),'.', 'MarkerSize',24);
plot(Un_ref(4,:));
xlabel('radius');
ylabel('Area');
title('Size distribution of Spade in match1.gif');

% Figure 5
y = [0:1:14];
figure, stem(y, Fn_ref(1,:));
xlabel('radius');
ylabel('Pecstrum Values');
title('Pecstrum of Clover in image match1.gif');

% Figure 6
y = [0:1:14];
figure, stem(y, Fn_ref(2,:));
xlabel('radius');
ylabel('Pecstrum Values');
title('Pecstrum of Steer in image match1.gif');

% Figure 7
y = [0:1:14];
figure, stem(y, Fn_ref(3,:));
xlabel('radius');
ylabel('Pecstrum Values');
title('Pecstrum of Aeroplane in image match1.gif');

% Figure 8
y = [0:1:14];
figure, stem(y, Fn_ref(4,:));
xlabel('radius');
ylabel('Pecstrum Values');
title('Pecstrum of Spade in image match1.gif');

% Object Matching
% Read Image
img = 'match3.gif';
[Un, Fn, Hxb] = shape_analysis(img, 0, 0);

% weights
c_n = [1,1,1,1,1,1,1,0,0,0,0,0,0,0,0];

dist_arr = compute_distance(Fn_ref, Fn, c_n);

% Peanuts Matching
img = 'shadow1.gif';
im_after_correction = image_cleanup(img);
[Un2_ref, Fn2_ref, Hxb2_ref] = shape_analysis(img, 1, im_after_correction);

img = 'shadow1rotated.gif';
im_after_correction = image_cleanup(img);
[Un2, Fn2, Hxb2] = shape_analysis(img, 1, im_after_correction);

% weights
c_n2 = [1,1,1,0.8,0.7,0.1,0,0,0,0,0,0,0,0,0];

dist_arr_peanuts = compute_distance(Fn2_ref, Fn2, c_n2);


