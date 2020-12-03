if ismac

    addpath('/Users/kcopenhagen/Documents/MATLAB/gitstuff/SlimeDitches');
    addpath('/Users/kcopenhagen/Documents/MATLAB/gitstuff/SlimeDitches/Misc. functions');
    addpath('/Users/kcopenhagen/Documents/MATLAB/gitstuff/SlimeDitches/Videos');
    addpath('/Users/kcopenhagen/Documents/MATLAB/gitstuff/SlimeDitches/Trails');
    addpath('/Users/kcopenhagen/Documents/MATLAB/gitstuff/SlimeDitches/Drift');

    disp('Select data folder.')
    datapath = [uigetdir '/'];

end