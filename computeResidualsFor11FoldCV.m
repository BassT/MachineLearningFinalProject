function [ residuals ] = computeResidualsFor11FoldCV( A, x, y )
%computeResidualsFor11FoldCV Computes the residuals

residuals = zeros(62,1);

for i = 1:62
    for j = 1:5
        if i == 1
            delta_i = [A(:,1:50) zeros(size(A,1),size(A(:,51:end),2))];
            residuals(i) = norm(y(:,5*(i-1)+j) - delta_i * x);
        elseif i == 62
            delta_i = [zeros(size(A,1),3050) A(:,3051:end)];
            residuals(i) = norm(y(:,5*(i-1)+j) - delta_i * x);
        else
            delta_i = [zeros(size(A,1),(i-1)*50 - 1) ...
                A(:,(i-1)*50:i*50) zeros(size(A,1),(62-i)*50)];
            residuals(i) = norm(y(:,5*(i-1)+j) - delta_i * x);
        end
    end
end

end

