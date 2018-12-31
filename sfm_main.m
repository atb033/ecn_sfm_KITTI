close all; clear; clc;

%% Initialization
addpath(genpath('./devkit'))
base_dir = '../data/2011_09_26/2011_09_26_drive_0046_sync';
calib_dir = '../data/2011_09_26';
 
%% Read and show images
cam = 2; % Color camera
imds = imageDatastore(sprintf('%s/image_%02d/data',base_dir,cam));

% Convert the images to grayscale.
images = cell(1, numel(imds.Files));
for i = 1:numel(imds.Files)
    I = readimage(imds, i);
    images{i} = rgb2gray(I);
end

%% Load camera parameters
calib = loadCalibrationCamToCam(fullfile(calib_dir,'calib_cam_to_cam.txt'));
% Create cameraParameters object from calib
cameraParam = cameraParameters('IntrinsicMatrix',calib.K{cam});

I = images{1};

border = 50;
roi = [border, border, size(I, 2)- 2*border, size(I, 1)- 2*border];

% SUF feature extraction
prevPoints   = detectSURFFeatures(I, 'NumOctaves', 8, 'ROI', roi);
prevFeatures = extractFeatures(I, prevPoints, 'Upright', true);


%% Create a View Set Containing the First View
vSet = viewSet;

% Add the first view. Place the camera associated with the first view
% and the origin, oriented along the Z-axis.
viewId = 1;
vSet = addView(vSet, viewId, 'Points', prevPoints, 'Orientation', ...
    eye(3, 'like', prevPoints.Location), 'Location', ...
    zeros(1, 3, 'like', prevPoints.Location));


%% Add the Rest of the Views

% Display Camera Poses

% Compute Dense Reconstruction

% Display Dense Reconstruction