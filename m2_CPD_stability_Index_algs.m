clc
clear
close all

tic
%%
% The demo shows how tensor spectral clustering can be used to evaluate the
% stability of  results of tensor components analysis.

% The toolbox tensorlab is needed, which are available from:
% https://github.com/GHu-DUT/Tensor_Spectral_Clustering and it should be
% added to path.
%%
Modes = 3;
ResultDir = 'Result';
mkdir('ClusterResult');
for R = 2:3
    R
    for isRun = 1:20
        load([ResultDir filesep 'MO#' num2str(R) filesep '#' num2str(isRun) '.mat']);
        if isRun==1
            for isMode = 1:Modes
                Modedata{isMode} = [];
            end
        end
        for isMode = 1:Modes
            Modedata{isMode} = [Modedata{isMode}  U{isMode}];
        end
    end
    %% Calculation of similarity matrix
    for isMode = 1:Modes
        Sim{isMode} = abs(corr(Modedata{isMode}));
    end
    %% Tensor Spectral Clustering
    [in_avg,partition,P,newspace,CentroidIndex]=f_Tensor_Spectral_Clustering(Sim,R);
    for isMode = 1:Modes
        Centroid{isMode} = Modedata{isMode}(:,CentroidIndex);
    end
    save(['ClusterResult' filesep 'MO#' num2str(R)],'in_avg','Centroid');
end
%%
toc
