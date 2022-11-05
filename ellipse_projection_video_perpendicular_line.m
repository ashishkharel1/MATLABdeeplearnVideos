% path1='C:\Users\asis\Desktop\Research\Summer 2021\Ring_timing\Extracted Rings\ ';
% filenumbers=[9,455,412,337,320,313,293,283,97,144,232,8,96];
path1='C:\Users\asis\Desktop\Research\Summer 2021\Ring_timing\Batch_converted_matlab\';
path2='C:\Users\asis\Desktop\Research\Summer 2021\Ring_timing\Batch_converted_imagej\';
filenumbers=manualadd';
t0Data=manualadd1';
% x=0;
% brightnessData=0;

array=strings([size(filenumbers,2),2]);

for iteration=1:size(filenumbers,2)
     filenumber=string(filenumbers(iteration));
    filename=strcat('ring',filenumber,'.tif.avi');
    filename1=strcat('ring',filenumber,'.avi');
    
    clear intensityData  x ;
    clear FullIntensityData;
    t0=t0Data(iteration);

    
%     Files=dir(strcat(path1,'\*.avi'));
%     len=size(Files);
%     len= len(1);
    % filename='Control PI_10X_wo Buffer supplement_chan00.avi_cropped_time_1_1';
    % fileext='.avi';
%     for k = 23:33
        fullpath=strcat(path1,filename);
        fullpath2=strcat(path2, filename1);
        vr=VideoReader(fullpath);
        vr1=VideoReader(fullpath2);
    %     array=cell([vr.duration,1]);
        count=0;
        for l=t0-3:t0+3
            count=count+1;
            frame = read(vr,l);
            frame1=read(vr1,l);
            
            frame=rgb2gray(frame);
            frame1=rgb2gray(frame1);
            
           bw=frame;
           
        %     bw=flip(bw);
        %     bw=imrotate(bw,130);
            bw=bw(:,:,1);
            frame1=frame1(:,:,1);
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
                        vertex1=[Xc+ a*cosd(Orien),Yc- a*sind(Orien)];
                        vertex2=[Xc- a*cosd(Orien),Yc+ a*sind(Orien)];
                        m=(vertex1(2)-vertex2(2))/(vertex1(1)-vertex2(1));   %%or tand(Orientation)
                        
                        syms y x;
                        eqn1=y-vertex1(2)==-1/m*(x-vertex1(1));  %perpendicular line
        %                 eqn2=(((x-Xc)*cosd(Orien)+(y-Yc)*sind(Orien))^2)/a^2+(((x-Xc)*sind(Orien)-(y-Yc)*cosd(Orien))^2)/b^2==1;
        %                 eqns=[eqn1 eqn2];
        %                  eqn1=y-299.44==-0.6547*(x-795.87);
        %                 eqn2=((x-580.02)*cosd(33.21)+(y-440.02)*sind(33.21))^2/257.98^2+((x-580.74)*sind(33.21)-(y-440.74)*cosd(33.21))^2/112.61^2==1;
        %                 eqns=[eqn1 eqn2];
        %                 S=solve(eqns,[x,y],'Real',true);
        %                 for vertex=vertex1

                        axis on;
                        hold on;
        %                 plot(S.x(1),S.y(1),'r+', 'MarkerSize', 30, 'LineWidth', 2)
        %                  plot(S.x(2),S.y(2),'r+', 'MarkerSize', 30, 'LineWidth', 2)
        %                 ax1=subplot(2,1,1);

                        plot(vertex1(1),vertex1(2), 'r+', 'MarkerSize', 30, 'LineWidth', 2);
                       plot(vertex2(1),vertex2(2), 'r+', 'MarkerSize', 30, 'LineWidth', 2);
        %                 refline(m,5);



                    %         midPoint=(s(1).Centroid+s(2).Centroid)/2;
                    %         newMajorAxis=pdist([s(1).Centroid ;s(2).Centroid]);
                    %         phi = deg2rad(-s(w).Orientation);
                    %         x = Xc + a*cos(t)*cos(phi) - b*sin(t)*sin(phi);
                    %         y = Yc + a*cos(t)*sin(phi) + b*sin(t)*cos(phi);
                    %         plot(x,y,'r','Linewidth',5)
        %                  h = drawellipse('Center',[Xc Yc],'SemiAxes',[a b], ...
        %                 'RotationAngle',s(w).Orientation,'StripeColor','m');
        %             refline(6,1);
        %                 for x1=1:5:size(bw,2)+1000
                        for x1=20:25

        %                 x1=700;
                   if m>0
                    
                        hLine = images.roi.Line(gca,'Position',[x1 size(bw,1);size(bw,2) -1/m*(size(bw,2)-x1)+size(bw,1)]);
                   else
                         hLine = images.roi.Line(gca,'Position',[x1 size(bw,1);0 -1/m*(0-x1)+size(bw,1)]);
                    end
%                         hLine = images.roi.Line(gca,'Position',[x1 size(bw,1);0 -1/m*(0-x1)+size(bw,1)]);
                          mask =createMask(hLine);
                          maskedImage=frame1;
                          maskedImage(mask==0)=0;
                          [rows] = find(maskedImage > 0);
                          averageIntensity=sum(sum(maskedImage))/size(rows,1);
                          intensityData([1,x1+21])=averageIntensity;
                 


                  
                  
                end
            hold off;
            %         mask = mask | createMask(h);
            %           h = drawellipse('Center',[midPoint(1) midPoint(2)],'SemiAxes',[newMajorAxis/2+s(1).MajorAxisLength/2+s(2).MajorAxisLength/2 b], ...
            %     'RotationAngle',(s(1).Orientation+s(2).Orientation)/2,'StripeColor','m');
%                     mask = mask1 | createMask(hLine);
                    
            %       
        end
    end
%        mask1=uint8(255 * maskedImage);
        %     numBlackPixels = sum(~bw(:));
             
        

        FullIntensityData(count,:)=intensityData;
        end
%          figure('Name',filename);
%             plot(x,brightnessData);
%            [m,i]=max(brightnessData);
%            maxBrightness(1,iteration)=i;
%     end
end
loc1=find(FullIntensityData(1,:)>0,1);
% temp1=FullIntensityData(:,loc1:end);
loc2=find(FullIntensityData(1,:)>0,1,'last');
figure;
heatmap(FullIntensityData(:,loc1:loc2)');
colormap(jet(10));














