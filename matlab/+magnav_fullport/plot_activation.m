% Auto-generated from src/baseline_plots.jl
% Original Julia signature: function plot_activation(activation = [:relu,:σ,:swish,:tanh]; plot_deriv::Bool  = false, show_plot::Bool   = true, save_plot::Bool   = false, plot_png::String  = "act_func.png")
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = plot_activation(activation, f___, f__swish, f__tanh_, varargin)
    out = [];
% TODO(Julia->MATLAB): plot_deriv::Bool  = false,
% TODO(Julia->MATLAB): show_plot::Bool   = true,
% TODO(Julia->MATLAB): save_plot::Bool   = false,
% TODO(Julia->MATLAB): plot_png::String  = "act_func.png")

    save_plot ? dpi = 500 : dpi = 200

    % setup
    x = LinRange(-6,4,1000)
    p_relu  = relu(x)
    p_σ     = σ(x)
    p_swish = swish(x)
    p_tanh  = tanh(x)

    d_relu  = ForwardDiff.derivative(relu,x)
    d_σ     = ForwardDiff.derivative(σ,x)
    d_swish = ForwardDiff.derivative(swish,x)
    d_tanh  = ForwardDiff.derivative(tanh,x)

% TODO(Julia->MATLAB): if !plot_deriv % plot activation functions
        p1 = plot(xlab="z",ylab="f(z)",xlim=(-6,4),ylim=(-2,4),
% TODO(Julia->MATLAB): legend=:topleft,margin=2*mm,dpi=dpi)
% TODO(Julia->MATLAB): :relu  in activation && plot!(p1,x,p_relu ,lab="ReLU"   ,lw=2,ls=:solid)
% TODO(Julia->MATLAB): :σ     in activation && plot!(p1,x,p_σ    ,lab="sigmoid",lw=2,ls=:solid)
% TODO(Julia->MATLAB): :swish in activation && plot!(p1,x,p_swish,lab="Swish"  ,lw=2,ls=:dash)
% TODO(Julia->MATLAB): :tanh  in activation && plot!(p1,x,p_tanh ,lab="tanh"   ,lw=2,ls=:dot)
    else % plot derivatives of activation functions
        p1 = plot(xlab="z",ylab="f'(z)",xlim=(-6,4),ylim=(-0.5,1.5),
% TODO(Julia->MATLAB): legend=:topleft,margin=2*mm,dpi=dpi)
% TODO(Julia->MATLAB): :relu  in activation && plot!(p1,x,d_relu ,lab="ReLU"   ,lw=2,ls=:solid)
% TODO(Julia->MATLAB): :σ     in activation && plot!(p1,x,d_σ    ,lab="sigmoid",lw=2,ls=:solid)
% TODO(Julia->MATLAB): :swish in activation && plot!(p1,x,d_swish,lab="Swish"  ,lw=2,ls=:dash)
% TODO(Julia->MATLAB): :tanh  in activation && plot!(p1,x,d_tanh ,lab="tanh"   ,lw=2,ls=:dot)
    end
end
