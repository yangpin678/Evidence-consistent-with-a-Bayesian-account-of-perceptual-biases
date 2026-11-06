%% predicted gain and observed gain
load('data_hlm_probit.mat');
sigma_0 = 20; % try other values;
gain_pre = sigma_0.^2./(sigma_0.^2 + tbl.threshold.^2);
tbl.gain_pre = gain_pre;
scatter(tbl.gain_pre,tbl.percept_gain);
hold on;
plot(tbl.gain_pre,tbl.gain_pre);

%
base_model_fml = 'percept_gain ~ dist+slant+stereo+texture+(1|sub)';
base_model_2_fml = 'percept_gain ~ gain_pre+(1|sub)';
alt_model_fml = 'percept_gain ~ dist+slant+stereo+texture+threshold+(1|sub)';
alt_model_2_fml = 'percept_gain ~ dist+slant+stereo+texture+gain_pre+(1|sub)';
base_model = fitlme(tbl,base_model_fml);
base_model_2 = fitlme(tbl,base_model_2_fml);
alt_model = fitlme(tbl,alt_model_fml);
alt_model_2 = fitlme(tbl,alt_model_2_fml);
compare(base_model,alt_model,'CheckNesting',true)
compare(base_model_2,alt_model_2,'CheckNesting',true)
%%
formula1 = 'percept_gain ~ gain_pre+(1|sub)';
lme1 = fitlme(tbl, formula1);

% Display the model summary
disp(lme1);
formula2 = 'percept_gain ~ gain_pre + (gain_pre|sub)';

% Fit the linear mixed-effects model
lme2 = fitlme(tbl, formula2);

% Display the model summary
disp(lme2);
% Compare the two models
compare(lme1, lme2,'CheckNesting',true)
modelComparison = compare(lme1, lme2);
% Extract deviance for each model
deviance_lme1 = -2 * lme1.LogLikelihood;
deviance_lme2 = -2 * lme2.LogLikelihood;

% Extract the chi-square statistic and p-value from the comparison
chi2Stat = modelComparison.LRStat(2);
pValue = modelComparison.pValue(2);

% Display the results
fprintf('Model Comparison Results:\n');
fprintf('-------------------------\n');
fprintf('Model\t\tDeviance\n');
fprintf('lme1\t\t%.2f\n', deviance_lme1);
fprintf('lme2\t\t%.2f\n', deviance_lme2);
fprintf('\n');
fprintf('Chi-square Statistic: %.2f\n', chi2Stat);
fprintf('p-Value: %.4f\n', pValue);
