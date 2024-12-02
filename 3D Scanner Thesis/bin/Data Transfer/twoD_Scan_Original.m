%% enter the information that reuqires to do a 2D scan.

input_axis_2D = 'xy';
len_a = 20;
len_b = 20;
step_a = 20;
step_b = 20;

 if strcmp(input_axis_2D, 'xy') 
                a_axis = 'x';
               
                b_axis = 'y';
            elseif strcmp(input_axis_2D, 'yz') 
                a_axis = 'y';
                b_axis = 'z';
            elseif strcmp(input_axis_2D, 'xz') 
                a_axis = 'x';
                b_axis = 'z';
 end
             step_size_b = step_b;
             step_size_a =  step_a;
             revol_a = abs(len_a/step_a);
             revol_b = abs(len_b/step_b);
            j = 1;
               for i= 1:revol_a
                    if mod(i, 2) == 0
                    str = [num2str(i) '_' num2str(revol_b)];
                    else
                    str = [num2str(i) '_' num2str(1)];
                    end
                    data_generator(str);
                   for j = 2: revol_b
                       if mod(i, 2) == 0
                           w = revol_b - j + 1;
                           str = [num2str(i) '_' num2str(w)];
                        else
                         str = [num2str(i) '_' num2str(j)];
                        end
                       motor_mover(step_size_b,b_axis);
                   
                       data_generator(str);
            
                      
                   end
                       motor_mover(step_size_a,a_axis);
                       
                       step_size_b = -step_size_b;
               end
            
               twoD_plothelper(revol_a,revol_b);

end