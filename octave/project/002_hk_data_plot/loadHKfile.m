function totaldata = loadHKfile(_folder)

    dir_path=sprintf('%s/*.csv', _folder);
    printf('loadHKfile input dir path : %s\n', dir_path);

    csvfiles=dir(dir_path);
    numfiles=length(csvfiles);
    celldata=cell(1,numfiles);

    for k=1:numfiles
        file_path=sprintf('%s/%s', _folder, csvfiles(k).name);
        data=csvread(file_path);
        data(1, :)=[];
        celldata{k, 1}=data;
    end

    totaldata = cell2mat(celldata);
    #disp ("Load Data :"), disp(totaldata);
endfunction