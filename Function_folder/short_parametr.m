function rezult = short_parametr(input_parametr, number_element)
 try
    rezult = input_parametr(1,number_element);           
    catch ME
    rezult = input_parametr(1,1);       
end

