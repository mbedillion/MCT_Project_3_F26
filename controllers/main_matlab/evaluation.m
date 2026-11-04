function [grade, scores] = evaluation(minDistList, traj_, X, Y, deltaVec)
    % Evaluate controller performance using the supplied Project 3 rules.
    fprintf('Evaluating...\n');
    % Fall 2026 assignment thresholds (MCT_Project_3_2026.pdf).
    timeBaseline = 200; dt = 0.032; Cmax_cl = 8.0; Cavg = 4.0;
    Cmax_md = 8.0; deltaThreshold = 0.025; fs = 22.5;
    traj = traj_(2:end-60, :);
    comGrad = clGrader(traj, X, Y, fs, Cmax_cl);
    avgGrad = adGrader(minDistList, fs, Cavg);
    maxGrad = mdGrader(minDistList, fs, Cmax_md);
    avgDeltaDeviation = mean(abs(diff(deltaVec)));
    delGrad = deltaGrader(avgDeltaDeviation, fs, deltaThreshold);
    beatBaselineScore = 0.0;
    fprintf('Score for completing the loop: %.2f/%.2f\n', comGrad, fs);
    fprintf('Score for average distance: %.2f/%.2f\n', avgGrad, fs);
    fprintf('Score for maximum distance: %.2f/%.2f\n', maxGrad, fs);
    fprintf('Score for average delta fluctuation: %.2f/%.2f\n', delGrad, fs);
    if comGrad < fs
        fprintf('Your vehicle did not finish the loop.\nYou cannot enter the competition.\n');
    else
        timeCurrent = length(X) * dt;
        beatBaselineScore = beatBaselineGrader(timeCurrent, timeBaseline);
        fprintf('Your time is %.4f\n', timeCurrent);
    end
    grade = avgGrad + maxGrad + comGrad + delGrad + beatBaselineScore;
    scores = [comGrad, avgGrad, maxGrad, delGrad, beatBaselineScore];
    fprintf('Your total score is : %.2f/100.0\n', grade);
end

function score = clGrader(traj, X, Y, fs, Cmax_cl)
    ntrack = size(traj, 1); XY = [X(:), Y(:)]; ng = 0; chunkSize = 256;
    for first = 1:chunkSize:ntrack
        last = min(first + chunkSize - 1, ntrack);
        dx = traj(first:last, 1) - XY(:, 1)';
        dy = traj(first:last, 2) - XY(:, 2)';
        nearest = sqrt(min(dx .^ 2 + dy .^ 2, [], 2));
        ng = ng + sum(nearest <= Cmax_cl);
    end
    score = fs * ng / ntrack;
end

function score = adGrader(minDistList, fs, Cavg)
    averageDistance = mean(minDistList);
    if averageDistance <= Cavg
        score = fs;
    elseif averageDistance <= 2 * Cavg
        score = (-20 / Cavg) * averageDistance + 40;
    else
        score = 0;
    end
end

function score = mdGrader(minDistList, fs, Cmax_md)
    score = fs * sum(minDistList <= Cmax_md) / length(minDistList);
end

function score = deltaGrader(avgDeltaDeviation, fs, threshold)
    if avgDeltaDeviation < threshold
        score = fs;
    elseif avgDeltaDeviation < 2 * threshold
        score = 0.5 * fs;
    else
        score = 0;
    end
end

function score = beatBaselineGrader(timeCurrent, timeBaseline)
    if timeCurrent <= timeBaseline
        score = 10;
    elseif timeCurrent <= 2 * timeBaseline
        score = 20 - 10*timeCurrent/timeBaseline;
    else
        score = 0;
    end
end
