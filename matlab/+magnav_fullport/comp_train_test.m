% Auto-generated from src/compensation.jl
% Original Julia signature: function comp_train_test(comp_params::CompParams, xyz_train::XYZ, xyz_test::XYZ, ind_train, ind_test, mapS_train::Union{MapS,MapSd,MapS3D} = mapS_null, mapS_test::Union{MapS,MapSd,MapS3D}  = mapS_null; temp_params::TempParams = TempParams(),
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = comp_train_test(comp_params, xyz_train, xyz_test, ind_train, ind_test, mapS_train, MapSd, MapS3D_, mapS_test, MapSd, MapS3D_, varargin)
    out = [];
% TODO(Julia->MATLAB): xyz_train::XYZ, xyz_test::XYZ, ind_train, ind_test,
% TODO(Julia->MATLAB): mapS_train::Union{MapS,MapSd,MapS3D} = mapS_null,
% TODO(Julia->MATLAB): mapS_test::Union{MapS,MapSd,MapS3D}  = mapS_null;
% TODO(Julia->MATLAB): temp_params::TempParams = TempParams(),
% TODO(Julia->MATLAB): silent::Bool            = false)

% TODO(Julia->MATLAB): assert typeof(xyz_train) == typeof(xyz_test) "xyz types do no match"

    (comp_params,y_train,y_train_hat,err_train,features) =
        comp_train(comp_params,xyz_train,ind_train,mapS_train;
                   temp_params = temp_params,
                   silent      = silent)

    (y_test,y_test_hat,err_test,_) =
        comp_test(comp_params,xyz_test,ind_test,mapS_test;
                  temp_params = temp_params,
                  silent      = silent)

% return (comp_params, y_train, y_train_hat, err_train,
                         y_test , y_test_hat , err_test , features)
end % function comp_train_test
end
