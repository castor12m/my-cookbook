###################################################
### [ test ] printf
###################################################
test1 = 0;
if test1 > 0
    printf('test %d\n', 3);

end

###################################################
### [ test ] sprintf
###################################################
test2 = 0;
if test2 > 0

    folder='.';

    string_buffer=sprintf('%s/*.csv', folder);

    printf('string_buffer %s\n', string_buffer);

end

###################################################
### [ test ] sprintf
###################################################
test3 = 1;

remove_row = [];

if test3 > 0

    utc_mat = [1234 1234 1235 17 1818181 18181 181 18 1818 18 18 18];

    for index=1:length(utc_mat)
        start_index = index + 1;
        finish_index = length(utc_mat);
        result = find(utc_mat(start_index:finish_index)==utc_mat(index)) + index;

        if length(result) > 0

            if length(remove_row) > 0
                duplicate=find(remove_row==index);

                if length(duplicate) == 0
                    for input_index=1:length(result)
                        remove_row(length(remove_row) + 1)=result(input_index);
                    end
                end
            else
                for input_index=1:length(result)
                    remove_row(length(remove_row) + 1)=result(input_index);
                end
            end
        end
    end
end

remove_row = sort(remove_row,'descend');

for index=1:length(remove_row)
    printf("remove index %d\n", remove_row(index));
end