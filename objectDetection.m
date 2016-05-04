%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%Name: Julian Chukwu
%Course: ELG 7172  (SIGNAL PROCESSING Graduate Course by Biomedical Engineering Dept)
%Institution: University of Ottawa
%Session: Winter 2016
%Course Project Title: "Object Detection Using Biologically Motivated Bottom-Up 
%                   Saliency Map Model"

% References for Model and Implemented code below
% ===============================================
%Paper 1: A model of Saliency based visual attention for rapid scene 
%           analysis. [Itti, Koch & Niebur 1998].
%Paper 2: Modeling attention to salient proto-objects. 
%           [Walther & Koch 2006]
%Paper 3: A saliency-based search mechanism for overt and covert 
%           shifts of visual attention. [ Itti & Koch 2000]

%Biologically inspired Paper(Main Paper):   "A face detection using 
%           biologically motivated bottom-up saliency map model 
%           and top-down perception model" [ by Ban, Lee and Yang, 2004].

%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

% NOTE!!!: Color Images for now. Thanks
% NOTE!!!: For best Result, 1024 x 1024 RGB Image prefered.

% Favourite Quote:
% "The whole of science is a refinement of everyday thinking" ..Albert E.

% INSTRUCTION
% ============
% To Run from Command line,
% Initialize "filename" to your "image", then execute "objectDetection"
% Example, 
% % % %           >>  filename = 'object512b.jpg';
% % % %           >>  objectDetection;

if ~any(strcmp(who,'filename'))
clc;
clear all;
close all;
filename = 'object1024.jpg';
end

image = imread(filename);
dobImage = im2double(image);
imSize = size(image);

%Input image is subsampled a Gaussian pyramid reduction to generate guassian pyramid
dobImage = pyramidsGen(dobImage);

%Data Structures for my Image Pyramids
f0 = 'pyramid0'; ze = 'zero';ff = 'fortyfive'; nt = 'ninety'; otf = 'onethirtyfive';
f1 = 'pyramid1';f2 = 'pyramid2';f3 = 'pyramid3';f4 = 'pyramid4';f5 = 'pyramid5';
f6 = 'pyramid6';f7 = 'pyramid7';f8 = 'pyramid8'; RG = 'RG'; BY = 'BY';
R = struct(f0,[],f1,[],f2,[],f3,[],f4,[],f5,[],f6,[],f7,[],f8,[]);
RG = struct(f0,[],f1,[],f2,[],f3,[],f4,[],f5,[],f6,[],f7,[],f8,[]);
BY = struct(f0,[],f1,[],f2,[],f3,[],f4,[],f5,[],f6,[],f7,[],f8,[]);
G = struct(f0,[],f1,[],f2,[],f3,[],f4,[],f5,[],f6,[],f7,[],f8,[]);
B = struct(f0,[],f1,[],f2,[],f3,[],f4,[],f5,[],f6,[],f7,[],f8,[]);
I = struct(f0,[],f1,[],f2,[],f3,[],f4,[],f5,[],f6,[],f7,[],f8,[]);
GabFil = struct(f0,[],f1,[],f2,[],f3,[],f4,[],f5,[],f6,[],f7,[],f8,[]);
% 
% I = imageobj();
if imSize(3) > 2 
    %Image is separated in to different component i.e R, G ,B 
    for i=fieldnames(dobImage)'
        R.(i{1}) = dobImage.(i{1})(:,:,1);
        G.(i{1}) = dobImage.(i{1})(:,:,2);
        B.(i{1}) = dobImage.(i{1})(:,:,3);
        
        %Intensity of each level is found
        I.(i{1}) = (R.(i{1}) + G.(i{1}) + B.(i{1}) )/3; 

        %RG and BY values of each level is found
        [RG.(i{1}) BY.(i{1})] =  generateMaps(R.(i{1}),G.(i{1}),B.(i{1}));
        
%        Un - Comment to see 1st RG and BY Component
%         figure()
%         imshow(RG.(i{1}));
%         imshow(BY.(i{1}));

    end
    
%     Compute Gabor Orientation Pyramid
    figCounter = 1;
    for i = fieldnames(I)'
        GabFil.(i{1}) = gaborFilter(I.(i{1}), figCounter);
        figCounter = figCounter + 1;
    end
     
% Compute 42 Feature Maps. That is 6 Feature Maps for each of the 7 Components
    RGfeatMap = centresurround(RG.pyramid2,RG.pyramid3,RG.pyramid4,RG.pyramid5,RG.pyramid6,RG.pyramid7,RG.pyramid8,'RG Feature Map');
    BYfeatMap = centresurround(BY.pyramid2,BY.pyramid3,BY.pyramid4,BY.pyramid5,BY.pyramid6,BY.pyramid7,BY.pyramid8,'BY Feature Map');
    IntfeatMap = centresurround(I.pyramid2,I.pyramid3,I.pyramid4,I.pyramid5,I.pyramid6,I.pyramid7,I.pyramid8,'Intensity Feature Map');
    GFfeatMapze = centresurround(GabFil.pyramid2.zero,GabFil.pyramid3.zero,GabFil.pyramid4.zero,GabFil.pyramid5.zero,GabFil.pyramid6.zero,GabFil.pyramid7.zero,GabFil.pyramid8.zero,'0 degree Orientation Feature Map');
    GFfeatMapff = centresurround(GabFil.pyramid2.fortyfive,GabFil.pyramid3.fortyfive,GabFil.pyramid4.fortyfive,GabFil.pyramid5.fortyfive,GabFil.pyramid6.fortyfive,GabFil.pyramid7.fortyfive,GabFil.pyramid8.fortyfive,'45 degree Orientation Feature Map');
    GFfeatMapnt = centresurround(GabFil.pyramid2.ninety,GabFil.pyramid3.ninety,GabFil.pyramid4.ninety,GabFil.pyramid5.ninety,GabFil.pyramid6.ninety,GabFil.pyramid7.ninety,GabFil.pyramid8.ninety,'90 degree Orientation Feature Map');
    GFfeatMapotf = centresurround(GabFil.pyramid2.onethirtyfive,GabFil.pyramid3.onethirtyfive,GabFil.pyramid4.onethirtyfive,GabFil.pyramid5.onethirtyfive,GabFil.pyramid6.onethirtyfive,GabFil.pyramid7.onethirtyfive,GabFil.pyramid8.onethirtyfive,'135 degree Feature Map');
    
%    Compute Conspicuity Maps for each of the Linearly separated Component
%    Linear separated Component - Color, Orientation and Intensity
    ColorCons = colConspicMap(RGfeatMap,BYfeatMap);
    OrientationCons = orientationCons(GFfeatMapze,GFfeatMapff,GFfeatMapnt,GFfeatMapotf);
    emptyField = struct();
    IntCons =colConspicMap(IntfeatMap,emptyField);
   
% View the 3 Conspicuity Maps
    figure('Name','Colour Conspicuity Map')
    imshow(ColorCons);title('Colour Conspicuity Map')
    figure('Name','Colour Conspicuity Map')
    imshow(OrientationCons);title('Orientation Conspicuity Map');
    figure('Name','Intensity Conspicuity Map')
    imshow(IntCons);title('Intensity Conspicuity Map');
    
% Compute Saliency Map - 
    SaliencyMap = 1/3*(ColorCons + OrientationCons + IntCons);
    figure('Name','Saliency')
    imshow(SaliencyMap);  title('Saliency Map')

%   Attempt to Model a Winner Take all. - Intuitive Approach.
%   Shows Binary image of the 1st Saliency Position.
    privWTA(SaliencyMap,ColorCons, OrientationCons, IntCons,RGfeatMap,BYfeatMap,IntfeatMap,GFfeatMapze,GFfeatMapff,GFfeatMapnt,GFfeatMapotf);
 
%   Future Work.
%   ===========
%   Simplified Model of the Winner Take All

    pause
    clear all;close all;clc;
end






