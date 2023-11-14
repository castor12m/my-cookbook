function result = getDuplicateIndex(input_data)

    removeIndex = [];
    result = [];

    #input_data = [1234 1234 1235 17 1818181 18181 181 18 1818 18 18 18];

    for index=1:length(input_data)
        start_index = index + 1;
        finish_index = length(input_data);
        result = find(input_data(start_index:finish_index)==input_data(index)) + index;

        if length(result) > 0

            if length(removeIndex) > 0
                duplicate=find(removeIndex==index);

                if length(duplicate) == 0
                    for input_index=1:length(result)
                        removeIndex(length(removeIndex) + 1)=result(input_index);
                    end
                end
            else
                for input_index=1:length(result)
                    removeIndex(length(removeIndex) + 1)=result(input_index);
                end
            end
        end
    end

    removeIndex = sort(removeIndex,'descend');

    for index=1:length(removeIndex)
        #printf("remove index %d\n", removeIndex(index));
        result(length(result) + 1) = removeIndex(index);
    end
    
    result;
    
endfunction