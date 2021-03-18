clc
clear
close all

tic
%%
% The demo shows how tensor components analysis is applied on
% preprocessed fMRI data. 

% The toolbox tensorlab is needed, which are available from:
% https://www.tensorlab.net/  and it should be added to path.
%%
load Movie_fMRI_data.mat;% (Modes: time by space by subject)
ResultDIR = 'Result';
Runs = 20; % The same decomposition is run 20 times to test the reproducibility of the estimated components 
for MO = 2:20
    MO
    mkdir([ResultDIR filesep 'MO#' num2str(MO)]); 
    options.Initialization = @cpd_rnd;
    options.Algorithm = @cpd_als;
    options.Display = true;
    for isRun = 1:Runs
        [U,output]= cpd(data,MO,options);
        save([ResultDIR filesep 'MO#' num2str(MO) filesep '#' num2str(isRun)],'U','-v7.3');
    end
end
%%
toc

