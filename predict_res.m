function pred=predict_res(test_table,netpath,strain, antib)
%load network and featured kmers
disp(['Predicting phenotype for ' strain ', ' antib '...'])
x=load([netpath '/' strain '.mat'],strjoin({strain, antib, 'features'},'_'),...
    strjoin({strain, antib, 'net'},'_'));
feat=x.(strjoin({strain, antib, 'features'},'_'));
net=x.(strjoin({strain, antib, 'net'},'_'));

%% Keep only featured kmers in the table
test_tab=test_table(:,feat.index);
%% Predict class the network
testy=net(table2array(test_tab)');
yind = vec2ind(testy);
class={'wild type'; 'non-wild type'};
score=max(testy)';
pred=table(test_tab.Properties.RowNames,class(yind),score(:,1),...
    'VariableNames',["ID","Predicted class","Probability score"]);
end
