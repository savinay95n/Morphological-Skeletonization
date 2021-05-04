%%%%%%%%%%%%% main.m file %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose:  
%      Skeletonization
%
% Input Variables:
%      Img             input image
%      
% Returned Results:
%      Large_Disk_Img  large disk image
%      Small_Disk_Img  small disk image
%      Comb_Img        combination of large & small disk image
%
% Processing Flow:
%      1.  Read the image.
%      2.  Convert the image to binary image with threshold of 127
%      3.  Remove the salt & pepper noise from the binary image using median 
%          filter
%      4.  Create disk shape structuring elements with radii 30 & 8
%      5.  Create window based structuring elements with size 35 & 10
%      6.  Perform hit-or-miss transformation to obtain disks with specific
%          size
%      7.  Highlight the disks and save them on the machine
%      8.  Repeat steps 6 & 7 on the binary image containing noise
%
%
% The following functions are called:
%      imread.m              read the image
%      apply_threshold.m     convert the image to a binary image with threshold of 127
%      hit_or_miss_transf.m  perform the hit or miss transform on the denoised binary image
%      imwrite.m             saves the image
%      generate_image.m      generates the object in the image based on the intersection
%      compute_union.m       performs union on the 2 disk shape images
%
% Author:      Sweekar Sudhakara, Savinay Nagendra, Nagarjuna Pampana and
%              Prapti Panigrahi
% Date:        2/5/2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear;      % Clear out all memory 

Img = double(imread('penn256.gif'));
figure; imshow(Img); 

% 3 x 3 SQUARE

Sqr_Struc_Elem = ones(3,3);

[Out_Img, Out_RGB_Img, S_X, count] = skeletonization(Img, Sqr_Struc_Elem, 3, false);
figure; imshow(Out_Img); figure; imshow(Out_RGB_Img);

% 'n_part_ct' decides partial reconstruction and 'n_part_ct' is 1 value greater than 'n'
n_part_ct = 3; % (n+1)
Recon_Img = reconstruction(S_X, Sqr_Struc_Elem, n_part_ct);
figure; imshow(Recon_Img);


% RHOMBUS

Struc_Elem = ones(3,3);
Struc_Elem(1,1) = 0; Struc_Elem(1,3) = 0; Struc_Elem(3,1) = 0; Struc_Elem(3,3) = 0;

[Out_Img, Out_RGB_Img, S_X, count] = skeletonization(Img, Struc_Elem, 3, false);
figure; imshow(Out_Img); figure; imshow(Out_RGB_Img);

n_part_ct = 5; 
Recon_Img = reconstruction(S_X, Struc_Elem, n_part_ct);
figure; imshow(Recon_Img);


% VEC045

Struc_Elem = zeros(3,3);
Struc_Elem(1,3) = 1; Struc_Elem(2,2) = 1;%Struc_Elem(3,1) = 1;

[Out_Img, Out_RGB_Img, S_X, count] = skeletonization(Img, Struc_Elem, 10, false);
figure; imshow(Out_Img); figure; imshow(Out_RGB_Img);

n_part_ct = count; 
Recon_Img = reconstruction(S_X, Struc_Elem, n_part_ct);
figure; imshow(Recon_Img);


%%
clear

Img = double(imread('bear.gif'));
figure; imshow(Img); 

Struc_Elem = ones(3,3);

% [Out_Img, Out_RGB_Img, S_X, count] = skeletonization(Img, Struc_Elem, 3, true);
[Out_Img, Out_RGB_Img, S_X, count] = skeletonization(Img, Struc_Elem);
% figure; imshow(Out_Img);

% count decides partial reconstruction
% count (n_part_ct) is 1 value greater than 'n'
% we can also directly use value of count obtained from skeletonization
% n_part_ct = 6; 
Recon_Img = reconstruction(S_X, Struc_Elem, n_part_ct);
% figure; imshow(Recon_Img);

% RHOMBUS
Struc_Elem = ones(3,3);
Struc_Elem(1,1) = 0; Struc_Elem(1,3) = 0; Struc_Elem(3,1) = 0; Struc_Elem(3,3) = 0;

[Out_Img, Out_RGB_Img, S_X, count] = skeletonization(Img, Struc_Elem);
% figure; imshow(Out_Img);

n_part_ct = count; 
Recon_Img = reconstruction(S_X, Struc_Elem, n_part_ct);
% figure; imshow(Recon_Img);

% VEC045
Struc_Elem = zeros(3,3);
Struc_Elem(2,2) = 1; Struc_Elem(1,3) = 1; 

[Out_Img, Out_RGB_Img, S_X, count] = skeletonization(Img, Struc_Elem);
figure; imshow(Out_Img);

n_part_ct = count; 
Recon_Img = reconstruction(S_X, Struc_Elem, n_part_ct);
% figure; imshow(Recon_Img);
