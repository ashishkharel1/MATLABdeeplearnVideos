fullpath2='C:\Users\asis\Desktop\Research\Video cell segmentation- Somayah\';
fullpath2=strcat(fullpath2,'to_rotate.PNG');
test=imread(fullpath2);
alpha=-25;
sz=size(test);
P1=[0 0]';
P2=[sz(1) 0]';
P3=[0 sz(2)]';
P4=[sz(1) sz(2)]';
P1=rot90(P1,2);
P2=rot90(P2,2);
P3=rot90(P3,2);
P4=rot90(P4,2);


RotMatrix = [cosd(alpha) -sind(alpha); sind(alpha) cosd(alpha)]; 
ch1=imrotate(test,alpha);

ImCenterA = size(test(:,:,1))/2;         % Center of the main image
ImCenterB = size(ch1(:,:,1))/2;  % Center of the transformed image
RotatedP1 = RotMatrix*(P1-ImCenterA)+ImCenterB;
RotatedP2 = RotMatrix*(P2-ImCenterA)+ImCenterB;
RotatedP3 = RotMatrix*(P3-ImCenterA)+ImCenterB;
RotatedP4 = RotMatrix*(P4-ImCenterA)+ImCenterB;

final1=[RotatedP1(2) RotatedP1(1)];
final2=[RotatedP2(2) RotatedP2(1)];
final3=[RotatedP3(2) RotatedP3(1)];
final4=[RotatedP4(2) RotatedP4(1)];
z1=final4(1)-final1(1)
z2=final3(2)-final2(2);
cropped1=imcrop(ch1, [final1(1) final2(2) z1 z2]);
imshow(cropped1);
