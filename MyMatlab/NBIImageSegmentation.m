function output = doSegmentation(FilePath)
    % doSegmentation - 执行分割
    %
    % Syntax: output = doSegmentation(FilePath);//FilePath为图片路径
    %
    % 执行图像分割的主程序
    %
    % ~~~Start~~~
    %
    % 读取指定目录里的NBI图像
    D = dir([FilePath '*.jpg']);
    for d = 1 : length(D)
        imageName = D(d).name; 
        imgFile = [FilePath,imageName];
        image = imread (imgFile);
        %获取图像的尺寸和波段数(维数)
        [M,N, nDims] = size(image) ;

        i  = imagesub(image);
        gimage = rgb2gray(i);

        %% get the hue_image(color)
        imagehue = hue(i);

        %% get the PIF_image(texture)
        hsi = rgb2hsi(i);
        images = hsi(:,:,3);
        pif = PIF(images);

        %% define the original segmentation curve by yourself
        %m = zeros(size(gimage,1),size(gimage,2));


        %% set parameters
        m = 'large';
        I = i;
        num_iter = 500;
        dt = 0.5; % get stepsize dt
        mu = 0.1; % mu bigger object bigger otherwise smller
        epsilon = 10^(-5);

        lambda_s1 = 1;
        lambda_s2 = 1;
        Is = imagehue;
        method_s = 'chan';

        lambda_l1 = 0.1;
        lambda_l2 = 0.1;
        Il = pif;
        method_l = 'chan';

        %% segmentation using hue_pif model 
        %tic
        % save segmentation curve on the original image
        FileRst = 'D:\PaImage\resultImage\';
        ResultFile = [FileRst,patientID];

        if ~exist(ResultFile, 'dir') 
            mkdir(ResultFile)         % 若不存在，在当前目录中产生一个子目录‘Figure’
        end 
        RstName = strcat(imageName(1:(length(imageName)-4)),'_seg.jpg');
        SaveRst = [ResultFile '\' RstName];

        %seg = evolution_cv(imageName,num_iter,I,m,mu,dt,Is,epsilon,lambda_s1,lambda_s2,method_s,Il,lambda_l1,lambda_l2,method_l);

        seg = evolution_cv(SaveRst,num_iter,I,m,mu,dt,Is,epsilon,lambda_s1,lambda_s2,method_s,Il,lambda_l1,lambda_l2,method_l);

        [subM,subN,nDims] = size(I);
        seg = imresize(seg,[subM subN]);

        %figure, imshow(seg);
        %toc

        %% save the segmental result(binary result)

        imwrite(seg,SaveRst); 

    end
    output=0;
end