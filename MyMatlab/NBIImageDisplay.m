function output = doDisplay(FilePath)
    % doSegmentation - 显示图片
    %
    % Syntax: output = doDisplay(FilePath);//FilePath为图片路径
    %
    % 测试图像的显示
    %
    FilePath='‪C:\Users\Wonerby\Pictures\[三輪士郎]\4a547606df60402b030881c6.jpg';
    imdata=imread(FilePath);
    imshow(imdata);
end