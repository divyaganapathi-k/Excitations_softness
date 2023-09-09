for i=6500:1:6800
    B=double(zeros(1166,1568));
    for j=i:1:i+71
    A=imread(strcat('H:\DF_ML\Images\W4_dedrifted_data\W4_0T_',num2str(j,'%04d'),'.tif'));
    A=imresize(A,2);
    A=double(A);
    B=B+A;
    end
    B=B/72;
    image(B);
    print(strcat('H:\DF_ML\Images\W4_average_data\',num2str(i)),'-dtiff','-r300');
end
