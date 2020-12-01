%% WT/NWT phenotype prediction for beta-lactams using AMR-Diag networks
%Main script for running AMR-Diag networks for prediction of WT/NWT
%phenotype of E.coli and K. pneumoniae towards ceftazidime, cefotaxime, ampicillin(only for e.coli), meropenem, imipenem, ertapenem and colistin

%MATLAB v2018b or higher, Bioinformatics toolbox and Deep Learning and Neural
%Networks toolbox are required

% Give paths to working data
netpath='./net_files'; % specify a path to AMR-Diag working files containing data on BLAKs and networks
workdir='./example/ecoli_example'; %path to a folder with .txt files of lists of 21bp kmers for isolates in question, see formatting in example file under ./example/ecoli_example/129.txt:

% Example of how the file should look like 
% GCGCTTTGCTACCCTATCTGG	8
% GTGCTGTTCGCCGGGCTTCTC	13
% GGCAGCTCAATAAACTGCAGC	6
% TTAACGCGTTTATCGAGGATT	11
% GCATCGCGCTGCCGTGCTGAT	13
% where first column represents a given kmers and 2nd column - its count.
% Note that the file should not have a Header
%% 
%Make a kmer table which will be used for network analysis
test_tabx=create_kmertable(workdir,netpath);
%% 
% Predict the phenotype using the networks
strain='ecoli'; % allowed options: 'ecoli' for E.coli and 'kpneumoniae' for K. pneumoniae
antib='ceftazidime'; % allowed options: 'ceftazidime', 'cefotaxime', 'ampicillin'(only for e.coli), 'meropenem', 'imipenem', 'ertapenem', 'colistin'
predict=predict_res(test_tabx, netpath, strain, antib)