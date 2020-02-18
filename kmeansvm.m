% get all labels
L = csvread('AMLTraining-c.csv',1,0);
label = zeros(179,1);

for k = 1:179
    label(k,1) = L(k * 8,4) ;
end

Path = './CSV';
list=dir(fullfile(Path));

% Nor = zeros(49,156);
% AML = zeros(49, 23);
% Nor_num = 0;
% AML_num = 0;
% AML = zeros(0,7);
% Nor = zeros(0,7);
AMLtube1 = zeros(0,7);AMLtube2 = zeros(0,7);AMLtube3 = zeros(0,7);AMLtube4 = zeros(0,7);
AMLtube5 = zeros(0,7);AMLtube6 = zeros(0,7);AMLtube7 = zeros(0,7);AMLtube8 = zeros(0,7);
Nortube1 = zeros(0,7);Nortube2 = zeros(0,7);Nortube3 = zeros(0,7);Nortube4 = zeros(0,7);
Nortube5 = zeros(0,7);Nortube6 = zeros(0,7);Nortube7 = zeros(0,7);Nortube8 = zeros(0,7);


for n = 0:178
    disp(n)
%     tube8 = csvread(['./CSV/' , list(8 * (n+1) + 2).name], 1, 0);
%     meantube = mean(tube8,1);
%     stdtube = std(tube8,1);
    if label(1,n+1) == 0
        tube = 'Nortube';
    else
        tube = 'AMLtube';
    end
    for k = 1:8
        data = csvread(['./CSV/' , list(8 * n + k +2).name], 1, 0);
        if k == 1
            if label(1,n+1) == 0
                Nortube1 = [Nortube1; data];
            else
                AMLtube1 = [AMLtube1; data];
            end
        end
        if k == 2
            if label(1,n+1) == 0
                Nortube2 = [Nortube2; data];
            else
                AMLtube2 = [AMLtube2; data];
            end
        end
        if k == 3
            if label(1,n+1) == 0
                Nortube3 = [Nortube3; data];
            else
                AMLtube3 = [AMLtube3; data];
            end
        end
        if k == 4
            if label(1,n+1) == 0
                Nortube4 = [Nortube4; data];
            else
                AMLtube4 = [AMLtube4; data];
            end
        end
        if k == 5
            if label(1,n+1) == 0
                Nortube5 = [Nortube5; data];
            else
                AMLtube5 = [AMLtube5; data];
            end
        end
        if k == 6
            if label(1,n+1) == 0
                Nortube6 = [Nortube6; data];
            else
                AMLtube6 = [AMLtube6; data];
            end
        end
        if k == 7
            if label(1,n+1) == 0
                Nortube7 = [Nortube7; data];
            else
                AMLtube7 = [AMLtube7; data];
            end
        end
        if k == 8
            if label(1,n+1) == 0
                Nortube8 = [Nortube8; data];
            else
                AMLtube8 = [AMLtube8; data];
            end
        end
    end
end
%% remove FS SS
AMLtube1 = AMLtube1(:,3:end);
AMLtube2 = AMLtube2(:,3:end);
AMLtube3 = AMLtube3(:,3:end);
AMLtube4 = AMLtube4(:,3:end);
AMLtube5 = AMLtube5(:,3:end);
AMLtube6 = AMLtube6(:,3:end);
AMLtube7 = AMLtube7(:,3:end);
AMLtube8 = AMLtube8(:,3:end);
Nortube1 = Nortube1(:,3:end);
Nortube2 = Nortube2(:,3:end);
Nortube3 = Nortube3(:,3:end);
Nortube4 = Nortube4(:,3:end);
Nortube5 = Nortube5(:,3:end);
Nortube6 = Nortube6(:,3:end);
Nortube7 = Nortube7(:,3:end);
Nortube8 = Nortube8(:,3:end);


%% do kmeans for each tube
k = 10;
tic
[IdxAMLtube1,CAMLtube1] = kmeans(AMLtube1,k,'MaxIter',500);
toc
[IdxAMLtube2,CAMLtube2] = kmeans(AMLtube2,k,'MaxIter',500);
[IdxAMLtube3,CAMLtube3] = kmeans(AMLtube3,k,'MaxIter',500);
[IdxAMLtube4,CAMLtube4] = kmeans(AMLtube4,k,'MaxIter',500);
[IdxAMLtube5,CAMLtube5] = kmeans(AMLtube5,k,'MaxIter',500);
[IdxAMLtube6,CAMLtube6] = kmeans(AMLtube6,k,'MaxIter',500);
[IdxAMLtube7,CAMLtube7] = kmeans(AMLtube7,k,'MaxIter',500);
[IdxAMLtube8,CAMLtube8] = kmeans(AMLtube8,k,'MaxIter',500);

[IdxNortube1,CNortube1] = kmeans(Nortube1,k,'MaxIter',500);
[IdxNortube2,CNortube2] = kmeans(Nortube2,k,'MaxIter',500);
[IdxNortube3,CNortube3] = kmeans(Nortube3,k,'MaxIter',500);
[IdxNortube4,CNortube4] = kmeans(Nortube4,k,'MaxIter',500);
[IdxNortube5,CNortube5] = kmeans(Nortube5,k,'MaxIter',500);
[IdxNortube6,CNortube6] = kmeans(Nortube6,k,'MaxIter',500);
[IdxNortube7,CNortube7] = kmeans(Nortube7,k,'MaxIter',500);
[IdxNortube8,CNortube8] = kmeans(Nortube8,k,'MaxIter',500);
toc

save('compute_result1.mat','CAMLtube*','CNortube*')
%% assign each csv file to clusters
train_data = zeros(160,179);

for n = 0:178
    disp(n)
    all_percent = (160:1);
    for k = 1:8
        data = csvread(['./CSV/' , list(8 * n + k +2).name], 1, 0);
        data = data(:,3:end);
        [~,NorK] = pdist2(eval(['CNortube' int2str(k)]),data,'euclidean','Smallest',1);
        [~,AMLK] = pdist2(eval(['CAMLtube' int2str(k)]),data,'euclidean','Smallest',1);
        Norpercent = tabulate(NorK);...
        Norpercent = Norpercent(:,3);
        AMLpercent = tabulate(AMLK);...
        AMLpercent = AMLpercent(:,3);
        if n == 57
            if size(AMLpercent,1) == 9
                AMLpercent(10,1) = 0;
            end
        end
        percent = [Norpercent;AMLpercent];
        all_percent(20 * (k-1) + 1:20 * k,1) = percent;        
    end
    train_data(:,n + 1) = all_percent; 
end
%% split test/train
randIndex = randperm(179);
data_new=train_data(:,randIndex);
label_new=label(:,randIndex);

split_point = 140;
X1=data_new(:,1:split_point);
Y1=label_new(:,1:split_point);
X2=data_new(:,split_point+1:end);
Y2=label_new(:,split_point+1:end);
%% get
test_data = zeros(160,180);

for n = 179:358
    disp(n)
    all_percent = (160:1);
    for k = 1:8
        data = csvread(['./CSV/' , list(8 * n + k +2).name], 1, 0);
        data = data(:,3:end);
        [~,NorK] = pdist2(eval(['CNortube' int2str(k)]),data,'euclidean','Smallest',1);
        [~,AMLK] = pdist2(eval(['CAMLtube' int2str(k)]),data,'euclidean','Smallest',1);
        Norpercent = tabulate(NorK);...
        Norpercent = Norpercent(:,3);
        AMLpercent = tabulate(AMLK);...
        AMLpercent = AMLpercent(:,3);
        percent = [Norpercent;AMLpercent];
        all_percent(20 * (k-1) + 1:20 * k,1) = percent;        
    end
    test_data(:,n - 178) = all_percent; 
end
%% train svm

Mdl = fitcsvm(train_data',label,'OptimizeHyperparameters','auto',...
'HyperparameterOptimizationOptions',struct('AcquisitionFunctionName',...
'expected-improvement-plus'));

CVSVMModel = crossval(Mdl);
kfoldLoss(CVSVMModel);

predicted_labels = predict(Mdl,test_data');
