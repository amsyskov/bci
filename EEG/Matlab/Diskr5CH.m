clear all
close all
load ('X:\bvi\!test\EPOC+\EEGEEG_Results.mat')
F3B=EEGEEGResults(1:5:end,9:12);
F4B=EEGEEGResults(1:5:end,44:47);
T7B=EEGEEGResults(1:5:end,17:20);
T8B=EEGEEGResults(1:5:end,36:39);
OB=(EEGEEGResults(1:5:end,24:27)+EEGEEGResults(1:5:end,28:31))/2;
F3H=EEGEEGResults(3:5:end,9:12);
F4H=EEGEEGResults(3:5:end,44:47);
T7H=EEGEEGResults(3:5:end,17:20);
T8H=EEGEEGResults(3:5:end,36:39);
OH=(EEGEEGResults(3:5:end,24:27)+EEGEEGResults(3:5:end,28:31))/2;
B=horzcat(F3B,F4B,T7B,T8B,OB);
H=horzcat(F3H,F4H,T7H,T8H,OH);
M=vertcat(B,H);

%Начало дискриминатного анализа 
                SL = B(:,[2,6,11,12,15,18]);
                 SW = H(:,[2,6,11,12,15,18]);
                 S=vertcat(SL,SW);
                group = [1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2]';
               [C,err,P,logp,coeff] = classify(S ,S,  group,'quadratic');
               
    [coefPCA,score,latent]=pca(M);
Statistics=cell(0);
m=1;
for i =1:16
    for j=i+1:17
                figure;
                            %              scatter(score(1:9,i),score(1:9,j),'rs');
                            %             hold on
                            %             scatter(score(10:18,i),score(10:18,j),'b*');
                            %             title(['Scores of PCA', num2str(i), '-', num2str(j)]);
                            %             xlabel(num2str(i));
                            %             ylabel(num2str(j));
%Начало дискриминатного анализа
                SL = score(1:18,i);
                 SW = score(1:18,j);
                group = [1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2]';
                h1 = gscatter(SL,SW,group,'rb','v^',[],'off');
                set(h1,'LineWidth',2)
                legend('Background','Hyperventilation load', 'Location','NW')
                 [X,Y] = meshgrid(linspace(-0.4,0.3),linspace(-0.3,0.2));
                 X = X(:); Y = Y(:);
                [C,err,P,logp,coeff] = classify([X Y],[SL SW],  group,'quadratic');
                [CL,errL,PL,logpL,coeffL] = classify([SL SW],[SL SW],  group,'quadratic');
                stats = confusionmatStats(group,CL);
                          if err>0.2
                             close
                         else
%                                 Statistics(m)=stats;
%                                 m=m+1;        
                                                             hold on;
                                                             gscatter(X,Y,C,'rb','.',1,'off');
                                                             K = coeff(1,2).const;
                                                             L = coeff(1,2).linear;
                                                             Q = coeff(1,2).quadratic;
                                                             % Function to compute K + L*v + v'*Q*v for multiple vectors
                                                             % v=[x;y]. Accepts x and y as scalars or column vectors.
                                                             f = @(x,y) K + [x y]*L + sum(([x y]*Q) .* [x y], 2);
                                                            h2 = ezplot(f,[-0.4 0.3 -0.3 0.2]);
                                                            set(h2,'Color','m','LineWidth',2)
                                                            axis([-0.4 0.3 -0.3 0.2])
                                                            xlabel(['Scores of PCA=', num2str(i)]);
                                                            ylabel(['Scores of PCA=', num2str(j)]);
                                                             title(['Classification with ', num2str(i), '-', num2str(j), ' scores of PCA', '  Error=', num2str(err)]);

                        end
end
end
           
                       