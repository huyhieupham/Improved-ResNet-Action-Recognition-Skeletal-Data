function setup(doCompile, matconvnetOpts)


if nargin==0, 
    doCompile = false;
elseif nargin<2, 
    matconvnetOpts = struct('enableGpu', false); 
end

if doCompile && gpuDeviceCount()==0 ...
    && isfield(matconvnetOpts,'enableGpu') && matconvnetOpts.enableGpu, 
    fprintf('No supported gpu detected! ');
    return;
end

addpath(genpath('dataset'));
addpath(genpath('utils'));
addpath(genpath('init'));
% -------------------------------------------------------------------------
%                                                                   vlfeat
% -------------------------------------------------------------------------
if doCompile,
    cmd = 'make -C dependencies/vlfeat/ clean';
    if system(cmd), 
        error('Error while excution: %s', cmd);
    end
    cmd = sprintf('make -C dependencies/vlfeat/ MEX=%s', ...
        fullfile(matlabroot,'bin','mex'));
    if system(cmd), 
        error('Error while excution: %s', cmd);
    end
end
run dependencies/vlfeat/toolbox/vl_setup.m

% -------------------------------------------------------------------------
%                                                               matconvnet
% -------------------------------------------------------------------------
if doCompile, 
    run dependencies/matconvnet/matlab/vl_setupnn.m
    cd dependencies/matconvnet
    vl_compilenn(matconvnetOpts);
    cd ../..
end
run dependencies/matconvnet/matlab/vl_setupnn.m
