function output = doDisplay(FilePath)
    % doSegmentation - 显示图片
    %
    % Syntax: output = doDisplay(FilePath);//FilePath为图片路径
    %
    % 测试图像的显示
    imdata=imread(FilePath);
    imshow(imdata);
end