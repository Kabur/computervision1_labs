% test your code by using this simple script

clear
clc
close all

I = imread('peppers.png');

J = ConvertColorSpace(I,'opponent');
 
close all
J2 = ConvertColorSpace(I,'rgb');

close all
J3 = ConvertColorSpace(I,'hsv');

close all
J4 = ConvertColorSpace(I,'ycbcr');
%{
close all
J5 = ConvertColorSpace(I,'gray');
%}