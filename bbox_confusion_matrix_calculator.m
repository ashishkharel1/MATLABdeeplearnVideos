number=1;
IOU=0.5;
FP=0;
FN=0;
total_fp=0;
total_tp=0;
total_fn=0;
total=0;

for number=1:100
    t=struct2table(bbox_table_pred{number});
    t1=struct2table(bbox_table_actual{number});
    total=total+size(t1,1);
     data=bboxOverlapRatio(t.BoundingBox,t1.BoundingBox,'min');
     data2=detect_true_positive(data,IOU);
   
     fprintf('True positive is %f \n', data2)
     data1=detect_false_positive(data,IOU,FP);
     fprintf('False positive is %f \n', data1);

     data3=detect_false_negative(data,IOU,FN);
     fprintf('False negative is %f \n', data3);

     total_fp=total_fp+data1;
    total_fn=total_fn+data3;
    total_tp=(total_tp+data2);

%      number=number+1;
end

precision=total_tp/(total_tp+total_fp);
recall=total_tp/(total_tp+total_fn);




% t=struct2table(pred_bbox_table{run});
% bboxOverlapRatio(t.BoundingBox,labeled_bbox.bbox{1},'min')
function FP=detect_false_positive(data,IOU, FP)
%     total_detections=size(data,1);
%     true_detections=sum(sum(data>IOU));
    for k=1:size(data,2)
        if max(data(:,k))<IOU
            FP=FP+1;
        end
    end

%     FP=total_detections-true_detections;

end

function TP= detect_true_positive(data,IOU)
    dataMax=max(data);
      numOverlaps=sum(sum(dataMax>IOU));
     numData=size(data,2);
     TP=numOverlaps;
end


function FN=detect_false_negative(data,IOU,FN)
    for k=1:size(data,2)
        if max(data(:,k))==0
            FN=FN+1;
        end
    end
end


function [total_fp, total_fn, total_tp]= count_all(data1, data2, data3)
    total_fp=total_fp+data1;
    total_fn=total_fn+data3;
    total_tp=(total_tp+data2);
end



