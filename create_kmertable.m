%% Create a kmer table based on all the kmers that were found in the genomes
function test_tab=create_kmertable(workdir,netpath)
disp('Creating kmer table, please wait...')
load([netpath '/bl_kmers.mat'],'bl_kmers')
list=struct2table(dir([workdir '/*.txt']));

% Get a number of kmers in each file; create a table
test_tab=zeros(height(list),height(bl_kmers));

for i=1:height(list)
    if height(list)==0
        disp('No .txt files were provided in a specified path, please check')
    elseif height(list)==1
         data=readtable([list.folder '/' list.name],'ReadVariableNames',0);
    else
         data=readtable([list.folder{i} '/' list.name{i}],'ReadVariableNames',0);
    end
    [~,ia]=intersect(bl_kmers.Var1,data.Var1);
    test_tab(i,ia)=1;
end
list(:,2:end)=[];

%Remove .txt from the names in the list
for i=1:height(list)
    if height(list)==1
        list.name={erase(list.name,'.txt')};
    else
        list.name(i)=erase(list.name(i,:),'.txt');
    end
end

%save the resulting kmer table as the table
test_tab=array2table(test_tab);
test_tab.Properties.VariableNames=bl_kmers.Var1;
test_tab.Properties.RowNames=list.name;
end