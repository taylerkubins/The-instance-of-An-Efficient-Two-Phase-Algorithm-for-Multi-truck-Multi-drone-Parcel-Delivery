%% 生成带时间窗的顾客点算例
% 设置顾客数量
n=190;
% 设置时间窗密度
den=0.75;
% 设置时间窗宽度
width=30;
% 设置地图大小
scale=10;
% 设置最长工作时间
Tmax=480;
% 设置顾客点的服务时间
S=10*ones(n,1);
% 无人机速度mph，已变为min
Vd=50/60;  
% 设置顾客点载荷超过无人机载荷的占比
overload=0.1;
% 设置无人机载荷(单位kg)
Q=5;

depot=[0,0];
TW=zeros(n,2);
TW(:,2)=TW(:,2)+Tmax;
Coord=-scale/2+scale*rand(n,2);
a=randperm(n,ceil(den*n));
for i=1:length(a)
    dist=norm(Coord(a(i),:)-depot);
    t=floor(dist/Vd);
    centernum=randperm(Tmax-2*t-S(a(i)),1)+t;
    if centernum<width/2
        TW(a(i),:)=[0,width];
    elseif centernum>Tmax-width/2
        TW(a(i),:)=[Tmax-width,Tmax];
    else
        TW(a(i),:)=[centernum-width/2,centernum+width/2];
    end
end
q=rand(n,1)*Q;
b=randperm(n,ceil(overload*n));
for j=1:length(b)
    q(b(j))=rand(1)*100;
end
%% 将仓库整合进去
Coord=[0,0;Coord];
TW=[0,Tmax;TW];
q=[0;q];
S=[0;S];
%% 将算例导入excel
filename = 'C:\Users\Administrator\Desktop\casebycxl\instance-190customers30-0.75.xlsx';
sheet=1;
xlRange='A2';
xlswrite(filename,Coord(:,1),sheet,xlRange);
xlRange='B2';
xlswrite(filename,Coord(:,2),sheet,xlRange);

xlRange='C2';
xlswrite(filename,q,sheet,xlRange);

xlRange='D2';
xlswrite(filename,TW(:,1),sheet,xlRange);
xlRange='E2';
xlswrite(filename,TW(:,2),sheet,xlRange);

xlRange='F2';
xlswrite(filename,S,sheet,xlRange);
