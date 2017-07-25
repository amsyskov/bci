clear all
close all
load ('X:\bvi\!test\EPOC+\EEGEEG_Results.mat')
M1=EEGEEGResults(1:5:end,:);
M2=EEGEEGResults(3:5:end,:);
M=vertcat(M1,M2);
%Набор двумерных пространств методом главных компонент
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
                          if err>0.15
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
