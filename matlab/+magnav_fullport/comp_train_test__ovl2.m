% Auto-generated from src/compensation.jl
% Original Julia signature: function comp_train_test(comp_params::CompParams, lines_train, lines_test, df_line::DataFrame, df_flight::DataFrame, df_map::DataFrame; temp_params::TempParams = TempParams(),
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = comp_train_test__ovl2(comp_params, lines_train, lines_test, df_line, df_flight, df_map, varargin)
    out = [];
% TODO(Julia->MATLAB): df_line::DataFrame, df_flight::DataFrame, df_map::DataFrame;
% TODO(Julia->MATLAB): temp_params::TempParams = TempParams(),
% TODO(Julia->MATLAB): silent::Bool            = false)

    (comp_params,y_train,y_train_hat,err_train,features) =
        comp_train(comp_params,lines_train,df_line,df_flight,df_map;
                   temp_params = temp_params,
                   silent      = silent)

    (y_test,y_test_hat,err_test,_) =
        comp_test(comp_params,lines_test,df_line,df_flight,df_map;
                  temp_params = temp_params,
                  silent      = silent)

% return (comp_params, y_train, y_train_hat, err_train,
                         y_test , y_test_hat , err_test , features)
end % function comp_train_test
end
