clear all
close all
load ('EEGEEG_ResultsG.mat')
M1=EEGEEGResultsG(1:5:end,:);
M2=EEGEEGResultsG(2:5:end,:);
M=vertcat(M1,M2);

%Набор двумерных пространств методом главных компонент
[coefPCA,score,latent,tsquared,explained]=pca(M);
coefPCAArr = abs(coefPCA(:,1:3));
coefPCA4x14 = zeros(14,4);
for i = 1:14
    coefPCA4x14(i,:) = abs(coefPCA(4*(i-1)+1:4*(i-1)+4,1));
end
figure; barh(coefPCA4x14,'stacked','DisplayName','coefPCA4x14');
figure;pcolor(coefPCAArr);
colormap jet


Statistics=zeros(9,2);
m=1;
group = [1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2]';
linearCoeff = zeros(9,2);
errStatArray = zeros(9,1);
%Чики-брики человечка выкинь
for n=1:length(score)/2
    Strain=score;
    Strain(n+9,:)=[];
    Strain(n,:)=[];    
    Stest=vertcat(score(n,:),score(n+9,:));
    gtrain=group;
    gtrain(n+9)=[];
    gtrain(n)=[];
    gtest=group([n,n+9]);


                for i =1:1
                    for j=i+1:2
                                figure;
                                            %              scatter(score(1:9,i),score(1:9,j),'rs');
                                            %             hold on
                                            %             scatter(score(10:18,i),score(10:18,j),'b*');
                                            %             title(['Scores of PCA', num2str(i), '-', num2str(j)]);
                                            %             xlabel(num2str(i));
                                            %             ylabel(num2str(j));
                %Начало дискриминатного анализа
                                SL = Strain(:,i);
                                 SW = Strain(:,j);
                                sL=Stest(:,i);
                                sW=Stest(:,j);
                                h1 = gscatter(SL,SW,gtrain,'rb','v^',[],'off');
                                set(h1,'LineWidth',2)
                                legend('Background','Hyperventilation load', 'Location','NW')
                                % [X,Y] = meshgrid(linspace(                                3),linspace(-0.3,0.2));
                                % X = X(:); Y = Y(:);
                              %  [C,err,P,logp,coeff] = classify([X Y],[SL SW],  gtrain,'quadratic');
                                [CL,errL,PL,logpL,coeffL] = classify([sL sW],[SL SW],  gtrain);
                                errStatArray(n) = errL;
                                hold on
                                gscatter(sL,sW,gtest,'rb','*o',[],'off');
                              K = coeffL(1,2).const;
                                                                           L = coeffL(1,2).linear;
                                                                           linearCoeff (n,:) = L;
                                                                         %    Q = coeffL(1,2).quadratic;
                                                                             % Function to compute K + L*v + v'*Q*v for multiple vectors
                                                                             % v=[x;y]. Accepts x and y as scalars or column vectors.
                                                                       f = @(x,y) K + [x y]*L ;
                                                                          h2 = ezplot(f,[-0.4 0.3 -0.3 0.2]);
                                stats = confusionmatStats(gtest,CL);
                                Statistics(n,1)=stats.accuracy(1);
                                Statistics(n,2)=stats.accuracy(2);
%                                           if err>0.056
%                                              close
%                                          else
%                 %                                 Statistics(m)=stats;
%                 %                                 m=m+1;        
%                                                                              hold on;
%                                                                              gscatter(X,Y,C,'rb','.',1,'off');
%                                                                              K = coeff(1,2).const;
%                                                                              L = coeff(1,2).linear;
%                                                                              Q = coeff(1,2).quadratic;
%                                                                              % Function to compute K + L*v + v'*Q*v for multiple vectors
%                                                                              % v=[x;y]. Accepts x and y as scalars or column vectors.
%                                                                              f = @(x,y) K + [x y]*L + sum(([x y]*Q) .* [x y], 2);
%                                                                             h2 = ezplot(f,[-0.4 0.3 -0.3 0.2]);
%                                                                             set(h2,'Color','m','LineWidth',2)
%                                                                             axis([-0.4 0.3 -0.3 0.2])
                                                                            xlabel(['Scores of PCA=', num2str(i)]);
                                                                            ylabel(['Scores of PCA=', num2str(j)]);
                                                                             title(['Classification with ', num2str(i), '-', num2str(j), ' scores of PCA', '  Error=', num2str(errL)]);

                                        end
                end
end
figure;
latent=latent/sum(latent);
plot(1:length(latent),cumsum(latent));

figure;
maxCoeff = max(linearCoeff(1:end));
linearCoeff = linearCoeff / maxCoeff;
boxplot(linearCoeff);


e=2.718281828459045