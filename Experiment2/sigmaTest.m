load('data_hlm_probit.mat');
% Define candidate sigma_0 values (hyperparameter grid)
sigma_grid = linspace(1, 50, 100);   % adjust range if theoretically needed

% Preallocate fit metrics
AIC    = nan(size(sigma_grid));
BIC    = nan(size(sigma_grid));
logLik = nan(size(sigma_grid));

% Grid search over sigma_0
for i = 1:numel(sigma_grid)

    sigma_0 = sigma_grid(i);

    % Bayesian-predicted perceptual gain
    gain_pre = sigma_0.^2 ./ (sigma_0.^2 + tbl.threshold.^2);
    tbl.gain_pre = gain_pre;

    % Mixed-effects model using predicted gain
    mdl = fitlme(tbl, 'percept_gain ~ gain_pre + (1|sub)');

    % Store model fit statistics
    AIC(i)    = mdl.ModelCriterion.AIC;
    BIC(i)    = mdl.ModelCriterion.BIC;
    logLik(i) = mdl.LogLikelihood;
end

% Identify optimal sigma_0
[~, idx_AIC] = min(AIC);
[~, idx_BIC] = min(BIC);
[~, idx_LL]  = max(logLik);

sigma_opt_AIC = sigma_grid(idx_AIC);
sigma_opt_BIC = sigma_grid(idx_BIC);
sigma_opt_LL  = sigma_grid(idx_LL);

fprintf('Optimal sigma_0 (AIC): %.2f\n', sigma_opt_AIC);
fprintf('Optimal sigma_0 (BIC): %.2f\n', sigma_opt_BIC);
fprintf('Optimal sigma_0 (LogLik): %.2f\n', sigma_opt_LL);

% Approximate confidence interval using ΔAIC ≤ 2
deltaAIC = AIC - min(AIC);
CI = sigma_grid(deltaAIC <= 2);
sigma_CI = [min(CI), max(CI)];

fprintf('Approx. 95%% CI for sigma_0: [%.2f, %.2f]\n', ...
        sigma_CI(1), sigma_CI(2));

% Refit final model using optimal sigma_0 (AIC)
sigma_0 = sigma_opt_AIC;
tbl.gain_pre = sigma_0.^2 ./ (sigma_0.^2 + tbl.threshold.^2);

final_model = fitlme(tbl, 'percept_gain ~ gain_pre + (1|sub)');

disp(final_model);

% Visualization 1: Profile likelihood
figure;
plot(sigma_grid, AIC, 'LineWidth', 2); hold on;
xline(sigma_opt_AIC, '--', 'LineWidth', 1.5);
xlabel('\sigma_0');
ylabel('AIC');
title('Profile likelihood for Bayesian prior variance');
set(gca, 'FontSize', 12);

% Visualization 2: Model prediction vs data
figure;
scatter(tbl.gain_pre, tbl.percept_gain, 25, 'filled', ...
        'MarkerFaceAlpha', 0.3); hold on;
plot([0 1], [0 1], 'k--', 'LineWidth', 1.5);
xlabel('Predicted gain (Bayesian)');
ylabel('Observed perceptual gain');
title(sprintf('Best-fitting \\sigma_0 = %.2f', sigma_0));
axis square;
set(gca, 'FontSize', 12);

%% estimate slant 
data = xlsread("sigma_gain_probit.xlsx",5);
tbl.observed_est = data(:,9);
H_0 =  data(:,10);
slant = tbl.slant.*30+30;
predited_est = tbl.gain_pre.*slant+H_0;
observed_est = tbl.observed_est;
scatter(predited_est,observed_est);

p = polyfit(predited_est, observed_est, 1);

a = p(1);   % slope
b = p(2);   % intercept
xfit = linspace(min(predited_est), max(predited_est), 200);
yfit = polyval(p, xfit);
figure;
scatter(predited_est, observed_est); hold on
plot(xfit, yfit, 'r', 'LineWidth', 2)
xlabel('Predicted estimate')
ylabel('Observed estimate')
fprintf('Observed = %.3f × Predicted + %.3f\n', a, b);
[R, P] = corrcoef(predited_est, observed_est);
r = R(1,2);
yhat = polyval(p, predited_est);
SSres = sum((observed_est - yhat).^2);
SStot = sum((observed_est - mean(observed_est)).^2);
R2 = 1 - SSres/SStot;
