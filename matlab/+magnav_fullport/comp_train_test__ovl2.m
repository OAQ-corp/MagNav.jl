% Auto-generated from src/compensation.jl
% Original Julia signature: function comp_train_test(comp_params::CompParams, lines_train, lines_test, df_line::DataFrame, df_flight::DataFrame, df_map::DataFrame; temp_params::TempParams = TempParams(),
% Mechanical conversion draft: review before production use.
function out = comp_train_test__ovl2(comp_params, lines_train, lines_test, df_line, df_flight, df_map, varargin)
                         df_line::DataFrame, df_flight::DataFrame, df_map::DataFrame;
                         temp_params::TempParams = TempParams(),
                         silent::Bool            = false)

    (comp_params,y_train,y_train_hat,err_train,features) =
        comp_train(comp_params,lines_train,df_line,df_flight,df_map;
                   temp_params = temp_params,
                   silent      = silent)

    (y_test,y_test_hat,err_test,_) =
        comp_test(comp_params,lines_test,df_line,df_flight,df_map;
                  temp_params = temp_params,
                  silent      = silent)

                         y_test , y_test_hat , err_test , features)
end % function comp_train_test
end
