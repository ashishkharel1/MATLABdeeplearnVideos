path1='C:\Users\asis\Desktop\Research\Summer 2021\Ring_timing\';

Files=dir(strcat(path1,'\*.jpg'));
len=size(Files);
len= len(1);
for k = 1:len
    
    fullpath=strcat(path1,Files(k).name);
    bw=imread(fullpath);
%     bw=flip(bw);
%     bw=imrotate(bw,130);
    bw=bw(:,:,1);
    bw3=bw>20;
    imshow(bw3);
%     set(gca,'YDir','normal')


   
    s = regionprops(bw3,{...
        'Centroid',...
        'MajorAxisLength',...
        'MinorAxisLength',...
        'Orientation', 'Extrema'});
    mask = false(size(bw3));
  
    
    for w = 1:length(s)
        a = s(w).MajorAxisLength/2;
        b = s(w).MinorAxisLength/2;
        Xc = s(w).Centroid(1);
        Yc = s(w).Centroid(2);
        Orien=s(w).Orientation;
        if s(w).MajorAxisLength>10
                vertex1=[Xc- a*cosd(Orien),Yc- a*sind(Orien)];
                vertex2=[Xc+ a*cosd(Orien),Yc+ a*sind(Orien)];
                m=(vertex1(2)-vertex2(2))/(vertex1(1)-vertex2(1));   %%or tand(Orientation)
                syms y x;
                eqn1=y-vertex1(2)==-1/m*(x-vertex1(1));  %perpendicular line
                eqn2=(((x-Xc)*cosd(Orien)+(y-Yc)*sind(Orien))^2)/a^2+(((x-Xc)*sind(Orien)-(y-Yc)*cosd(Orien))^2)/b^2==1;
%                 eqns=[eqn1 eqn2];
%                  eqn1=y-299.44==-0.6547*(x-795.87);
%                 eqn2=((x-580.02)*cosd(33.21)+(y-440.02)*sind(33.21))^2/257.98^2+((x-580.74)*sind(33.21)-(y-440.74)*cosd(33.21))^2/112.61^2==1;
                eqns=[eqn1 eqn2];
                S=solve(eqns,[x,y],'Real',true);
                for vertex=vertex1
                
                axis on;
                hold on;
                plot(S.x(1),S.y(1),'r+', 'MarkerSize', 30, 'LineWidth', 2)
                 plot(S.x(2),S.y(2),'r+', 'MarkerSize', 30, 'LineWidth', 2)

                plot(vertex1(1),vertex1(2), 'r+', 'MarkerSize', 30, 'LineWidth', 2);
                plot(vertex2(1),vertex2(2), 'r+', 'MarkerSize', 30, 'LineWidth', 2);


            
            %         midPoint=(s(1).Centroid+s(2).Centroid)/2;
            %         newMajorAxis=pdist([s(1).Centroid ;s(2).Centroid]);
            %         phi = deg2rad(-s(w).Orientation);
            %         x = Xc + a*cos(t)*cos(phi) - b*sin(t)*sin(phi);
            %         y = Yc + a*cos(t)*sin(phi) + b*sin(t)*cos(phi);
            %         plot(x,y,'r','Linewidth',5)
                 h = drawellipse('Center',[Xc Yc],'SemiAxes',[a b], ...
                'RotationAngle',s(w).Orientation,'StripeColor','m');
            hold off;
            %         mask = mask | createMask(h);
            %           h = drawellipse('Center',[midPoint(1) midPoint(2)],'SemiAxes',[newMajorAxis/2+s(1).MajorAxisLength/2+s(2).MajorAxisLength/2 b], ...
            %     'RotationAngle',(s(1).Orientation+s(2).Orientation)/2,'StripeColor','m');
                    mask = mask | createMask(h);
            %       
        end
    end
%        mask1=uint8(255 * mask);
end
%     close all;

double(S.x(1,1))
double(S.y(1,1))
double(S.x(2,1))
double(S.y(2,1))

%%draw a projection

function p=equationOfLine(centroid, orientation)
    vertex1=centroid+ (s(w).MajorAxisLength/2)*(cos(orientation));
    
    
end

function  [x1,y1,x2,y2]=points(a,b,h,k,m,c)
    x1=-(c - (b^2*c + a^2*k*m^2 + b^2*h*m + a*b*m*(a^2*m^2 + b^2 - c^2 - 2*c*h*m + 2*c*k - h^2*m^2 + 2*h*k*m - k^2)^(1/2))/(a^2*m^2 + b^2))/m;
    x2=-(c - (b^2*c + a^2*k*m^2 + b^2*h*m - a*b*m*(a^2*m^2 + b^2 - c^2 - 2*c*h*m + 2*c*k - h^2*m^2 + 2*h*k*m - k^2)^(1/2))/(a^2*m^2 + b^2))/m;
    y1=(b^2*c + a^2*k*m^2 + b^2*h*m + a*b*m*(a^2*m^2 + b^2 - c^2 - 2*c*h*m + 2*c*k - h^2*m^2 + 2*h*k*m - k^2)^(1/2))/(a^2*m^2 + b^2);
    y2=(b^2*c + a^2*k*m^2 + b^2*h*m - a*b*m*(a^2*m^2 + b^2 - c^2 - 2*c*h*m + 2*c*k - h^2*m^2 + 2*h*k*m - k^2)^(1/2))/(a^2*m^2 + b^2);
end


















